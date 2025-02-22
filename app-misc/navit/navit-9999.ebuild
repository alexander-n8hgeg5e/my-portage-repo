# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit git-r3 cmake

DESCRIPTION="An open-source car navigation system with a routing engine"
HOMEPAGE="http://www.navit-project.org"
EGIT_REPO_URI="https://github.com/navit-gps/navit.git"
EGIT_COMMIT="f759dfe3b54da9daefd636bd9f291a51cc4ccfcf"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus garmin gles gles2 gps gtk nls python sdl speechd svg"

# gps: http://trac.navit-project.org/ticket/1284
RDEPEND="dev-libs/glib:2
	garmin? ( dev-libs/libgarmin )
	gles? ( virtual/opengl )
	gles2? ( virtual/opengl )
	gtk? ( x11-libs/gtk+:2
		x11-misc/xkbd )
	sdl? ( media-libs/libsdl
		media-libs/sdl-image
		dev-games/cegui
		media-libs/quesoglc )
	python? ( dev-lang/python )
	dbus? ( sys-apps/dbus )
	gps? ( <sci-geosciences/gpsd-3.12 )
	speechd? ( app-accessibility/speech-dispatcher )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-vcs/cvs
	svg? ( || ( gnome-base/librsvg media-gfx/imagemagick[png,svg] ) )"


src_configure() {
	mycmakeargs=(
		-Dsupport/espeak:BOOL=TRUE
		-Dgraphics/qt5:BOOL=TRUE
		-Dspeech/espeak:BOOL=FALSE
		-Dspeech/speech_dispatcher:BOOL=False
		-Dgui/gtk:BOOL=FALSE
		-Dbinding/python:BOOL=FALSE
	)
	cmake-utils_src_configure
}

src_install () {
	cmake-utils_src_install

}
