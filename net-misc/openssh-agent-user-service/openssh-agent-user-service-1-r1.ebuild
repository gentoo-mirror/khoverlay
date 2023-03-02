# Copyright 2021-2023 Bryan Gardiner <bog@khumba.net>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="systemd user service file for ssh-agent"
HOMEPAGE="http://khumba.net/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-misc/openssh"
DEPEND=""

S="${WORKDIR}"

src_install() {
	systemd_douserunit "${FILESDIR}/ssh-agent.service"
}

pkg_postinst() {
	elog "Run the following as the user you wish to enable the agent for:"
	elog ""
	elog "    systemctl enable --user --now ssh-agent.service"
	elog ""
	elog "Or to enable for all users by default, run the following as root:"
	elog ""
	elog "    systemctl enable --global ssh-agent.service"
	elog ""
	elog "You will also need to set the following variable in your session,"
	elog "for example in \$HOME/.profile:"
	elog ""
	elog "    export SSH_AUTH_SOCK=/run/user/\$UID/ssh-agent"
}
