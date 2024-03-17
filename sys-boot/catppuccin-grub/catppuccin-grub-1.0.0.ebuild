# Copyright 2022, 2024 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Soothing pastel theme for GRUB"
HOMEPAGE="https://github.com/catppuccin/grub"
SRC_URI="https://github.com/catppuccin/grub/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="sys-boot/grub"

S="${WORKDIR}/grub-${PV}"

src_install() {
	insinto /usr/share/grub/themes
	doins -r src/catppuccin-{latte,frappe,macchiato,mocha}-grub-theme
}

pkg_postinst() {
	elog "To use this theme:"
	elog
	elog "1. Have GRUB install this theme to /boot, by rerunning grub-install with"
	elog "your usual arguments and adding --themes.  Choose a FLAVOUR from among"
	elog "latte (lightest), frappe, macchiato, mocha (darkest):"
	elog
	elog "    grub-install ... --themes=catppuccin-FLAVOUR-grub-theme"
	elog
	elog "2. Tell GRUB to use the theme in /etc/default/grub:"
	elog
	elog "    GRUB_THEME=\"/boot/grub/themes/catppuccin-FLAVOUR-grub-theme/theme.txt\""
	elog
	elog "3. Regenerate grub.cfg to make your changes take effect:"
	elog
	elog "    # grub-mkconfig -o /boot/grub/grub.cfg"
}
