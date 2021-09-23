# Copyright 2021 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN=Quesa
GIT_REV=5479c257d50757c9dd2060f9b09bec5c7655ed58

DESCRIPTION="Reimplementation of Apple's QuickDraw 3D APIs"
HOMEPAGE="https://github.com/jorio/${MY_PN}"
SRC_URI="https://github.com/jorio/${MY_PN}/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="${RDEPEND}"

DOCS=( README.md )

S="${WORKDIR}/${MY_PN}-${GIT_REV}"

src_install() {
	dolib.so "${S}/SDK/Libraries/Linux/x86_64/${CMAKE_BUILD_TYPE}/libQuesa_SDL.so"

	insinto /usr/include/"${MY_PN}"
	doins -r "${S}"/SDK/Includes/Quesa/*

	einstalldocs
}
