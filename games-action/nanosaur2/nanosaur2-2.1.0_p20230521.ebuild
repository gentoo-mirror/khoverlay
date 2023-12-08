# Copyright 2021-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

# Pomme is bundled since different, specific versions are required by
# each of Jorio's ports.

EAPI=8

inherit cmake xdg

MY_PN=Nanosaur2
GIT_REV=72d93ed08148d81aa89bab511a9650d7b929d4c7
POMME_GIT_REV=d57c28e205462e51063e787f9ebddaadff592f1e

DESCRIPTION="Battle dinosaurs and rescue their eggs before the asteroid hits"
HOMEPAGE="https://github.com/jorio/Nanosaur/"
SRC_URI="
	https://github.com/jorio/Nanosaur2/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz
	https://github.com/jorio/Pomme/archive/${POMME_GIT_REV}.tar.gz -> Pomme-${POMME_GIT_REV}.tar.gz
"

# Licenses other than CC-BY-NC-SA-4.0 are for Pomme and AppStream metadata.
LICENSE="CC-BY-NC-SA-4.0 Boost-1.0 BSD CC0-1.0 LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="l10n_de l10n_es l10n_fr l10n_it l10n_ja l10n_nl"

RDEPEND="
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-2.1.0-build.patch"
)

DOCS=(
	README.md
	CHANGELOG.md
	SECRETS.md
)

S="${WORKDIR}/${MY_PN}-${GIT_REV}"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}/extern/Pomme" || die "Couldn't change to extern/Pomme."
	unpack "Pomme-${POMME_GIT_REV}.tar.gz"
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
	dodoc "${S}/docs/Instructions-EN.pdf"
	use l10n_de && dodoc "${S}/docs/Instructions-DE.pdf"
	use l10n_es && dodoc "${S}/docs/Instructions-ES.pdf"
	use l10n_fr && dodoc "${S}/docs/Instructions-FR.pdf"
	use l10n_it && dodoc "${S}/docs/Instructions-IT.pdf"
	use l10n_ja && dodoc "${S}/docs/Instructions-JA.pdf"
	use l10n_nl && dodoc "${S}/docs/Instructions-NL.pdf"

	insinto "/usr/share/applications"
	doins "${S}/packaging/io.jor.nanosaur2.desktop"

	insinto "/usr/share/metainfo"
	doins "${S}/packaging/io.jor.nanosaur2.appdata.xml"

	insinto "/usr/share/pixmaps"
	doins "${S}/packaging/io.jor.nanosaur2.png"
}
