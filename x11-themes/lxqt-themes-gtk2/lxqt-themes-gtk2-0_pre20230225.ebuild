# Copyright 2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=2015450177e3021a750526d09f2534b2d426f208

DESCRIPTION="LXQt ports of the old-school default GTK Engines themes"
HOMEPAGE="https://github.com/AzumaHazuki/lxqt-themes-gtk2"
SRC_URI="https://github.com/AzumaHazuki/lxqt-themes-gtk2/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${GIT_REV}"

DOCS=( README.md )

THEMES=(
	Crux
	Industrial
	Mist
	Raleigh
	Redmond
	ThinIce
)

src_install() {
	einstalldocs

	cd "${S}/palettes"
	insinto /usr/share/lxqt/palettes
	doins -r "${THEMES[@]}"

	cd "${S}/themes"
	insinto /usr/share/lxqt/themes
	doins -r "${THEMES[@]}"
}
