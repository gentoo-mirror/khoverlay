# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=4760c0cca4460b80fa5de024846e57ab621cb5eb

DESCRIPTION="Catppuccin wallpapers"
HOMEPAGE="https://github.com/catppuccin/wallpapers"
SRC_URI="https://github.com/catppuccin/wallpapers/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/wallpapers-${GIT_REV}"

WALLPAPER_DIRS=(
	distro-specific
	dithered
	gradients
	landscapes
	mandelbrot
	minimalistic
	misc
	os
	patterns
	solids
	waves
)

src_install() {
	insinto /usr/share/backgrounds/catppuccin
	doins -r "${WALLPAPER_DIRS[@]}"
}
