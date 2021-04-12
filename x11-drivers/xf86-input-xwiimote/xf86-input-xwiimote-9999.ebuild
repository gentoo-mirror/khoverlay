# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/dvdhrm/xf86-input-xwiimote.git"
inherit eutils git-r3 autotools

DESCRIPTION="X.Org Wii Remote Input Driver"
HOMEPAGE="https://github.com/dvdhrm/xf86-input-xwiimote"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="games-util/xwiimote
	x11-base/xorg-server[udev]
	>=x11-misc/util-macros-1.8"

DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
	elibtoolize
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
	insinto /etc/X11/xorg.conf.d
	doins "${S}"/60-xorg-xwiimote.conf
}
