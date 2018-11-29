# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vim-plugin git-r3

DESCRIPTION="vim plugin: quick-scope"
LICENSE="vim"
KEYWORDS="amd64 ~mips ppc x86"
EGIT_REPO_URI="${CODEDIR}/vim/quick-scope/"

VIM_PLUGIN_HELPFILES="${PN}.txt"
