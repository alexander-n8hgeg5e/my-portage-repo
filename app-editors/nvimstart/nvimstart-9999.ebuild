# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3
DESCRIPTION="start command for nvim terminal opened"
EGIT_REPO_URI="${CODEDIR}/nvimstart/"
HOMEPAGE=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
src_install(){
dobin nvimt
}
