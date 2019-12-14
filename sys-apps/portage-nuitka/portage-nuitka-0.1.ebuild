# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="compiles portage with nuitka"
HOMEPAGE=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="sys-apps/portage"

src_unpack(){
	mkdir "${S}"
}

src_compile(){
	python3.6 -m nuitka --jobs=8 \
		--follow-imports \
		--recurse-all \
		--include-package=portage \
		--include-package=_emerge \
		--include-package=repoman \
		--recurse-all \
		--unstripped \
		/usr/lib/python-exec/python3.6/emerge || die
}

src_install(){
	mv emerge.bin emerge.nuitka
	dobin emerge.nuitka
}
