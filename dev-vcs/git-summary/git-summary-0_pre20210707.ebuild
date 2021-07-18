# Copyright 2021 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GIT_REV=c7a3ebbeb4fd246e5e8017e62e4f4884c3259f79

DESCRIPTION="Summarizes statuses of multiple local repositories"
HOMEPAGE="https://github.com/MirkoLedda/${PN}"
SRC_URI="https://github.com/MirkoLedda/${PN}/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="sys-apps/gawk"

S="${WORKDIR}/${PN}-${GIT_REV}"

DOCS=(README.md)

src_install() {
	einstalldocs
	dobin git-summary
}
