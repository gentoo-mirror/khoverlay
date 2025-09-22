# Copyright 2021-2025 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=Bugdom
GIT_REV=7d7ad9979a86a7a149a85611bb01b06a339f4805
POMME_VER=20250201

DESCRIPTION="Save the Bugdom from the evil Fire Ants"
HOMEPAGE="https://github.com/jorio/Bugdom/"
if [[ -z "${GIT_REV}" ]]; then
	SRC_URI="https://github.com/jorio/Bugdom/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
else
	SRC_URI="https://github.com/jorio/Bugdom/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-games/pomme:${POMME_VER}
	media-libs/libsdl3
	virtual/opengl
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.3.5_pre20250308-data-path.patch"
	"${FILESDIR}/${PN}-1.3.5_pre20250308-use-external-pomme.patch"
)

DOCS=(
	CHANGELOG.md
	README.md
	SECRETS.md
)

if [[ -z "${GIT_REV}" ]]; then
	S="${WORKDIR}/${MY_PN}-${PV}"
else
	S="${WORKDIR}/${MY_PN}-${GIT_REV}"
fi

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
	doins "${S}/packaging/io.jor.bugdom.png"

	insinto "/usr/share/applications"
	doins "${S}/packaging/io.jor.bugdom.desktop"
}
