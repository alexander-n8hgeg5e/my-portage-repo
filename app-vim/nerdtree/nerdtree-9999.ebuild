# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin git-r3

#EGIT_COMMIT="8a6ae7c6338378b6bb28ad0cf03e71ff0fd11a5a"
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

DESCRIPTION="vim plugin: A tree explorer plugin for navigating the filesystem"
LICENSE="WTFPL-2"
KEYWORDS="~amd64"

VIM_PLUGIN_HELPFILES="NERDTree.txt"

src_prepare() {
	rm LICENCE screenshot.png || die
	default
}
