# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3
DESCRIPTION="runs with hardcoded user id 1000"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}""/offlineimap-openrc-service ${MYGITHUB_URIBASE}offlineimap-openrc-service.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
	doinitd etc/init.d/offlineimap
}

pkg_postinst() {
    touch /var/log/offlineimap
    chown 1000:1000 /var/log/offlineimap
    chmod g=rw,o=r /var/log/offlineimap
}
