# Copyright 2021-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_REV=9f043a0bb8609c940549939d0d20fe0c796fe74c

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
	doman git-summary.1
}
