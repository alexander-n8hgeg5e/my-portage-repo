# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3
DESCRIPTION="live search filesystem, useing notmuch"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}""/notmuchfs https://github.com/alexander-n8hgeg5e/notmuchfs.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-mail/notmuch
		sys-fs/fuse:0
"
RDEPEND="${DEPEND}"

src_install(){
	dobin notmuchfs
	dobin mutt/bin/notmuch_tag
	dobin mutt/bin/prompt_mkdir
}
