# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3
DESCRIPTION="VNC server for Linux framebuffer devices"
HOMEPAGE="https://github.com/ponty/framebuffer-vncserver"
EGIT_REPO_URI='https://github.com/ponty/framebuffer-vncserver.git'
#EGIT_COMMIT="b129632d0d5168f757515f491584be4f065c3d3e"
#EVCS_OFFLINE="not empty"
LICENSE="gpl-2"
SLOT="0"
KEYWORDS=""
IUSE="static"

DEPEND="net-libs/libvncserver[static-libs]"
RDEPEND="${DEPEND}"


src_compile() {
	cmake $S
	emake
}

