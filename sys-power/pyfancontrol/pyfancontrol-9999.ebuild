# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3
DESCRIPTION="pyfancontrol controls my graphics cards fan"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} sys-apps/openrc"

src_install(){
	doinitd etc/init.d/pyfancontrol

etc_confd_dir="etc/conf.d"
dodir "${etc_confd_dir}"
insinto "${etc_confd_dir}"
doins "${etc_confd_dir}/pyfancontrol"

dobin pyfancontrol
}
