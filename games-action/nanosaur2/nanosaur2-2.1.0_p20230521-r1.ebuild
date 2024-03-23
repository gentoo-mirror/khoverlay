# Copyright 2021-2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=Nanosaur2
GIT_REV=72d93ed08148d81aa89bab511a9650d7b929d4c7
POMME_VER=20230516

DESCRIPTION="Battle dinosaurs and rescue their eggs before the asteroid hits"
HOMEPAGE="https://github.com/jorio/Nanosaur/"
SRC_URI="https://github.com/jorio/Nanosaur2/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="l10n_de l10n_es l10n_fr l10n_it l10n_ja l10n_nl"

RDEPEND="
	dev-games/pomme:${POMME_VER}
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-2.1.0_p20230521-build.patch"
)

DOCS=(
	README.md
	CHANGELOG.md
	SECRETS.md
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
