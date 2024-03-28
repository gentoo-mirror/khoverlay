# Copyright 2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=67759fbe15eb9490d096ef8014d9f92fc5748fe7

DESCRIPTION="Soothing pastel theme for Plymouth"
HOMEPAGE="https://github.com/catppuccin/plymouth"
SRC_URI="https://github.com/catppuccin/plymouth/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="sys-boot/plymouth"

S="${WORKDIR}/plymouth-${GIT_REV}"

src_install() {
	insinto /usr/share/plymouth/themes
	doins -r themes/catppuccin-{latte,frappe,macchiato,mocha}
}
