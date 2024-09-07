# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="tutanota desktop mail client"
HOMEPAGE="tuta.com"
inherit git-r3
EGIT_REPO_URI="https://github.com/tutao/tutanota"
EGIT_TAG="tutanota-desktop-release-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


src_configure(){
	npm run build-packages
}
