# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info linux-mod

GIT_REV=2712136b19eed75bff01c1a6ffe2a23daf78a7bb

DESCRIPTION="Nintendo HID kernel module for Linux <5.16"
HOMEPAGE="https://github.com/nicman23/dkms-hid-nintendo"
SRC_URI="https://github.com/nicman23/dkms-hid-nintendo/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+joycond"

DEPEND=""
RDEPEND="joycond? ( games-util/joycond )"

S="${WORKDIR}/dkms-hid-nintendo-${GIT_REV}"

CONFIG_CHECK="!HID_NINTENDO"

MODULE_NAMES="hid-nintendo(hid:${S}/src)"
BUILD_TARGETS="clean modules"
BUILD_PARAMS="-C ${KERNEL_DIR} M=${S}/src"

pkg_pretend() {
	if kernel_is -ge 5 16; then
		# Abort; building this fails against e.g. gentoo-sources-5.16.11.
		eerror "Linux 5.16 and newer have ${CATEGORY}/${PN} in-tree."
		eerror "Set CONFIG_HID_NINTENDO=y rather than using this package."
		die "Out-of-tree ${CATEGORY}/${PN} is not suitable for Linux 5.16."
	elif ! kernel_is -ge 5 15; then
		ewarn "${CATEGORY}/${P} has only been tested on Linux 5.15."
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

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
