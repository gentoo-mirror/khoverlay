# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=220484850b06767849471920999ddc5a911ee6be

DESCRIPTION="Catppuccin theme for Konsole"
HOMEPAGE="https://github.com/catppuccin/konsole"
SRC_URI="https://github.com/catppuccin/konsole/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="kde-apps/konsole"

S="${WORKDIR}/konsole-${GIT_REV}"

src_install() {
	insinto /usr/share/konsole
	doins Catppuccin.colorscheme
}
