# Copyright 2020-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

GIT_REV=ed0112437f85665b6473dbeb1229b4850c8635ef

DESCRIPTION="System76 ACPI Driver"
HOMEPAGE="https://github.com/pop-os/system76-acpi-dkms"
SRC_URI="https://github.com/pop-os/system76-acpi-dkms/archive/${GIT_REV}.tar.gz -> system76-acpi-dkms-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/system76-acpi-dkms-${GIT_REV}"

MODULE_NAMES="system76_acpi(misc:${S})"
BUILD_TARGETS="clean all"
BUILD_PARAMS="KERNEL_DIR=${KERNEL_DIR}"

src_install() {
	linux-mod_src_install

	insinto /lib/udev/hwdb.d
	doins lib/udev/hwdb.d/*
}
