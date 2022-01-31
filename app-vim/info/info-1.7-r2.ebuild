# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit nvim-plugin git-r3

DESCRIPTION="vim plugin: GNU info documentation browser"
HOMEPAGE="https://www.vim.org/scripts/script.php?script_id=21"
LICENSE="BSD"
KEYWORDS="alpha amd64 ia64 ppc s390 sparc x86"
IUSE=""
VIM_PLUGIN_HELPTEXT="This plugin adds the :Info command."
EGIT_REPO_URI="${CODEDIR}""/vim/${PN}"


src_prepare() {
	rm -r "${S}/portage"
	default
}
