# Copyright 2021 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# At least 5.2 is required due to use of 'goto'.
LUA_COMPAT=( lua5-{2..3} )

inherit lua-single

MY_PN=SNKRX
GIT_REV=023cf595fe142def79db3cc0289658637f009f17

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
	"${FILESDIR}/${PN}-0_pre20210523-remove-steam.patch"
)

src_prepare() {
	default

	# Remove bundled love, we add our own :).
	rm -r engine/love || die "Couldn't remove bundled engine."
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r .
	newbin "${FILESDIR}/${PN}-0_pre20210523-launcher.sh" snkrx
}

pkg_postinst() {
	elog "If you enjoy this game, consider supporting its creator:"
	elog
	elog "    https://store.steampowered.com/app/915310/SNKRX/"
	elog
	ewarn "This ebuild patches out Steam integration from the game,"
	ewarn "so achievements are not available."
}
