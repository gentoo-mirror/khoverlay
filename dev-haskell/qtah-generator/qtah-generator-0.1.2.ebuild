# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Generator for Qtah Qt bindings"
HOMEPAGE="http://khumba.net/projects/qtah"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/haskell-src-1.0:=[profile?] <dev-haskell/haskell-src-1.1:=[profile?]
	>=dev-haskell/hoppy-generator-0.2:=[profile?] <dev-haskell/hoppy-generator-0.3:=[profile?]
	>=dev-haskell/hoppy-std-0.2:=[profile?] <dev-haskell/hoppy-std-0.3:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"
