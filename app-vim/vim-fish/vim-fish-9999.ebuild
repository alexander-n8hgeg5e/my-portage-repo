# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

EGIT_REPO_URI="${CODEDIR}""/${PN}/"

inherit git-r3

DESCRIPTION="fish vim syntax"
HOMEPAGE=""
LICENSE=""


VIM_PLUGIN_HELPFILES="README"
VIM_PLUGIN_MESSAGES="filetype"
