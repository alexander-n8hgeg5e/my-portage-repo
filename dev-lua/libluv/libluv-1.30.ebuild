# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils
DESCRIPTION="'libuv bindings for luajit and lua 5.1/5.2."
HOMEPAGE=""
SRC_URI="/tmp/libluv-1.30.tar"
SHA256SUM='5cc75a012bfa9a5a1543d0167952676474f31c2d7fd8d450b56d8929dbebb5ef'

LICENSE="apache"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/luajit dev-libs/libuv"
RDEPEND="${DEPEND}"
BDEPEND=""

