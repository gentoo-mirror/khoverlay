# Copyright 2021-2025 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

GIT_REV=69ee58bd06d4e9ab76b472c15ca5b6e06672be73

DESCRIPTION="Portable implementation of the Macintosh Toolbox API"
HOMEPAGE="https://github.com/jorio/Pomme"
SRC_URI="https://github.com/jorio/Pomme/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT CC0-1.0 LGPL-2.1+ BSD Boost-1.0"
SLOT="20250201"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/libsdl3
"
DEPEND="${RDEPEND}"

DOCS=( README.md )

S="${WORKDIR}/Pomme-${GIT_REV}"

src_install() {
	exeinto "/usr/$(get_libdir)/Pomme-${SLOT}"
	doexe "${BUILD_DIR}/libPomme.so"

	(
		cd "${S}/src"
		while read -r headerPath; do
			insinto "/usr/include/Pomme-${SLOT}/$(dirname "$headerPath")"
			doins "$headerPath"
		done < <(find . -name '*.h')
	)

	einstalldocs
}
