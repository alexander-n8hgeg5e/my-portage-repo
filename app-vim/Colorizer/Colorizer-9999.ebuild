# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

#inherit git-r3 vim-plugin
inherit git-r3 nvim-plugin

DESCRIPTION="colorizes colorsequences"
HOMEPAGE=""

LICENSE="vim"
KEYWORDS="~amd64"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin does something"

