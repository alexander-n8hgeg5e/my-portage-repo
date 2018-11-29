# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="brother printer driver"
HOMEPAGE=""
SRC_URI="${HOMEDIR}""/systeme/drucker_brother_dcp-j725dw/dcpj725dwcupswrapper-3.0.0-1.i386.deb"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
src_unpack(){
	ar -xf "${DISTDIR}/${A}"
mkdir "${S}"
cd "${S}"
tar -xf ../data.tar.gz
}

src_install(){
	cp -a . "${D}"
}
