# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=527517147bc5686be58276874ed8e29d338352b5

DESCRIPTION="Catppuccin theme for KDE Plasma"
HOMEPAGE="https://github.com/catppuccin/kde"
SRC_URI="https://github.com/catppuccin/kde/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+icons"

DEPEND=""
RDEPEND="icons? ( x11-themes/papirus-icon-theme )"

S="${WORKDIR}/kde-${GIT_REV}"

src_install() {
	insinto /usr/share/color-schemes
	doins color-schemes/Catppuccin/Catppuccin.colors

	insinto /usr/share/plasma/look-and-feel
	doins -r kde-store-archives/global-theme/catppuccin
}
