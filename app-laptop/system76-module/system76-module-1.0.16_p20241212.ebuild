# Copyright 2020-2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info linux-mod-r1

GIT_REV=0f05296eb725dcaec30211134e152e9e924a26e4

DESCRIPTION="System76 Driver"
HOMEPAGE="https://github.com/pop-os/system76-dkms"
SRC_URI="https://github.com/pop-os/system76-dkms/archive/${GIT_REV}.tar.gz -> system76-dkms-${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/system76-dkms-${GIT_REV}"

CONFIG_CHECK="
	ACPI_WMI
"

src_compile() {
	local modlist=( "system76=misc" )
	local modargs=( "KERNEL_DIR=${KERNEL_DIR}" )

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	insinto /lib/udev/hwdb.d
	doins lib/udev/hwdb.d/*
}
