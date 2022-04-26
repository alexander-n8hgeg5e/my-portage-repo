# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6

LICENSE="GPL-2"
PYTHON_COMPAT=( python3_{6,7,8,9,10} )

inherit git-r3 distutils-r1

DESCRIPTION="choose and open url similar to urlview"
HOMEPAGE="https://github.com/firecat53/urlscan"
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/firecat53/urlscan"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} dev-python/urwid[$PYTHON_USEDEP]"
