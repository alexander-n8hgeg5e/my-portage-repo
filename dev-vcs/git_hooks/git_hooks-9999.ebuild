# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGIT_REPO_URI="${CODEDIR}""/${PN}"
inherit git-r3

DESCRIPTION=""
HOMEPAGE=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){

# fish default conf
etc_fish_confd_dir="etc/git_hooks"
dodir "${etc_fish_confd_dir}"
exeinto "${etc_fish_confd_dir}"
doexe   "${etc_fish_confd_dir}/"*

}

