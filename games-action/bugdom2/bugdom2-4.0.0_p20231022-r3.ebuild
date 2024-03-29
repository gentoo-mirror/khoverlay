# Copyright 2021-2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=Bugdom2
GIT_REV=d56b8e7ce0f71b02c1b83ce0d70008df153db2a8
POMME_VER=20230928

DESCRIPTION="Pangea Software's Bugdom 2 for modern systems"
HOMEPAGE="https://github.com/jorio/Bugdom2"
SRC_URI="https://github.com/jorio/Bugdom2/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="l10n_de l10n_es l10n_fr l10n_it l10n_ja l10n_nl l10n_sv"

RDEPEND="
	dev-games/pomme:${POMME_VER}
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.0.0_p20231022-build-v2.patch"
)

DOCS=( CHANGELOG.md README.md SECRETS.md )

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
	dodoc "${S}/Instructions/Instructions-EN.pdf"
	use l10n_de && dodoc "${S}/Instructions/Instructions-DE.pdf"
	use l10n_es && dodoc "${S}/Instructions/Instructions-ES.pdf"
	use l10n_fr && dodoc "${S}/Instructions/Instructions-FR.pdf"
	use l10n_it && dodoc "${S}/Instructions/Instructions-IT.pdf"
	use l10n_ja && dodoc "${S}/Instructions/Instructions-JA.pdf"
	use l10n_nl && dodoc "${S}/Instructions/Instructions-NL.pdf"
	use l10n_sv && dodoc "${S}/Instructions/Instructions-SV.pdf"

	insinto "/usr/share/applications"
	doins "${S}/packaging/io.jor.bugdom2.desktop"

	insinto "/usr/share/metainfo"
	doins "${S}/packaging/io.jor.bugdom2.appdata.xml"

	insinto "/usr/share/pixmaps"
	doins "${S}/packaging/io.jor.bugdom2.png"
}
