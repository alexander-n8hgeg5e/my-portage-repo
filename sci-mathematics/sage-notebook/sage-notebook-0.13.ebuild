# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )
MY_PN="sagenb"
MY_P="${MY_PN}"-${PV}
python_moduleroot="${MY_PN}"
PYTHON_REQ_USE="ssl"

inherit distutils-r1 eutils user

DESCRIPTION="The Sage Notebook is a web-based graphical user interface for sage"
HOMEPAGE="http://nb.sagemath.org"
#SRC_URI="mirror://sageupstream/${MY_PN}/${MY_P}.tar.bz2"
SRC_URI="https://github.com/sagemath/sagenb/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86-linux"
IUSE="+java server test"

RESTRICT="mirror test"

DEPEND=">=dev-python/pexpect-4.0.1-r1[${PYTHON_USEDEP}]
	>=dev-python/twisted-core-14.0.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-mail-14.0.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-web-14.0.0[${PYTHON_USEDEP}]
	!dev-python/twisted-web2
	>=dev-python/jinja-2.5.5[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.5[${PYTHON_USEDEP}]
	<dev-python/flask-0.11[${PYTHON_USEDEP}]
	>=dev-python/flask-autoindex-0.5[${PYTHON_USEDEP}]
	>=dev-python/flask-openid-1.2.3[${PYTHON_USEDEP}]
	dev-python/flask-oldsessions[${PYTHON_USEDEP}]
	>=dev-python/flask-babel-0.8[${PYTHON_USEDEP}]
	dev-python/webassets[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-libs/mathjax
	java? ( >=sci-chemistry/sage-jmol-bin-14.2.11 )"

PDEPEND="sci-mathematics/sage[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_export python2_7 EPYTHON PYTHON PYTHON_SITEDIR

	# create user to run the server
	if use server ; then
		enewgroup sage
		enewuser sage -1 /bin/bash /var/lib/sage sage
	fi
}

src_prepare() {
	# do not ship sage3d
	epatch "${FILESDIR}"/${PN}-0.10.7-setup.py.patch

	# remove sage3d
	rm -rf sagenb/data/sage3d || die "failed to remove sage3d"

	# use system mathjax
	rm -rf sagenb/data/mathjax || die "failed to remove mathjax"

	# correct path for jmol
	epatch "${FILESDIR}"/${PN}-0.11.7-base.patch

	# fix SAGE_ROOT
	epatch "${FILESDIR}"/${PN}-0.9.1-notebook.patch

	mkdir conf.d || die "failed to create directory"
	mkdir init.d || die "failed to create directory"

	cp "${FILESDIR}"/${PN}-0.10.2 init.d/${PN} || die "failed to copy file"
	cp "${FILESDIR}"/${PN}.conf-0.10.2 conf.d/${PN} || die "failed to copy file"

	distutils-r1_src_prepare
}

python_install_all() {
	# install runscript+configuration file to run the notebook as a daemon
	if use server ; then
		doinitd init.d/${PN}
		doconfd conf.d/${PN}
		dodir /var/lib/sage/.matplotlib
		insinto /var/lib/sage/.matplotlib
		doins "${FILESDIR}"/matplotlibrc
	fi

	distutils-r1_python_install_all

	# link in system mathjax
	ln -snf "${EPREFIX}"/usr/share/mathjax \
		"${D}$(python_get_sitedir)"/sagenb/data/mathjax || die
}

pkg_preinst() {
	# remove old mathjax folder if present
	[[ -d "${ROOT}$(python_get_sitedir)/sagenb/data/mathjax" ]] \
		&& rm -rf "${ROOT}$(python_get_sitedir)/sagenb/data/mathjax"
}

pkg_postinst() {
	einfo "If you experience the following error when starting a SSL secured notebook:"
	einfo "  'You must install certtool to use the secure notebook server.'"
	einfo "install net-libs/gnutls."
}
