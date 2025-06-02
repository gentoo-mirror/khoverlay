# Copyright 1999-2025 Gentoo Authors
# Copyright 2025 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils xdg

GIT_REV=b2835a19f472c858a4d8cdfd5f34b7f2ae6d6256

DESCRIPTION="Texas Hold'em poker game"
HOMEPAGE="https://www.pokerth.net/"
SRC_URI="https://github.com/pokerth/pokerth/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3 GPL-1 GPL-2 GPL-3 BitstreamVera public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/boost:=[zlib]
	dev-libs/libgcrypt:0
	dev-libs/protobuf:0=
	dev-libs/tinyxml[stl]
	dev-qt/qtbase:6[network]
	>=net-libs/libircclient-1.6-r2
	>=net-misc/curl-7.16
	net-misc/gsasl[client,server]
	!dedicated? (
		dev-qt/qtbase:6[gui,widgets]
		media-libs/libsdl:0
		media-libs/sdl-mixer[mod,vorbis]
	)"
DEPEND="${RDEPEND}
	dev-cpp/websocketpp
	!dedicated? ( dev-qt/qtbase:6[sql] )"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${PN}-${GIT_REV}"

PATCHES=(
	# unbundle dev-cpp/websocketpp
	"${FILESDIR}"/${PN}-1.1.2-system-websockets.patch
	"${FILESDIR}"/${PN}-1.1.2-protobuf-30.patch
)

src_prepare() {
	xdg_src_prepare
	sed -i 's/!client//' *.pro || die

	# delete bundled dev-cpp/websocketpp to be safe
	rm -r src/third_party/websocketpp || die
}

src_configure() {
	eqmake5 pokerth.pro \
			QMAKE_CFLAGS_ISYSTEM= \
			CONFIG+="$(use dedicated || echo client)"
}

src_install() {
	dobin bin/pokerth_server chatcleaner
	dodoc docs/{gui_styling,server_setup}_howto.txt
	doman docs/pokerth.1

	if ! use dedicated; then
		dobin ${PN}
		insinto /usr/share/${PN}
		doins -r data
		domenu ${PN}.desktop
		doicon -s 128 ${PN}.png
	fi
}
