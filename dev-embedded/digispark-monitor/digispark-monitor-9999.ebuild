# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="usb monitor"
HOMEPAGE="https://github.com/digistump/DigisparkExamplePrograms"
EGIT_REPO_URI="${CODEDIR}/DigisparkExamplePrograms ${MYGITHUB_URIBASE}/DigisparkExamplePrograms.git"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${S}/C++/monitor"

src_install(){
	dobin digiusb
}
