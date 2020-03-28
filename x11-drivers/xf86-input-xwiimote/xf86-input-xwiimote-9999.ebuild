# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=4

EGIT_REPO_URI="https://github.com/dvdhrm/xf86-input-xwiimote.git"
inherit eutils git-r3 autotools

DESCRIPTION="X.Org Wii Remote Input Driver"

HOMEPAGE="https://github.com/dvdhrm/xf86-input-xwiimote"

SRC_URI=""

LICENSE="BSD"

SLOT="0"

IUSE=""

DEPEND="games-util/xwiimote
	x11-base/xorg-server[udev]
	>=x11-misc/util-macros-1.8"

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
	doins "${S}"/60-xorg-xwiimote.conf
}
