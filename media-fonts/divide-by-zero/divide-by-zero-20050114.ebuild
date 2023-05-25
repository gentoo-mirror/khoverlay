# Copyright 2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FONT_SUFFIX="ttf TTF"

inherit font

DESCRIPTION="Tom7's collection of fun TrueType fonts"
HOMEPAGE="http://fonts.tom7.com/"
SRC_URI="http://carnage-melon.tom7.org/fonts/dbz.zip -> tom7-dbz.zip"

LICENSE="Tom7-fonts"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"
