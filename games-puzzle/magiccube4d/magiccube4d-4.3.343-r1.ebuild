# Copyright 2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 java-pkg-simple

DESCRIPTION="4D Rubik's Cube and other twisty puzzles"
HOMEPAGE="https://superliminal.com/cube/"
SRC_URI="https://github.com/cutelyaware/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="magiccube4d"
# Note, SLOT=java causes the launcher to be called magiccube4d-java.
SLOT="java"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jdk-1.8:*"
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/${P}"

DOCS=( README.md )

JAVA_SRC_DIR=( src/java )
JAVA_RESOURCE_DIRS=( src/resources )
JAVA_MAIN_CLASS=com.superliminal.magiccube4d.MC4DLauncher

src_prepare() {
	# Split sources and resources into separate directories.
	mkdir "${S}"/src/{java,resources} || die
	mv "${S}"/src/com "${S}"/src/java/com || die
	mv "${S}"/src/*.* "${S}"/src/resources || die

	default
	java-pkg-2_src_prepare
}

src_install() {
	default
	java-pkg-simple_src_install
	doicon "${S}/src/resources/mc4d.png"
	make_desktop_entry "${PN}-${SLOT}" "Magic Cube 4D (Java)" mc4d
}
