# Copyright 2020-2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

REPO_NAME="${PN%-module}-dkms"
REPO_NV="${REPO_NAME}-${PV}"

DESCRIPTION="System76 I/O Board Driver"
HOMEPAGE="https://github.com/pop-os/${REPO_NAME}"
SRC_URI="https://github.com/pop-os/${REPO_NAME}/archive/${PV}.tar.gz -> ${REPO_NV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${REPO_NV}"

src_compile() {
	local modlist=( "system76-io=misc" "system76-thelio-io=misc" )
	local modargs=( "KERNEL_DIR=${KERNEL_DIR}" )

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	# The system76-io module is present and loaded on Pop!_OS for darp6
	# in 2020, but it doesn't seem to load on its own on Gentoo.  So we
	# install a file to ask it to load.
	#
	# Not sure about system76-thelio-io, but let's have it autoload too.
	insinto /usr/lib/modules-load.d
	newins "${FILESDIR}/system76-io+thelio.conf" system76-io.conf
}
