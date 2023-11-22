# Copyright 2021-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

# Pomme is bundled since different, specific versions are required by
# each of Jorio's ports.

EAPI=8

inherit cmake xdg

MY_PN=Bugdom2
GIT_REV=d56b8e7ce0f71b02c1b83ce0d70008df153db2a8
POMME_GIT_REV=c6a38eab19a11847024a13f9b3e2af0c2d908c3e

DESCRIPTION="Pangea Software's Bugdom 2 for modern systems"
HOMEPAGE="https://github.com/jorio/Bugdom2"
SRC_URI="
	https://github.com/jorio/Bugdom2/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz
	https://github.com/jorio/Pomme/archive/${POMME_GIT_REV}.tar.gz -> Pomme-${POMME_GIT_REV}.tar.gz
"
S="${WORKDIR}/${MY_PN}-${GIT_REV}"

# Licenses other than CC-BY-NC-SA-4.0 are for Pomme.
LICENSE="CC-BY-NC-SA-4.0 Boost-1.0 BSD CC0-1.0 LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="l10n_de l10n_es l10n_fr l10n_it l10n_ja l10n_nl l10n_sv"

RDEPEND="
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/patchelf"

PATCHES=(
	"${FILESDIR}/${PN}-4.0.0_p20231022-build.patch"
)

DOCS=( CHANGELOG.md README.md SECRETS.md )

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
	dodoc "${S}/Instructions/Instructions-EN.pdf"
	use l10n_de && dodoc "${S}/Instructions/Instructions-DE.pdf"
	use l10n_es && dodoc "${S}/Instructions/Instructions-ES.pdf"
	use l10n_fr && dodoc "${S}/Instructions/Instructions-FR.pdf"
	use l10n_it && dodoc "${S}/Instructions/Instructions-IT.pdf"
	use l10n_ja && dodoc "${S}/Instructions/Instructions-JA.pdf"
	use l10n_nl && dodoc "${S}/Instructions/Instructions-NL.pdf"
	use l10n_sv && dodoc "${S}/Instructions/Instructions-SV.pdf"

	insinto "/usr/share/pixmaps"
	doins "${S}/packaging/io.jor.bugdom2.png"

	insinto "/usr/share/applications"
	doins "${S}/packaging/io.jor.bugdom2.desktop"
}
