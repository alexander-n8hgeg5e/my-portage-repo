# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3
DESCRIPTION="The addon reduces visible light radiation of computer screens that show firefox."
HOMEPAGE="http://github.com/darkreader/darkreader"
EGIT_REPO_URI="${CODEDIR}/${PN} ${MYGITHUB_URIBASE}${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND} www-client/firefox"
BDEPEND="net-libs/nodejs[nmp]"

src_compile(){
	npm install
	npm run debug || exit 1
}

src_install(){
	zip -r darkreader.xpi /src
	insinto /usr/lib64/firefox/browser/extensions
	doins  darkreader.xpi
}
