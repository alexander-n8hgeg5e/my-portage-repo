# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 eutils
DESCRIPTION="rind"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
EGIT_COMMIT="af2df40219fa0b97deec328c3039608970ffc588"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
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
}
