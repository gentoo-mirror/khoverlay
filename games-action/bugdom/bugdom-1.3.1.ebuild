# Copyright 2021 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=Bugdom
GIT_REV=d4b5e729cf6747f1b07ee2752c824ac882f5ce5b

DESCRIPTION="Save the Bugdom from the evil Fire Ants"
HOMEPAGE="https://github.com/jorio/${MY_PN}"
SRC_URI="https://github.com/jorio/${MY_PN}/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-games/pomme-0_pre20210821
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.3.1-build.patch"
)

DOCS=( README.md )

S="${WORKDIR}/${MY_PN}-${GIT_REV}"

src_install() {
	dobin "${BUILD_DIR}/${MY_PN}"

	insinto "/usr/share/${MY_PN}"
	doins -r "${BUILD_DIR}/Data"/*

	einstalldocs

	insinto "/usr/share/pixmaps"
	doins "${S}/packaging/bugdom-desktopicon.png"

	insinto "/usr/share/applications"
	doins "${S}/packaging/bugdom.desktop"
}
