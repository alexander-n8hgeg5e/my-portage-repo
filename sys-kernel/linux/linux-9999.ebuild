# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Linux Kernel Install"
HOMEPAGE=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
A="/tmp/linux.tar"

DEPEND="sys-kernel/linux-config sys-kernel/gentoo-sources"
RDEPEND="${DEPEND}"

pkg_setup(){
   cd /usr/src/linux
   #tar -cf /tmp/linux.tar .
   }
