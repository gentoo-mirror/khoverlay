# Copyright 2021-2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=MightyMike
GIT_REV=b05cb3a8c3b42f1ba252edfdd5b096010a0b909e
POMME_VER=20230516

DESCRIPTION="High-Powered Action Rescue in a Toy Store Gone Mad!"
HOMEPAGE="https://github.com/jorio/MightyMike"
SRC_URI="https://github.com/jorio/MightyMike/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-games/pomme:${POMME_VER}
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-3.0.2_p20240310-build.patch"
)

DOCS=(
	CHANGELOG.md
	README.md
	docs/DiscArt.jpg
	docs/DiscCaseBack.jpg
	docs/DiscCaseFront.jpg
	docs/DiscCaseInsideLeft.jpg
	docs/Instructions.pdf
	docs/screenshot.png
	docs/SurvivalGuide.pdf
)

S="${WORKDIR}/${MY_PN}-${GIT_REV}"

src_prepare() {
	cmake_src_prepare

	sed -i \
		-e "s,@POMME_VER@,${POMME_VER},g" \
		-e "s,@POMME_LIBDIR@,/usr/$(get_libdir)/Pomme-${POMME_VER},g" \
		CMakeLists.txt

	grep -Hn '@POMME_' CMakeLists.txt \
		&& die "Had problems patching Pomme version into CMakeLists.txt."
}

src_install() {
	exeinto "/usr/$(get_libdir)/${MY_PN}"
	doexe "${BUILD_DIR}/${MY_PN}"

	dosym "../$(get_libdir)/${MY_PN}/${MY_PN}" "${EPREFIX}/usr/bin/${MY_PN}"

	insinto "/usr/share/${MY_PN}"
	doins -r "${BUILD_DIR}/Data"/*

	einstalldocs

	insinto "/usr/share/applications"
	doins "${S}/packaging/io.jor.mightymike.desktop"

	insinto "/usr/share/metainfo"
	doins "${S}/packaging/io.jor.mightymike.appdata.xml"

	insinto "/usr/share/pixmaps"
	doins "${S}/packaging/io.jor.mightymike.png"
}
