# Copyright 2021 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=ColorPicker

inherit qmake-utils

DESCRIPTION="A powerful screen color picker"
HOMEPAGE="https://github.com/keshavbhatt/${MY_PN}"
SRC_URI="https://github.com/keshavbhatt/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}/src"

src_configure() {
	eqmake5 PREFIX="${EPREFIX}"/usr
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
