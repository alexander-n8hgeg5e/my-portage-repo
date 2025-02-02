# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3
DESCRIPTION="libreboot"
HOMEPAGE=""
EGIT_REPO_URI="https://notabug.org/libreboot/lbmk.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack(){
	default_src_unpack
}
src_prepare(){
	default_src_prepare
}
