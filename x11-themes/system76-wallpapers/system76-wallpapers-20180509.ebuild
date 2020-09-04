# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# This is the latest commit as of 2020-09-04.
REV="d6171e2708cb91fc3f5a7e6749cbfb27a547ca9f"

DESCRIPTION="Wallpaper collection shipped with System76 products"
HOMEPAGE="https://system76.com/swag/desktop-wallpapers https://launchpad.net/system76-wallpapers"
SRC_URI="https://github.com/pop-os/system76-wallpapers/archive/${REV}.tar.gz -> ${P}.tar.gz"

# Launchpad lists the license as "Creative Commons - Attribution Share Alike".
LICENSE="CC-BY-SA-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${REV}"

src_install() {
	insinto /usr/share/backgrounds/${PN}
	doins -r backgrounds/*
}
