# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9,10,11} )
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
inherit git-r3 python-any-r1 scons-utils

DESCRIPTION="tools to manage device-mapper integrity target"
HOMEPAGE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} sys-fs/lvm2"

src_compile(){
	escons
	default_src_compile
}

src_install(){
	dosbin dump-integrity-header-info
	dosbin dm-integrity-setup
}
