# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3
DESCRIPTION="wrapper to access dotfiles git repo with dotfiles cmd"
EGIT_REPO_URI="${CODEDIR}/dotfiles_git_alias/"
HOMEPAGE=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
dobin dotfiles
}
