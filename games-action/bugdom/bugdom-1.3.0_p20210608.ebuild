# Copyright 2021 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=Bugdom
GIT_REV=b4908dc57cec4290490b89798b4047b58cb74f24

DESCRIPTION="Save the Bugdom from the evil Fire Ants"
HOMEPAGE="https://github.com/jorio/${MY_PN}"
SRC_URI="https://github.com/jorio/${MY_PN}/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-games/pomme-0_pre20210821
	dev-games/quesa
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.3.0_p20210608-build.patch"
)

DOCS=( README.md )

S="${WORKDIR}/${MY_PN}-${GIT_REV}"

src_install() {
	dobin "${BUILD_DIR}/${MY_PN}"

	insinto "/usr/share/${MY_PN}"
	doins -r "${BUILD_DIR}/Data"/*

	einstalldocs
	dodoc -r "${BUILD_DIR}/Documentation"/*

	insinto "/usr/share/applications"
	newins "${FILESDIR}/bugdom-1.3.0.desktop" bugdom.desktop
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "This version of Bugdom depends on the Quesa reimplementation of the"
	elog "QuickDraw 3D API, and because of that it may not run particularly"
	elog "well on lower-powered systems.  If you experience problems, try"
	elog "upgrading to >=games-action/bugdom-1.3.1, which has a rewritten"
	elog "3D renderer with better performance."
	elog ""
	elog "This older version is kept so that games-action/bugdom and"
	elog "games-action/nanosaur can be installed together, as they are"
	elog "sensitive to the version of dev-games/pomme that they use."
	elog ""
	elog "In short, you can either:"
	elog "- Install >=bugdom-1.3.1 for better performance, without nanosaur; or"
	elog "- Install this version of bugdom, together with nanosaur."
}
