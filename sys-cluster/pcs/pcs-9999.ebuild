# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7


PYTHON_COMPAT=( python3_{8,9} )
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
inherit git-r3 autotools python-r1

DESCRIPTION="pacemaker cluster management software"
HOMEPAGE="github"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/pcs-remove-systemd-dependency.patch"
	"${FILESDIR}/pcs-allow-unknown-distro.patch"
)

src_configure(){
	eautoreconf
	default_src_configure
	eautomake
}
