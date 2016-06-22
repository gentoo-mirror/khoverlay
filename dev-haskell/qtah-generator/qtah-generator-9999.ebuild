EAPI=6

CABAL_FEATURES="bin"
inherit git-r3 haskell-cabal

DESCRIPTION="Qt bindings for Haskell - FFI generator"
HOMEPAGE="http://khumba.net/projects/qtah"
EGIT_REPO_URI="https://gitlab.com/khumba/qtah.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="LGPL-3+"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="qt4 qt5"
REQUIRED_USE="^^ ( qt4 qt5 )"

RDEPEND=">=dev-lang/ghc-7.8.4:=
	>=dev-haskell/hoppy-generator-0.2:=
	>=dev-haskell/hoppy-std-0.2:=
	>=dev-haskell/haskell-src-1.0:= <dev-haskell/haskell-src-1.1:=
	>=dev-haskell/mtl-2.1:= <dev-haskell/mtl-2.3:=
"

DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

src_prepare() {
	"${WORKDIR}/${P}/tools/listener-gen.sh" --gen-hs-dir "${S}" || die
	eapply_user
}

src_configure() {
	# The Qt versions here must be kept in sync with the other Qtah ebuilds.
	haskell-cabal_src_configure \
		$(cabal_flag qt4 qt4_8) \
		$(cabal_flag qt5 qt5_5)
}
