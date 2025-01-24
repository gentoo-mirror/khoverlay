# Copyright 2023-2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=23257f09873a504985f3f7394510f3e9d2e4d5a7

DESCRIPTION="LXQt ports of old-school (GTK2) Xfce themes"
HOMEPAGE="https://github.com/AzumaHazuki/lxqt-themes-xfce"
SRC_URI="https://pub.khumba.net/distfiles/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${GIT_REV}"

DOCS=( README.md )

THEMES=(
	Xfce-4.0
	Xfce-4.2
	Xfce-4.4
	Xfce-4.6
	Xfce-b5
	Xfce-basic
	Xfce-cadmium
	Xfce-curve
	Xfce-dawn
	Xfce-dusk
	Xfce-kde2
	Xfce-kolors
	Xfce-light
	Xfce-orange
	Xfce-redmondxp
	Xfce-saltlake
	Xfce-smooth
	Xfce-stellar
	Xfce-winter
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
