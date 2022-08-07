# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7

LICENSE="MIT"

EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
inherit git-r3 meson

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
