# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools multilib flag-o-matic

DESCRIPTION="The most advanced non-linear video editor and compositor"
HOMEPAGE="http://www.cinelerra.org/"
SRC_URI="https://git.cinelerra-cv.org/gitweb?p=CinelerraCV.git;a=snapshot;h=8a03a400e69c6f4b1e56a1b81c30ea6b851a52f3;sf=tgz -> $P.tar.gz"
GITSHORTHASH="8a03a40"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="cpu_flags_x86_3dnow alsa altivec css debug ieee1394 cpu_flags_x86_mmx opengl oss"

RDEPEND="media-libs/a52dec:=
	media-libs/faac:=
	media-libs/faad2:=
	>=media-libs/freetype-2
	media-libs/fontconfig
	media-libs/libdv:=
	>=media-libs/libogg-1.2:=
	media-libs/libpng:0=
	media-libs/libsndfile:=
	>=media-libs/libtheora-1.1:=
	>=media-libs/libvorbis-1.3:=
	>=media-libs/openexr-1.5:=
	media-libs/tiff:0=
	media-libs/x264:=
	media-sound/lame:=
	>=media-video/mjpegtools-2
	>=sci-libs/fftw-3
	x11-libs/libX11:=
	x11-libs/libXext:=
	x11-libs/libXft:=
	x11-libs/libXv:=
	x11-libs/libXvMC:=
	x11-libs/libXxf86vm:=
	virtual/ffmpeg
	|| ( media-video/ffmpeg:0[postproc(-)] media-libs/libpostproc )
	virtual/jpeg:0
	alsa? ( media-libs/alsa-lib:= )
	ieee1394? (
		media-libs/libiec61883:=
		>=sys-libs/libraw1394-1.2.0:=
		>=sys-libs/libavc1394-0.5.0:=
		)
	opengl? (
		virtual/glu
		virtual/opengl
		)"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	cpu_flags_x86_mmx? ( dev-lang/nasm )"

S="${WORKDIR}/CinelerraCV-$GITSHORTHASH"

src_prepare() {
	eapply "${FILESDIR}"
    eapply_user
    ./autogen.sh
	eautoconf
}

src_configure() {
	append-cppflags -D__STDC_CONSTANT_MACROS #321945
	append-ldflags -Wl,-z,noexecstack #212959

	local myconf
	use debug && myconf='--enable-x-error-output'
	myconf="${myconf} --with-buildinfo=git"

	econf \
		$(use_enable oss) \
		$(use_enable alsa) \
		--disable-esd \
		$(use_enable ieee1394 firewire) \
		$(use_enable css) \
		$(use_enable cpu_flags_x86_mmx mmx) \
		#--without-pic
		$(use_enable cpu_flags_x86_3dnow 3dnow) \
		$(use_enable altivec) \
		$(use_enable opengl) \
		--with-plugindir=/usr/$(get_libdir)/${PN} \
		--with-buildinfo=cust/"Gentoo - ${PV}" \
		--with-external-ffmpeg \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	rm -rf "${D}"/usr/include
	rm "${D}"/usr/share/applications/cinelerra-cv.desktop
	dosym /usr/bin/mpeg2enc /usr/$(get_libdir)/${PN}/mpeg2enc.plugin
}
