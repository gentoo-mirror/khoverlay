# Copyright 2021-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

MY_PN=BYTEPATH
GIT_REV=51ee3086ae3369a2c80e4e47d4b62d480af4fe89

DESCRIPTION="Replayable arcade shooter with a focus on build theorycrafting"
HOMEPAGE="https://store.steampowered.com/app/760330/BYTEPATH/"
SRC_URI="https://github.com/a327ex/${MY_PN}/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT CC0-1.0 CC-BY-3.0 ZLIB"  # TODO Adjust.
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	games-engines/love:0.10[lua_single_target_luajit]
"

S="${WORKDIR}/${MY_PN}-${GIT_REV}"

PATCHES=(
	"${FILESDIR}/${PN}-0_pre20200814-remove-steam.patch"
)

src_prepare() {
	# Remove bundled engine and tutorials.
	rm -r love tutorial || die "Couldn't remove bundled engine and tutorial."

	default
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r .

	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/${PN}.png"

	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop"

	newbin "${FILESDIR}/${PN}-0_pre20200814-launcher.sh" "${PN}"
}
