# Copyright 2022 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=f6e26661f30838e9df4f2d7d34fce45054738d5d

DESCRIPTION="Display window geometry when moving & resizing in KWin 5.24+"
HOMEPAGE="https://www.pling.com/p/1833846/ https://gitlab.com/Worldblender/kwin-scripts"
SRC_URI="https://gitlab.com/Worldblender/kwin-scripts/-/archive/${GIT_REV}/kwin-scripts-${GIT_REV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="kde-plasma/kwin"

S="${WORKDIR}/kwin-scripts-${GIT_REV}"

src_install() {
	insinto /usr/share/kwin/scripts
	doins -r "${S}/windowgeometryinfo"
}
