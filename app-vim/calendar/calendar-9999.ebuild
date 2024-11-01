# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin git-r3

DESCRIPTION="vim plugin: calendar window"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=52"
LICENSE="vim"
KEYWORDS="amd64 ~mips ppc x86"
EGIT_REPO_URI="http://github.com/mattn/calendar.vim"
EGIT_COMMIT="797854b37611bd103c16c56e4b4cbf0738746a79"

VIM_PLUGIN_HELPFILES="${PN}.txt"
