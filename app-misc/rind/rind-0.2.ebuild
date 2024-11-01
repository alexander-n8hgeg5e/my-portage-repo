# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3
DESCRIPTION="rind"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
EGIT_COMMIT="2352a28dd40e890c8598326e11a36557ba0a8e4e"

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
dobin rindv
}
