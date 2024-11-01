# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )

inherit autotools git-r3 python-r1

DESCRIPTION="LinuxCNC "
HOMEPAGE="http://linuxcnc.org/"
#SRC_URI="mirror://sourceforge/gentoocnc/distfiles/${P}.tar.gz"
#SRC_URI="https://github.com/LinuxCNC/linuxcnc/archive/2.7.zip"
#SRC_URI="http://linuxcnc.org/dists/stretch/2.7-uspace/source/${PN}_${PV}.tar.xz"
EGIT_REPO_URI="${CODEDIR}/${PN} ${MYGITHUB_URIBASE}${PN}.git"

LICENSE="LGPL-3"
SLOT="linuxcnc-2.8"
KEYWORDS="~amd64 ~x86"
IUSE="+python +uspace +X +gtk +rt gnome gstreamer modbus simulator usb"
# TODO: add shmdrv use flag


# --disable-python uses python anyways and fails so python is a required use flag
REQUIRED_USE="
	python
	python? ( ${PYTHON_REQUIRED_USE} )
	rt? ( !simulator )
	"

DEPEND="dev-lang/tcl
	dev-lang/tk
	dev-tcltk/tkimg
	dev-tcltk/tclx
	dev-libs/boost[python]
	modbus? ( <dev-libs/libmodbus-3.1 )
	dev-tcltk/bwidget
	gtk? ( x11-libs/gtk+
		dev-python/pygtk[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/pygtkglext[${PYTHON_USEDEP}]
		dev-python/pygtksourceview[${PYTHON_USEDEP}]
	)
	gnome? (
		dev-python/gnome-python-base
		dev-util/glade[python]
		gnome-base/libgnomeprintui
	)
	gstreamer? (
		dev-python/gst-python:0.10
		media-libs/gst-plugins-base:0.10
	)
	x11-libs/libXinerama
	usb? ( virtual/libusb )
	dev-lang/python[tk]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/pillow[tk,${PYTHON_USEDEP}]
	media-libs/mesa
	x11-apps/mesa-progs
	X? (
	x11-libs/libXaw
	dev-python/python-xlib[${PYTHON_USEDEP}]
	)
	rt? ( sys-kernel/rt-sources )
	virtual/opengl
	virtual/glu
	${PYTHON_DEPS}
	sys-devel/gettext
	sys-process/procps
	sys-process/psmisc
	net-firewall/iptables
	media-gfx/graphviz
	net-libs/libtirpc
"
RDEPEND="${DEPEND}
	X? ( python? ( dev-python/libgnome-python ) )
	python? ( dev-python/yapps )
	"

S="${S}/src"

src_prepare() {
	default
}

src_configure() {
	${S}/autogen.sh || eerror
	einfo "autogen.sh done"
	eautoreconf
	#myconf="--prefix=${EPREFIX}/usr --with-kernel-headers=/usr/src/linux/ $(use_with modbus libmodbus)"
	myconf="--prefix=${EPREFIX}/usr --enable-non-distributable=yes $(use_with modbus libmodbus)"

	use !gtk && myconf="${myconf} --disable-gtk2"
	use rt && myconf="${myconf} --with-realtime=uspace"
	use simulator && myconf="${myconf} --with-realtime=uspace"
	use !usb && myconf="${myconf} --without-libusb-1.0"
#	use rtai && myconf="${myconf} --with-realtime=${EPREFIX}/usr/realtime --with-module-dir=${EPREFIX}/usr/lib/linuxcnc/rtai/"
	use X && myconf="${myconf} --with-x"

	# TODO: fix that - get python version
#	use !python && myconf="${myconf} --disable-python"

	econf ${myconf}
}

src_install() {
	PORTAGE_COMPRESS=""
	emake DESTDIR="${D}" install

	local envd="${T}/51linuxcnc"
	cat > "${envd}" <<-EOF
		LDPATH="${EPREFIX}/usr/$(get_libdir)/linuxcnc"
	EOF
	doenvd "${envd}"

	insinto "/usr/share/linuxcnc/"
	doins Makefile.inc

	insinto "/etc/linuxcnc/"
	doins "../scripts/rtapi.conf"

	doicon "../linuxcncicon.png"
	make_desktop_entry linuxcnc LinuxCNC linuxcnc 'Science;Robotics'
}

pkg_postinst() {
	elog "The compiled software may not be redistributed due to use of packages with incompatible licenses."
	elog "Opening machine configuration files from older Versions can crash the application as it cannot load old named modules, e.g. probe_parport.so not found"
	elog "This is not a Gentoo- or build related error. It looks like linuxcnc 2.8 will have some kind of converter for them."
	elog "If you created them with stepconf. You can just open the stepconf file and create them new. Don't forget to backup any manual changes (e.g. backlash!) from the .hal and .ini files and make them again."
}
