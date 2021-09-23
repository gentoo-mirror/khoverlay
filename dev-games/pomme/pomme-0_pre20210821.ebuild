# Copyright 2021 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN=Pomme
GIT_REV=b9ddab06cdc0b9e4a8085e50974213b6c9625436

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

PATCHES=(
	"${FILESDIR}/${PN}-0_pre20210821-build.patch"
)

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
