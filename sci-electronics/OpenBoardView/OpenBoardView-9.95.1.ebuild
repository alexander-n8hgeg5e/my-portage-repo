# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
inherit git-r3 xdg cmake

DESCRIPTION="Linux SDL/ImGui edition software for viewing .brd files, intended as a drop-in replacement for the \"Test_Link\" software and \"Landrex\""
HOMEPAGE="http://openboardview.org/"
EGIT_REPO_URI="https://github.com/OpenBoardView/OpenBoardView"
EGIT_COMMIT="${PV/_/-}"
SRC_URI="
	https://cvs.khronos.org/svn/repos/ogl/trunk/doc/registry/public/api/gl.xml
	https://www.khronos.org/registry/egl/api/KHR/khrplatform.h"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-libs/gtk+:3
	media-libs/libsdl2
	sys-libs/zlib
	dev-db/sqlite
	media-libs/fontconfig
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	cmake_src_prepare
}

src_compile() {
	cp "${DISTDIR}/gl.xml" src/glad/ || die
	cp "${DISTDIR}/khrplatform.h" src/glad/ || die
	#./build.sh
	cmake_src_compile
}
src_install() {
	dolib.so "${BUILD_DIR}/src/glad/libglad.so"
	cmake_src_install
}
