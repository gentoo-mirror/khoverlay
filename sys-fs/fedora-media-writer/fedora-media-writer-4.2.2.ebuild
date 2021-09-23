# Copyright 2021 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="GUI for writing Fedora (and other OS) images to portable drives"
HOMEPAGE="https://github.com/FedoraQt/MediaWriter"
SRC_URI="https://github.com/FedoraQt/MediaWriter/archive/refs/tags/4.2.2.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-qt/qtcore-5.12.0:5
	>=dev-qt/qtdbus-5.12.0:5
	>=dev-qt/qtgui-5.12.0:5
	>=dev-qt/qtnetwork-5.12.0:5
	>=dev-qt/qtquickcontrols-5.12.0:5
	>=dev-qt/qtquickcontrols2-5.12.0:5
	>=dev-qt/qtwidgets-5.12.0:5
	>=x11-themes/adwaita-qt-1.2.1
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/MediaWriter-${PV}"
