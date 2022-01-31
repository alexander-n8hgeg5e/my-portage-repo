# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 eutils
DESCRIPTION="paceit-toolbox"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
src_configure(){
	true;
}


src_install(){
dobin paceit
dobin wo
# target  name
dosym paceit /usr/bin/vv    # alias
dosym paceit /usr/bin/v    # alias
dobin parse_py_infile
dobin add_curvature
dobin gen_doc_tags
}
