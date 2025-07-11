# Copyright 2020-2025 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 systemd virtualx

DESCRIPTION="Universal driver for System76 computers"
HOMEPAGE="https://github.com/pop-os/system76-driver"
SRC_URI="https://github.com/pop-os/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="
	bluetooth
	elogind
	lm-sensors
	+modules
	networkmanager
	+suspend-workarounds
	systemd
	video_cards_nvidia
"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	suspend-workarounds? ( ^^ ( systemd elogind ) )
"

# We skip the Debian package's hard dependency on system76-wallpapers.
# It's only used for gsettings overrides, which we don't install anyway.
# x11-themes/system76-wallpapers can be installed separately if desired.
#
# We also skip depending on python-systemd.  Upstream declares a
# dependency on python3-systemd in debian/control, but looking at the
# code, actual use of the package appears to have been added with the
# dependency in 18.04.23, and then removed without dropping the
# dependency in 18.10.3.
RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/dbus-python[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/evdev[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pygobject:3[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/distro[${PYTHON_USEDEP}]')
	net-wireless/wireless-tools
	lm-sensors? ( sys-apps/lm-sensors )
	sys-process/at
	x11-apps/xbacklight
	modules? (
		app-laptop/system76-acpi-module
		app-laptop/system76-io-module
		app-laptop/system76-module
	)
	suspend-workarounds? (
		elogind? ( sys-auth/elogind )
		systemd? ( sys-apps/systemd )
		bluetooth? ( sys-apps/util-linux )
		networkmanager? ( net-misc/networkmanager )
	)
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/system76-driver-20.04.69-gentoo.patch"
	"${FILESDIR}/system76-driver-20.04.85-test-tmpdir.patch"
)

src_test() {
	virtx distutils-r1_src_test
}

python_test() {
	esetup.py test --verbose
}

src_install() {
	distutils-r1_src_install

	# See system76-driver.git/debian/system76-driver.install.
	python_doscript "${S}/system76-daemon"
	python_doscript "${S}/system76-user-daemon"
	insinto /usr/share/polkit-1/actions
	doins "${S}/com.system76.pkexec.system76-driver.policy"
	insinto /etc/xdg/autostart
	doins "${S}/system76-user-daemon.desktop"

	if use suspend-workarounds; then
		local utildir
		if use systemd; then
			utildir=$(systemd_get_utildir) || die "Couldn't read systemd utildir."
		elif use elogind; then
			utildir=$(get_libdir)/elogind || die "Couldn't read system libdir."
		else
			die "Unknown configuration for suspend-workarounds."
		fi
		exeinto "${utildir}/system-sleep"

		doexe "${S}/system76-thunderbolt-reload"
		doexe "${S}/system76-virtual-hub"
		if use bluetooth; then
			doexe "${S}/lib/systemd/system-sleep/system76-driver_bluetooth-suspend"
		fi
		if use networkmanager; then
			doexe "${S}/system76-nm-restart"
		fi
	fi

	systemd_dounit "${S}/debian/system76-driver.service"

	newinitd "${FILESDIR}/${PN}.openrc" "${PN}"
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Run system76-driver or system76-driver-cli as root to apply settings for"
		elog "your specific System76 hardware.  system76-driver launches a GTK+ UI where"
		elog "you can see which actions will be taken.  system76-driver-cli runs entirely"
		elog "from the command line and prints out actions taken, but does not ask for"
		elog "confirmation."
		elog ""
		elog "    # system76-driver-cli"
		elog ""
		elog "You may want to run the System76 daemon to enable further hardware support"
		elog "and fixes:"
		elog ""
		elog "    # systemctl enable --now system76-driver.service  (systemd)"
		elog "    # rc-update add system76-driver default           (OpenRC)"
		elog ""
		elog "This message is only displayed the first time system76-driver is installed."
	elif ! use suspend-workarounds && ! use systemd; then
		local ver
		for ver in ${REPLACING_VERSIONS}; do
			if ver_test "${ver}" -lt 20.04.90; then
				elog "Starting with version 20.04.90, the system76-driver ebuild supports"
				elog "USE=suspend-workarounds via elogind, not only systemd.  If you are an"
				elog "elogind user, consider enabling the suspend workarounds for better"
				elog "support of your System76 hardware."
				break
			fi
		done
	fi
}
