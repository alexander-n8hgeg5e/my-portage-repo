# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3 udev
DESCRIPTION="controls the air conditioner"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} sys-apps/openrc =acct-group/rfcontrol-0 =acct-user/klima-control-0"

src_install(){
	doinitd etc/init.d/klima-control
	etc_confd_dir="etc/conf.d"
	dodir "${etc_confd_dir}"
	insinto "${etc_confd_dir}"
	doins "${etc_confd_dir}/klima-control"

	dobin klima-control
	udev_dorules etc/udev/rules.d/10-klima-control.rules
	dobin show_klima_state
	dobin count_klima_runtime
}
