# Copyright 2021-2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# At least 5.2 is required due to use of 'goto'.
LUA_COMPAT=( lua5-{2..3} )

inherit lua-single xdg

MY_PN=SNKRX
GIT_REV=1fff7cdefd10af5273d3efc5b678d7fb8d126110

DESCRIPTION="Arcade shooter where you control a snake of heroes"
HOMEPAGE="https://store.steampowered.com/app/915310/SNKRX/"
SRC_URI="https://github.com/a327ex/${MY_PN}/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT CC0-1.0 CC-BY-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

REQUIRED_USE="${LUA_REQUIRED_USE}"
DEPEND=""
RDEPEND="${DEPEND}
	${LUA_DEPS}
	games-engines/love:0[${LUA_SINGLE_USEDEP}]
"

S="${WORKDIR}/${MY_PN}-${GIT_REV}"

PATCHES=(
	"${FILESDIR}/${PN}-0_pre20210726-remove-steam.patch"
)

DOCS=(
	README.md
	LICENSE
	devlog.md
	todo
)

src_prepare() {
	# Remove bundled love, we add our own :).
	rm -r engine/love || die "Couldn't remove bundled engine."
	rm .ctrlp .gitignore || die "Couldn't remove extraneous files."

	default
}

src_install() {
	einstalldocs
	rm "${DOCS[@]}" || die "Couldn't clean up docs."

	insinto "/usr/share/${PN}"
	doins -r .

	insinto "/usr/share/pixmaps"
	newins assets/images/icon.png snkrx.png

	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop"

	newbin "${FILESDIR}/${PN}-0_pre20210523-launcher.sh" snkrx
}

pkg_postinst() {
	xdg_pkg_postinst

	ewarn "This ebuild patches out Steam integration from the game,"
	ewarn "so achievements are not available."
}
