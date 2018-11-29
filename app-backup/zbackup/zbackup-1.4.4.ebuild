# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="A globally-deduplicating backup tool"
HOMEPAGE="http://zbackup.org/"
SRC_URI="https://github.com/zbackup/zbackup/archive/1.4.4.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="arm amd64"
IUSE=""

DEPEND="
	>=dev-libs/openssl-1.0
	dev-libs/protobuf
	app-arch/xz-utils
	dev-libs/lzo
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
