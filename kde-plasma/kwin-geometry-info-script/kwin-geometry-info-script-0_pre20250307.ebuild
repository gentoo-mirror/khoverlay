# Copyright 2022-2025 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=49f9f522284c76a8e3699231b4e81b172a6e93c7

DESCRIPTION="Display window geometry when moving & resizing"
HOMEPAGE="https://www.pling.com/p/1833846/ https://gitlab.com/Worldblender/kwin-scripts"
SRC_URI="https://gitlab.com/Worldblender/kwin-scripts/-/archive/${GIT_REV}/kwin-scripts-${GIT_REV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="kde-plasma/kwin:6"

S="${WORKDIR}/kwin-scripts-${GIT_REV}"

src_install() {
	insinto /usr/share/kwin/scripts
	doins -r "${S}/windowgeometryinfo6"
}
