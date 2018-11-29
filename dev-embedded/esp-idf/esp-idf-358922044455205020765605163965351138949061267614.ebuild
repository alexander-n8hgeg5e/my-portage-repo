# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="ESP-IDF is the official development framework for the ESP32 chip."

HOMEPAGE="https://github.com/espressif/esp-idf"
EGIT_REPO_URI="https://github.com/espressif/esp-idf"
EGIT_COMMIT=$(python -c "print(hex($PV)[2:])")
#EGIT_SUBMODULES=
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""



src_install(){
	mkdir -p "${D}/usr/src/"
	mv "${S}" "${D}/usr/src/"
}
