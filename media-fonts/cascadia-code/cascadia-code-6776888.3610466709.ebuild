# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6

EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"
EGIT_COMMIT="d733599504811e8f3969de20368817d20e162dba"
inherit git-r3

DESCRIPTION="The cascadia-code font looks good and has ligatures."
HOMEPAGE="https://github.com/microsoft/cascadia-code"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="
	=dev-python/vttLib-6776888.3703335842
	>=dev-python/appdirs-1.4.3
	>=dev-python/attrs-18.2.0
	>=dev-python/booleanOperations-0.8.0
	>=dev-python/compreffor-0.4.6
	>=dev-python/cu2qu-1.6.6
	>=dev-python/defcon-0.5.3
	>=dev-python/fontmake-2.0.3
	>=dev-python/fontMath-0.5.0
	>=dev-python/fonttools-4.0.1
	>=dev-python/fs-2.4.9
	>=dev-python/glyphsLib-5.0.1
	>=dev-python/lxml-4.3.3
	>=dev-python/MutatorMath-2.1.2
	>=dev-python/pyclipper-1.1.0
	>=dev-python/pyparsing-2.3.1
	>=dev-python/pytz-2018.9
	>=dev-python/six-1.12.0
	>=dev-python/ufo2ft-2.9.1
	>=dev-python/ufoLib2-0.4.0
	>=dev-python/unicodedata2-12.0.0
"


src_compile(){
	python3 "${S}/build.py" || die
}

src_install(){
	dir="/usr/share/fonts/${PN}"
	dodir   "${dir}"
	insinto "${dir}"
	doins "${S}/build/CascadiaCode.ttf"
	doins "${S}/build/CascadiaCodePL.ttf"
	doins "${S}/build/CascadiaMono.ttf"
	doins "${S}/build/CascadiaMonoPL.ttf"
}
