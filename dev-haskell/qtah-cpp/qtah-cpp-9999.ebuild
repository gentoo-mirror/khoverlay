EAPI=6

inherit git-r3 multilib qmake-utils

DESCRIPTION="Qt bindings for Haskell - FFI generator"
HOMEPAGE="http://khumba.net/projects/qtah"
EGIT_REPO_URI="https://gitlab.com/khumba/qtah.git"
S="${WORKDIR}/${P}/qtah/cpp"

LICENSE="LGPL-3+"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="qt4 qt5"
REQUIRED_USE="^^ ( qt4 qt5 )"

# The Qt versions here must be kept in sync with the other Qtah ebuilds.
RDEPEND="
	qt4? (
		=dev-qt/qtcore-4.8*:4
		=dev-qt/qtgui-4.8*:4
	)
	qt5? (
		=dev-qt/qtcore-5.5*:5
		=dev-qt/qtgui-5.5*:5
		=dev-qt/qtwidgets-5.5*:5
	)
"

DEPEND="${RDEPEND}
	>=dev-haskell/qtah-generator-9999:=[qt4=,qt5=]
"

src_prepare() {
	"${WORKDIR}/${P}/tools/listener-gen.sh" --gen-cpp-dir "${S}" || die
	qtah-generator --gen-cpp "${WORKDIR}/${P}/qtah/cpp" || die
	eapply_user
}

src_configure() {
	if use qt4; then
		eqmake4 PREFIX="${EPREFIX}/usr"
	elif use qt5; then
		eqmake5 PREFIX="${EPREFIX}/usr"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
