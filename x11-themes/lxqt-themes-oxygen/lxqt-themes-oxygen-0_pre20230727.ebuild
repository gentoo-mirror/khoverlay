# Copyright 2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=5c9edca8e952b76f5c8c74e67280fbe83f4ff015

DESCRIPTION="LXQt port of KDE 4.x's Oxygen style"
HOMEPAGE="https://github.com/AzumaHazuki/lxqt-themes-oxygen"
SRC_URI="https://github.com/AzumaHazuki/lxqt-themes-oxygen/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${GIT_REV}"

DOCS=( README.md )

THEMES=( Oxygen )

src_install() {
	einstalldocs

	cd "${S}/palettes"
	insinto /usr/share/lxqt/palettes
	doins -r "${THEMES[@]}"

	cd "${S}/themes"
	insinto /usr/share/lxqt/themes
	doins -r "${THEMES[@]}"
}
