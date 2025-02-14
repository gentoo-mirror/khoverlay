# Copyright 2021-2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=ColorPicker

inherit qmake-utils

DESCRIPTION="A powerful screen color picker"
HOMEPAGE="https://github.com/keshavbhatt/ColorPicker"
SRC_URI="https://github.com/keshavbhatt/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-qt/qtbase:6
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

PATCHES=(
	"${FILESDIR}/pr-28-support-qt6.patch"
)

DOCS=(
	README.md
)

src_configure() {
	cd "${S}"/src
	eqmake6 PREFIX="${EPREFIX}"/usr
}

src_install() {
	cd "${S}"/src
	emake INSTALL_ROOT="${D}" install
	doman man/color-picker.1

	cd "${S}"
	einstalldocs
}
