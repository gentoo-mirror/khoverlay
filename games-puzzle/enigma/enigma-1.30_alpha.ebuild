# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools xdg-utils

MY_PV="${PV/_/-}"
MY_P_LONG="${PN}-${MY_PV}"
MY_P_SHORT="${PN}-${PV%%_*}"
DESCRIPTION="Puzzle game similar to Oxyd"
HOMEPAGE="http://www.nongnu.org/enigma/"
SRC_URI="https://github.com/Enigma-Game/Enigma/releases/download/${MY_PV}/${MY_P_LONG}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

COMMON_DEPS="
	media-libs/sdl2-ttf
	media-libs/libsdl2[video]
	media-libs/sdl2-mixer
	media-libs/sdl2-image[jpeg,png]
	media-libs/libpng:0=
	sys-libs/zlib
	net-misc/curl
	|| ( >=dev-libs/xerces-c-3[icu] >=dev-libs/xerces-c-3[-icu,-iconv] )
	net-libs/enet:=
	nls? ( virtual/libintl )
"
DEPEND="${COMMON_DEPS}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPS}
	media-fonts/dejavu
	x11-misc/xdg-utils
"

S="${WORKDIR}/${MY_P_SHORT}"

PATCHES=(
	"${FILESDIR}/${PN}-1.30_alpha-build.patch"
)

src_prepare() {
	default
	cp /usr/share/gettext/config.rpath .
	sed -i \
		-e "s:DOCDIR:\"/usr/share/doc/${MY_P_SHORT}/html\":" \
		src/main.cc || die
	eautoreconf
}

src_configure() {
	econf \
		--with-system-enet \
		$(use_enable nls)
}

src_install() {
	HTML_DOCS="doc/*" DOCS="ACKNOWLEDGEMENTS AUTHORS CHANGES README doc/HACKING" \
		default
	dosym \
		../../fonts/dejavu/DejaVuSansCondensed.ttf \
		/usr/share/${PN}/fonts/DejaVuSansCondensed.ttf
	dosym \
		../../fonts/dejavu/DejaVuSans.ttf \
		/usr/share/${PN}/fonts/vera_sans.ttf
	doman doc/enigma.6
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
