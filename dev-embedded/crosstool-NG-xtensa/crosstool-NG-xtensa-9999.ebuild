# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="crosstool-NG-xtensa: git clone -b xtensa-1.22.x https://github.com/espressif/crosstool-NG.git"
HOMEPAGE="https://github.com/espressif"
EGIT_REPO_URI="https://github.com/espressif/crosstool-NG.git"
EGIT_BRANCH="xtensa-1.22.x"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
inherit flag-o-matic

src_configure(){
	filter-flags '*'
	./bootstrap
	export CT_TOP_DIR="${S}"
	./configure --enable-local
	make
	./ct-ng xtensa-esp32-elf
}

src_compile(){
	./ct-ng build
}
