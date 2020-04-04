# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

REPO_NAME="${PN%-driver}-dkms"
REPO_NV="${REPO_NAME}-${PV}"

DESCRIPTION="System76 ACPI Driver"
HOMEPAGE="https://github.com/pop-os/${REPO_NAME}"
SRC_URI="https://github.com/pop-os/${REPO_NAME}/archive/${PV}.tar.gz -> ${REPO_NV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${REPO_NV}"

MODULE_NAMES="system76_acpi(misc:${S})"
BUILD_TARGETS="clean all"

src_install() {
	linux-mod_src_install

	insinto /lib/udev/hwdb.d
	doins lib/udev/hwdb.d/*
}
