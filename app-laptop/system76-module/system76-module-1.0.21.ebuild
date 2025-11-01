# Copyright 2020-2025 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info linux-mod-r1

GIT_REV=

DESCRIPTION="System76 kernel driver (hotkeys, fan control on some laptops)"
HOMEPAGE="https://github.com/pop-os/system76-dkms"
if [[ -n "${GIT_REV}" ]]; then
	SRC_URI="https://github.com/pop-os/system76-dkms/archive/${GIT_REV}.tar.gz -> system76-dkms-${PV}.tar.gz"
else
	SRC_URI="https://github.com/pop-os/system76-dkms/archive/refs/tags/${PV}.tar.gz -> system76-dkms-${PV}.tar.gz"
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

if [[ -n "${GIT_REV}" ]]; then
	S="${WORKDIR}/system76-dkms-${GIT_REV}"
else
	S="${WORKDIR}/system76-dkms-${PV}"
fi

CONFIG_CHECK="
	ACPI_WMI
"

src_compile() {
	local modlist=( "system76=misc:.:src" )
	local modargs=( "KERNEL_DIR=${KERNEL_DIR}" )

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	insinto /usr/lib/udev/hwdb.d
	doins lib/udev/hwdb.d/*
}
