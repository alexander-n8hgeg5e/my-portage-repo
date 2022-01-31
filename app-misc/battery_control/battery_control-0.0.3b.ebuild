# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8,9,10} )
inherit distutils-r1 git-r3 user eutils
DESCRIPTION="laptop charging control"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
EGIT_TAG=${PV}
LICENSE="gpl3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
	doinitd etc/init.d/battery_control
	distutils-r1_src_install
#	dobin charging.py
#	dobin charging_alarm.py
}

pkg_preinst() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 /dev/null ${PN}
	touch /var/log/${PN}
	chown ${PN}:${PN} /var/log/${PN}
	chmod g=rw,o=r /var/log/${PN}
}
