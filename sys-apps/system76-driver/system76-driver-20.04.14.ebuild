# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=no
inherit distutils-r1 systemd

DESCRIPTION="Universal driver for System76 computers"
HOMEPAGE="https://github.com/pop-os/system76-driver"
SRC_URI="https://github.com/pop-os/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+modules video_cards_nvidia"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# We skip the Debian package's hard dependency on system76-wallpapers.
# It's only used for gsettings overrides, which we don't install anyway.
# x11-themes/system76-wallpapers can be installed separately if desired.
RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/dbus-python[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/python-evdev[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pygobject:3[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/distro[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/python-systemd[${PYTHON_USEDEP}]')
	sys-process/at
	sys-power/pm-utils
	x11-apps/xbacklight
	modules? (
		app-laptop/system76-acpi-module
		app-laptop/system76-io-module
		app-laptop/system76-module
	)
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/system76-driver-20.04.13-gentoo-patches-20200911.patch"
)

src_install() {
	distutils-r1_src_install

	# See system76-driver.git/debian/system76-driver.install.
	dobin "${S}/system76-driver-pkexec"
	python_doscript "${S}/system76-daemon"
	python_doscript "${S}/system76-user-daemon"
	insinto /usr/share/polkit-1/actions
	doins "${S}/com.system76.pkexec.system76-driver.policy"
	insinto /lib/systemd/system-sleep
	doins "${S}/system76-thunderbolt-reload"
	insinto /etc/xdg/autostart
	doins "${S}/system76-user-daemon.desktop"

	# We choose not to install system76-nm-restart.  It restarts
	# NetworkManager when resuming from sleep, citing reliability issues
	# with Haswell (2013) but not with Skylake (2015).  This is a while
	# ago and the script restarts NM unconditionally, without checking
	# hardware versions, so let's not do this unless it's necessary.

	systemd_dounit "${S}/debian/system76-driver.service"
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
	elog "support and fixes."
	elog ""
	elog "    # systemctl enable --now system76-driver.service"
}
