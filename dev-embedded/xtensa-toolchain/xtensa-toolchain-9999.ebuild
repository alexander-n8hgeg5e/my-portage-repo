# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="crosstool-NG-xtensa: git clone -b xtensa-1.22.x https://github.com/espressif/crosstool-NG.git"
HOMEPAGE="https://github.com/espressif"
#EGIT_REPO_URI="https://github.com/espressif/crosstool-NG.git"
#EGIT_BRANCH="xtensa-1.22.x"
inherit flag-o-matic

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-embedded/crosstool-NG-xtensa"
#CT_TOP_DIR="${S}"
#CT_PREFIX_DIR="${D}/usr/xtensa-esp32-elf"

src_unpack(){
	mkdir "${S}"
}
src_prepare(){
	filter-flags "*"
    eapply_user
}
src_configure(){
    ct-ng xtensa-esp32-elf

    r1='CT_PREFIX_DIR\=.*'
	r2="CT_PREFIX_DIR="\""${D}/usr/xtensa-esp32-elf"\"
	sedcmd="s#${r1}#${r2}#"
    sed -i "${sedcmd}" .config

    r1='CT_WORK_DIR\=.*'
	r2="CT_WORK_DIR="\""${S}"\"
	sedcmd="s#${r1}#${r2}#"
    sed -i "${sedcmd}" .config
}

src_compile(){
    ct-ng build
}
src_install(){
ls ${D}
#mkdir ${D}/usr/
#mv builds/xtensa-esp32-elf ${D}/usr/
}
