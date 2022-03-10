# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV="07af16ddc63de0a420445d590f85c96cec893350"

DESCRIPTION="Catppuccin theme for GRUB"
HOMEPAGE="https://github.com/catppuccin/grub"
SRC_URI="https://github.com/catppuccin/grub/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="sys-boot/grub"

S="${WORKDIR}/grub-${GIT_REV}"

src_install() {
	insinto /usr/share/grub/themes
	doins -r catppuccin-grub-theme
}

pkg_postinst() {
	elog "To use this theme:"
	elog
	elog "1. Have GRUB install this theme to /boot, by rerunning grub-install with"
	elog "your usual arguments and adding --themes:"
	elog
	elog "    grub-install ... --themes=catppuccin-grub-theme"
	elog
	elog "2. Tell GRUB to use the theme in /etc/default/grub:"
	elog
	elog "    GRUB_THEME=\"/boot/grub/themes/catppuccin-grub-theme/theme.txt\""
	elog
	elog "3. Regenerate grub.cfg to make your changes take effect:"
	elog
	elog "    # grub-mkconfig -o /boot/grub/grub.cfg"
}
