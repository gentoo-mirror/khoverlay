# Copyright 2020-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info linux-mod-r1

REPO_NAME="${PN%-module}-dkms"
REPO_NV="${REPO_NAME}-${PV}"

DESCRIPTION="System76 Driver"
HOMEPAGE="https://github.com/pop-os/${REPO_NAME}"
SRC_URI="https://github.com/pop-os/${REPO_NAME}/archive/${PV}.tar.gz -> ${REPO_NV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${REPO_NV}"

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
