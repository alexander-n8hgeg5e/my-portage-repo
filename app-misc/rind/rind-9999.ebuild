# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{6,7,8,9,10} )
inherit git-r3 eutils python-r1
DESCRIPTION="rind"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
src_configure(){
	true;
}
src_compile(){
	true;
}


src_install(){
dobin rind
dobin rindd
dobin rindoff
dobin rindv
dobin ril
python_foreach_impl python_doscript rils
}
