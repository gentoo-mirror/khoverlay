# Copyright 2021-2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

# This ebuild bundles the specific version of Pomme that is recommended
# for this release of Nanosaur.  Nanosaur is incompatible with this
# version and requires a different version, and it's not worth the
# trouble to slot Pomme.

EAPI=8

inherit cmake xdg

MY_PN=Nanosaur
NANOSAUR_GIT_REV=25520d32d867e93d9523ab3b519ce21b9845fd07
POMME_GIT_REV=0581b241624d16c453e0afab57a379b443229260

DESCRIPTION="Battle dinosaurs and rescue their eggs before the asteroid hits"
HOMEPAGE="https://github.com/jorio/Nanosaur/"
SRC_URI="
	https://github.com/jorio/${MY_PN}/archive/${NANOSAUR_GIT_REV}.tar.gz -> ${P}.tar.gz
	https://github.com/jorio/Pomme/archive/${POMME_GIT_REV}.tar.gz -> ${P}-Pomme.tar.gz
"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.4.3-build.patch"
)

DOCS=(
	README.md
	CHANGELOG.md
	"docs/About Nanosaur Extreme.md"
	"docs/Nanosaur Instructions.pdf"

)

S="${WORKDIR}/${MY_PN}-${NANOSAUR_GIT_REV}"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}/extern/Pomme" || die "Couldn't change to extern/Pomme."
	unpack "${P}-Pomme.tar.gz"
	mv "Pomme-${POMME_GIT_REV}"/* ./ || die
	rm -r "Pomme-${POMME_GIT_REV}" || die
}

src_compile() {
	cmake_src_compile

	patchelf --set-rpath '$ORIGIN' "${BUILD_DIR}/${MY_PN}" ||
		die "Failed to call patchelf."
}

src_install() {
	exeinto "/usr/$(get_libdir)/${MY_PN}"
	doexe "${BUILD_DIR}/${MY_PN}"
	doexe "${BUILD_DIR}/extern/Pomme/libPomme.so"

	dosym "../$(get_libdir)/${MY_PN}/${MY_PN}" "${EPREFIX}/usr/bin/${MY_PN}"

	insinto "/usr/share/${MY_PN}"
	doins -r "${BUILD_DIR}/Data"/*

	einstalldocs

	insinto "/usr/share/applications"
	doins "${FILESDIR}/nanosaur.desktop"
}
