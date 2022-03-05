# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

DESCRIPTION="Nintendo HID kernel module"
HOMEPAGE="https://github.com/nicman23/dkms-hid-nintendo"
SRC_URI="https://github.com/nicman23/dkms-hid-nintendo/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+joycond"

DEPEND=""
RDEPEND="joycond? ( games-util/joycond )"

S="${WORKDIR}/dkms-hid-nintendo-${PV}"

MODULE_NAMES="hid-nintendo(hid:${S}/src)"
BUILD_TARGETS="clean modules"
BUILD_PARAMS="-C ${KERNEL_DIR} M=${S}/src"

pkg_postinst() {
	elog "Please make sure that joycond is running, for proper Joy-Con pairing support."
	elog "With OpenRC:"
	elog
	elog "    # rc-update add joycond default"
	elog "    # /etc/init.d/joycond start"
	elog
	elog "With systemd:"
	elog
	elog "    # systemctl enable --now joycond"
	elog
	elog "With this package installed, you can ignore the following complaint when building"
	elog "games-util/joycond:"
	elog
	elog "  CONFIG_HID_NINTENDO:   is not set when it should be."
}
