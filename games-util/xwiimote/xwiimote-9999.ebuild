# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/dvdhrm/xwiimote.git"
inherit eutils git-r3 autotools

DESCRIPTION="Nintendo Wii Remote Linux Device Driver Tools"
HOMEPAGE="https://github.com/dvdhrm/xwiimote"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="sys-libs/ncurses:0=
	virtual/udev"

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
	doins "${S}"/res/50-xorg-fix-xwiimote.conf
}
