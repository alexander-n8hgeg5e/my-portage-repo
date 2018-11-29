# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )
inherit eutils distutils-r1
#DESCRIPTION="pip3 ipython install"
DESCRIPTION="Advanced interactive shell for Python"
HOMEPAGE="http://ipython.org/"
LICENSE="BSD"
SLOT="6"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"


CDEPEND="
	dev-python/decorator[${PYTHON_USEDEP}]
        dev-python/pexpect[${PYTHON_USEDEP}]
        dev-python/pickleshare[${PYTHON_USEDEP}]
        dev-python/pyparsing[${PYTHON_USEDEP}]
        dev-python/simplegeneric[${PYTHON_USEDEP}]
        >=dev-python/jedi-0.10.0[${PYTHON_USEDEP}]
        >=dev-python/traitlets-4.2.1[${PYTHON_USEDEP}]
        >=dev-python/prompt_toolkit-1.0.3[${PYTHON_USEDEP}]"

RDEPEND="${CDEPEND}
        virtual/python-pathlib[${PYTHON_USEDEP}]
        dev-python/traitlets\
         dev-python/pickleshare\
         dev-python/prompt_toolkit\
         dev-python/typing
                            "

###   I want Ipython V6  and V5 parallel installed. So this is Slot 0 and Target python3
###   Slot 1 is only pythontarget 2.7.
###   Collisions detected only:
###   /usr/bin/iptest , /usr/share/man/man1/ipython.1.bz2 , /usr/bin/ipython
###   I will rename them for slot6 from ipython to ipython6.
###   slot 1 is not changed because it is a dependency for sagemath.
###   Sagemath needs pythontarget 2.7.


#pkg_preinst(){ ##actually called after install phase but before merging to filesystem
	#Rename the prementioned files
	#This expands to the temporary installation dir: ${D}
#	mv ${D}/usr/bin/iptest ${D}/usr/bin/iptest6 || die "rename failed!"
#	mv ${D}/usr/share/man/man1/ipython.1.bz2 ${D}/usr/share/man/man1/ipython6.1.bz2 || die "rename failed!"
#	mv ${D}/usr/bin/ipython ${D}/usr/bin/ipython6|| die "rename failed!"
#	}

#pkg_setup()
#{
#mkdir -p ${S}/usr
#}


#src_install() {
#pip3 install --isolated --install-option="--prefix=${D}/usr" ipython==${PVR}|| die "Install failed!"
#
#}
