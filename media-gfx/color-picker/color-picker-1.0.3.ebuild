# Copyright 2021-2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS=(
	README.md
)

src_configure() {
	cd "${S}"/src
	eqmake5 PREFIX="${EPREFIX}"/usr
}

src_install() {
	cd "${S}"/src
	emake INSTALL_ROOT="${D}" install
	doman man/color-picker.1

	cd "${S}"
	einstalldocs
}
