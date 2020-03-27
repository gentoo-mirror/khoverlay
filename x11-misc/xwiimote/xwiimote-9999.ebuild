# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=4

EGIT_REPO_URI="https://github.com/dvdhrm/xwiimote.git"
inherit eutils git-r3 autotools

DESCRIPTION="Nintendo Wii Remote Linux Device Driver Tools"

HOMEPAGE="https://github.com/dvdhrm/xwiimote"

SRC_URI=""

LICENSE="BSD"

SLOT="0"

IUSE=""

DEPEND="sys-libs/ncurses
		virtual/udev"

RDEPEND="${DEPEND}"

src_prepare()
{
	eautoreconf
	elibtoolize
}

src_install()
{
	emake DESTDIR="${D}" install || die

	insinto /etc/X11/xorg.conf.d
	doins "${S}"/res/50-xorg-fix-xwiimote.conf
}
