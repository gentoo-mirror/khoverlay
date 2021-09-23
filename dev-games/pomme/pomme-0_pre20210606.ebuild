# Copyright 2021 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN=Pomme
GIT_REV=1495c647fd604084b3dd493544d7af4fda90457a

DESCRIPTION="Portable implementation of the Macintosh Toolbox API"
HOMEPAGE="https://github.com/jorio/${MY_PN}"
SRC_URI="https://github.com/jorio/${MY_PN}/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT LGPL-2.1+ BSD Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/libsdl2
"
DEPEND="${RDEPEND}"

DOCS=( README.md )

S="${WORKDIR}/${MY_PN}-${GIT_REV}"

src_install() {
	dolib.so "${BUILD_DIR}/libPomme.so"

	(
		cd "${S}/src"
		while read -r headerPath; do
			insinto "/usr/include/${MY_PN}/$(dirname "$headerPath")"
			doins "$headerPath"
		done < <(find . -name '*.h')
	)

	einstalldocs
}
