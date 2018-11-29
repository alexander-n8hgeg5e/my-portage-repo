# Copyright 2014 Virgil Dupras
# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_4 )

inherit eutils python-r1

MY_P="${PN}-src-${PV}"
SRC_URI="http://download.hardcoded.net/${MY_P}.tar.gz"
S=${WORKDIR}
RS=${S}/build/dupeguru-${DG_EDITION}-arch
DEST=/usr/share/dupeguru_${DG_EDITION}

RDEPEND="${PYTHON_DEPS}
	dev-python/PyQt4[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/virtualenv[${PYTHON_USEDEP}]"

src_configure() {
	virtualenv -p python3 --system-site-packages env
	./env/bin/pip install -r requirements.txt
	./env/bin/python configure.py --edition ${DG_EDITION}
}

src_compile() {
	./env/bin/python build.py
	./env/bin/python -c "import package; package.package_arch('${DG_EDITION}')"
	./env/bin/python -c "from package import filereplace, json; debopts = json.load(open('debian/${DG_EDITION}.json')); filereplace('debian/dupeguru.desktop', '${RS}/dupeguru-${DG_EDITION}.desktop', **debopts)"
}

src_install() {
	doicon ${WORKDIR}/images/dg${DG_EDITION}_logo_128.png
	domenu ${RS}/dupeguru-${DG_EDITION}.desktop
	insinto ${DEST}
	doins -r ${RS}/*
	fperms a+x ${DEST}/run.py
	dosym ${DEST}/run.py /usr/bin/dupeguru_${DG_EDITION}
}

