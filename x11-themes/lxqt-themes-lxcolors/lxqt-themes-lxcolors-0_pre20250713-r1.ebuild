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

src_install() {
	einstalldocs

	insinto /usr/share/lxqt
	doins -r palettes themes
}
