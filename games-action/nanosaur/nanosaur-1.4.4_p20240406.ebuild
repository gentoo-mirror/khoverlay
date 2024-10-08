# Copyright 2021-2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=Nanosaur
GIT_REV=4f2612f81697a0852f63fa2ea1ac80892f8a5a9c
POMME_VER=20231019

DESCRIPTION="Battle dinosaurs and rescue their eggs before the asteroid hits"
HOMEPAGE="https://github.com/jorio/Nanosaur/"
SRC_URI="https://github.com/jorio/Nanosaur/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

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
	"${FILESDIR}/${PN}-1.4.4_p20240406-data-path.patch"
	"${FILESDIR}/${PN}-1.4.4_p20240406-use-external-pomme.patch"
)

DOCS=(
	README.md
	CHANGELOG.md
	"docs/About Nanosaur Extreme.md"
	"docs/Nanosaur Instructions.pdf"

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

	insinto "/usr/share/pixmaps"
	doins "${S}/packaging/io.jor.nanosaur.png"

	insinto "/usr/share/applications"
	doins "${S}/packaging/io.jor.nanosaur.desktop"
}
