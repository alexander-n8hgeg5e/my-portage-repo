# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3
DESCRIPTION="gitsuperpushpull helps to push local messy git submodule trees to other machines"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}""/gitsuperpushpull https://github.com/alexander-n8hgeg5e/gitsuperpushpull.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
dobin gitsuperpush
dosym gitsuperpush ${EPREFIX}/usr/bin/gsp    # alias
}
