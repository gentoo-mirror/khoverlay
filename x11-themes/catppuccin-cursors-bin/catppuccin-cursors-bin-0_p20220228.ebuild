# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

# We install the "binary" cursors from the tarball here, rather than
# rebuilding from the raw SVGs, as that requires Inkscape.

EAPI=8

inherit xdg

GIT_REV=ea242e87413fefc44369bfaa168e04610c92b195

DESCRIPTION="Catppuccin mouse cursors (based on Volantes cursors)"
HOMEPAGE="https://github.com/catppuccin/cursors"
SRC_URI="https://github.com/catppuccin/cursors/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/cursors-${GIT_REV}"

COLORS=(
	Blue
	Dark
	Flamingo
	Green
	Lavender
	Maroon
	Mauve
	Peach
	Pink
	Red
	Sky
	Teal
	Yellow
)

src_unpack() {
	default

	cd "${S}/cursors"
	local color tarball
	for color in "${COLORS[@]}"; do
		tarball="Catppuccin-${color}-Cursors.tar.gz"
		echo "Unpacking ${tarball}."
		tar xf "${tarball}"
	done
}

src_compile() {
	:  # Skip building from source.
}

src_install() {
	insinto /usr/share/icons

	cd "${S}/cursors"
	local color
	for color in "${COLORS[@]}"; do
		doins -r "Catppuccin-${color}-Cursors"
	done
}
