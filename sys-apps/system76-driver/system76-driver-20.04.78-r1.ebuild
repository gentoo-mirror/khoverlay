# Copyright 2020-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=no
inherit distutils-r1 systemd

DESCRIPTION="Universal driver for System76 computers"
HOMEPAGE="https://github.com/pop-os/system76-driver"
SRC_URI="https://github.com/pop-os/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="
	bluetooth
	lm-sensors
	+modules
	networkmanager
	+suspend-workarounds
	systemd
	video_cards_nvidia
"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	suspend-workarounds? ( systemd )
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
	$(python_gen_cond_dep 'dev-python/python-evdev[${PYTHON_USEDEP}]')
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
		sys-apps/systemd
		bluetooth? ( sys-apps/util-linux )
		networkmanager? ( net-misc/networkmanager )
	)
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/system76-driver-20.04.69-gentoo.patch"
)

src_install() {
	distutils-r1_src_install

	# See system76-driver.git/debian/system76-driver.install.
	dobin "${S}/system76-driver-pkexec"
	python_doscript "${S}/system76-daemon"
	python_doscript "${S}/system76-user-daemon"
	insinto /usr/share/polkit-1/actions
	doins "${S}/com.system76.pkexec.system76-driver.policy"
	insinto /etc/xdg/autostart
	doins "${S}/system76-user-daemon.desktop"

	if use suspend-workarounds; then
		local utildir
		utildir=$(systemd_get_utildir) || die "Couldn't read systemd utildir."
		exeinto "${utildir}/system-sleep"

		doexe "${S}/system76-thunderbolt-reload"
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
	elog "Run system76-driver or system76-driver-cli as root to apply settings for"
	elog "your specific System76 hardware.  system76-driver launches a GTK+ UI where"
	elog "you can see which actions will be taken.  system76-driver-cli runs entirely"
	elog "from the command line and prints out actions taken, but does not ask for"
	elog "confirmation."
	elog ""
	elog "    # system76-driver-cli"
	elog ""
	elog "You may want to enable the System76 daemon to enable further hardware"
	elog "support and fixes.  For systemd users:"
	elog ""
	elog "    # systemctl enable --now system76-driver.service"
	elog ""
	elog "An experimental OpenRC runscript is also provided:"
	elog ""
	elog "    # rc-update add system76-driver default"
}
