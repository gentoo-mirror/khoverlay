# Copyright 2023-2025 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=677d357e86575ea67b76d698228cb2baebef0e40

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

src_install() {
	einstalldocs

	insinto /usr/share/lxqt
	doins -r palettes themes
}
