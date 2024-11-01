# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}""/${PN}/"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"


src_install(){
dobin gentooify
dodir "/usr/share/${PN}"
insinto "/usr/share/${PN}"
doins license_notice_multifileprog
doins license_notice_onefileprog
doins ebuild-templates/*
}
