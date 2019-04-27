# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This ebuild tracks a Qt 5 fork of the original Qt 4 project.  The
# original project is at https://github.com/fontmatrix/fontmatrix.

EAPI=7

inherit cmake-utils git-r3 xdg

DESCRIPTION="Cross-platform font management application"
HOMEPAGE="https://github.com/fcoiffie/fontmatrix"
SRC_URI=""
EGIT_REPO_URI="https://github.com/fcoiffie/fontmatrix.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtxml:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	media-libs/freetype:2
"

DEPEND="
	${RDEPEND}
	dev-qt/linguist-tools:5
"

src_prepare() {
	cmake-utils_src_prepare

	if ! grep -Fx '#include <QAction>' src/prefspaneldialog.cpp; then
		eapply "${FILESDIR}/${PN}-qaction-include.patch"
	fi
}

src_configure() {
	cmake-utils_src_configure
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
