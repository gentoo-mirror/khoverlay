# Copyright 2022, 2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

# We install the "binary" cursors from the tarball here, rather than
# rebuilding from the raw SVGs, as that requires Inkscape.

EAPI=8

inherit xdg

DESCRIPTION="Soothing pastel mouse cursors"
HOMEPAGE="https://github.com/catppuccin/cursors"
SRC_URI="https://github.com/catppuccin/cursors/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+frappe +latte +macchiato +mocha"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/cursors-${PV}"

STYLES=(
	Frappe
	Latte
	Macchiato
	Mocha
)

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

	cd "${S}/cursors" || die "Couldn't change to cursors directory."
	local style color tarball
	for style in "${STYLES[@]}"; do
		if use "${style,}"; then
			for color in "${COLORS[@]}"; do
				archive="Catppuccin-${style}-${color}-Cursors.zip"
				unzip -q "${archive}" || die "Couldn't unpack ${archive}."
			done
		fi
	done
}

src_compile() {
	:  # Skip building from source.
}

src_install() {
	insinto /usr/share/icons

	cd "${S}/cursors" || die "Couldn't change to cursors directory."
	local color
	for style in "${STYLES[@]}"; do
		if use "${style,}"; then
			for color in "${COLORS[@]}"; do
				doins -r "Catppuccin-${style}-${color}-Cursors"
			done
		fi
	done
}
