# Copyright 2025 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=6068de6dae66c24d2490082bd2b919252edc1153

DESCRIPTION="LXQt port of LXColors-Revival GTK theme"
HOMEPAGE="https://github.com/AzumaHazuki/lxqt-themes-lxcolors"
SRC_URI="https://pub.khumba.net/distfiles/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${GIT_REV}"

DOCS=( README.md )

THEMES_WITH_PALLETTES=(
	LXQt-Brave
	LXQt-Carbonite
	LXQt-Dust
	LXQt-Human
	LXQt-Illustrious
	LXQt-Noble
	LXQt-Tribute
	LXQt-Wine
)

THEMES=(
	LXQt-Wise
)

src_install() {
	einstalldocs

	cd "${S}/palettes"
	insinto /usr/share/lxqt/palettes
	doins -r "${THEMES_WITH_PALLETTES[@]}"

	cd "${S}/themes"
	insinto /usr/share/lxqt/themes
	doins -r "${THEMES_WITH_PALLETTES[@]}"
	doins -r "${THEMES[@]}"
}
