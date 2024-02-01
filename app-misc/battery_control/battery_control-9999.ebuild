# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8,9,10} )
inherit distutils-r1 git-r3
DESCRIPTION="laptop charging control"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}""/battery_control/"
LICENSE="gpl3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
	doinitd etc/init.d/battery_control
	doinitd etc/init.d/battery_alarm
    distutils-r1_src_install
#	dobin charging.py
#	dobin charging_alarm.py
}

pkg_preinst() {
    enewgroup ${PN}
    enewuser ${PN} -1 -1 /dev/null ${PN}
    touch /var/log/${PN}
    touch /var/log/battery_alarm
    chown ${PN}:${PN} /var/log/battery_alarm
    chown ${PN}:${PN} /var/log/${PN}
    chmod g=rw,o=r /var/log/battery_alarm
    chmod g=rw,o=r /var/log/${PN}
}
