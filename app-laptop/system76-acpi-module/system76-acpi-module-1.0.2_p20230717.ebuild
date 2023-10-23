# Copyright 2020-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

GIT_REV=03a5804847a64fd977989316ea25082e2766723e

DESCRIPTION="System76 ACPI Driver"
HOMEPAGE="https://github.com/pop-os/system76-acpi-dkms"
SRC_URI="https://github.com/pop-os/system76-acpi-dkms/archive/${GIT_REV}.tar.gz -> system76-acpi-dkms-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/system76-acpi-dkms-${GIT_REV}"

src_compile() {
	local modlist=( "system76_acpi=misc" )
	local modargs=( "KERNEL_DIR=${KERNEL_DIR}" )

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	insinto /lib/udev/hwdb.d
	doins lib/udev/hwdb.d/*
}
