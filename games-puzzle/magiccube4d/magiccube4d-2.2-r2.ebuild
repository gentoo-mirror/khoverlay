# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop

MY_PV="${PV/./_}"
DESCRIPTION="Four-dimensional analog of Rubik's cube"
HOMEPAGE="https://superliminal.com/cube/cube.htm"
SRC_URI="https://superliminal.com/cube/mc4d-src-${MY_PV}.tgz
	https://superliminal.com/cube/cube_transp.gif -> ${PN}.gif"

LICENSE="free-noncomm"
SLOT="2"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/libXaw"
RDEPEND="${DEPEND}
	!<games-puzzle/magiccube4d-2.2-r2:0"

S="${WORKDIR}/${PN}-src-${MY_PV}"

PATCHES=(
	"${FILESDIR}/${PN}-EventHandler.patch"
	"${FILESDIR}/${PN}-2.2-gcc41.patch"
	"${FILESDIR}/${PN}-2.2-64bit-ptr.patch"
	"${FILESDIR}/${PN}-2.2-ldflags.patch"
	"${FILESDIR}/${PN}-2.2-overflow.patch"
)

DOCS=(
	ChangeLog
	MagicCube4D-unix.txt
	readme-unix.txt
	Intro.txt
)

src_prepare() {
	default
	sed -i \
		-e "s:-Werror::" \
		configure \
		|| die "sed failed"
}

src_compile() {
	emake DFLAGS="${CFLAGS}"
}

src_install() {
	newbin magiccube4d{,-2}
	doicon "${DISTDIR}"/${PN}.gif
	make_desktop_entry "${PN}-2" "Magic Cube 4D" /usr/share/pixmaps/${PN}.gif
}
