# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=8

EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
inherit git-r3

DESCRIPTION="colorscheme for qutebrowser"
HOMEPAGE="https://gitlab.com/jjzmajic/qutewal"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="inotify"

DEPEND=""
RDEPEND="${DEPEND} www-client/qutebrowser  inotify? ( dev-python/psutil dev-python/inotify_simple dev-python/python-prctl )"

src_install(){
dodir /usr/share/qutebrowser/colorschemes/${PN}
insinto /usr/share/qutebrowser/colorschemes/${PN}
doins qutewal.py
doins iqutefy.py
dodir /usr/share/qutebrowser/colorschemes/${PN}/scrots
insinto /usr/share/qutebrowser/colorschemes/${PN}/scrots
doins scrots/qutewal.gif
}
