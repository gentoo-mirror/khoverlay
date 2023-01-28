# Copyright 1999-2018 Gentoo Foundation
# Copyright 2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

# Restored from games-engines/love-0.10.2::gentoo in the archive.  This
# ebuild was dropped from the main tree on 2020-10-13
# (1b04c6c5e35b50d39299c1c4d900be691bd493ca).

EAPI=8
LUA_COMPAT=( luajit )

inherit lua-single gnome2-utils xdg-utils

DESCRIPTION="A framework for 2D games in Lua"
HOMEPAGE="http://love2d.org/"
SRC_URI="https://github.com/love2d/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0.10"
KEYWORDS="~amd64 ~arm ~x86"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="${LUA_DEPS}
	sys-libs/zlib
	dev-games/physfs
	media-libs/freetype
	media-libs/libmodplug
	media-libs/libsdl2[joystick,opengl]
	media-libs/libogg
	media-libs/libtheora
	media-libs/libvorbis
	media-libs/openal
	media-sound/mpg123
	virtual/opengl"
DEPEND="${RDEPEND}"

DOCS=( "readme.md" "changes.txt" )

PATCHES=(
	"${FILESDIR}/redefine-luaL_reg-for-luajit.patch"
)

src_prepare() {
	default
	./platform/unix/automagic || die
}

src_configure() {
	econf --with-lua="${ELUA}"
}

src_install() {
	default

	find "${D}" -name '*.la' -delete || die
	if [[ ${SLOT} != 0 ]]
	then
		mv "${ED}/usr/bin/${PN}" "${ED}/usr/bin/${PN}-${SLOT}" || die
		mv "${ED}"/usr/share/applications/love{,"-$SLOT"}.desktop || die
		sed -i -e "/^Name=/s/$/ ($SLOT)/" -e "s|/usr/bin/love|/usr/bin/love-$SLOT|" "${ED}/usr/share/applications/love-$SLOT.desktop" || die
		rm -r "${ED}"/usr/"$(get_libdir)"/liblove.so || die
		rm -r "${ED}"/usr/share/{mime/,pixmaps/,icons/,man/} || die
	fi
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
