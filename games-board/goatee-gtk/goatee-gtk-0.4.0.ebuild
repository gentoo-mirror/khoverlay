# Copyright 1999-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A monadic take on a 2,500-year-old board game - GTK+ UI"
HOMEPAGE="https://khumba.net/projects/goatee"

LICENSE="AGPL-3+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-games/goatee-0.4:=[profile?] <dev-games/goatee-0.5:=[profile?]
	>=dev-haskell/cairo-0.13:=[profile?] <dev-haskell/cairo-0.14:=[profile?]
	>=dev-haskell/glib-0.13:=[profile?] <dev-haskell/glib-0.14:=[profile?]
	>=dev-haskell/gtk-0.13:=[profile?] <dev-haskell/gtk-0.16:=[profile?]
	>=dev-haskell/parsec-3.1:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-lang/ghc-8.8.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
	test? ( >=dev-haskell/hunit-1.2 <dev-haskell/hunit-1.7 )
"
