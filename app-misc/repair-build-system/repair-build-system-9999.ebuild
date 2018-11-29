# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="emergency ebuild if gcc was deleted"
HOMEPAGE=""
#SRC_URI="/stage3-amd64-20141002.tar.bz2"
#
SRC_URI="http://distfiles.gentoo.org/releases/amd64/autobuilds/20171228T214501Z/stage3-amd64-nomultilib-20171228T214501Z.tar.xz"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

src_unpack()
{
	mkdir ${PF}
    cd ${PF}
    #git init .
    #git add -A
    #git commit  -minital
    tar xpf  ${DISTDIR}/stage3* --xattrs-include='*.*' --numeric-owner;echo '######################################### dont care exitcode'
    #tar -xf ${DISTDIR}/${SRC_URI}
    #git add -A
    #git commit  -mstagetarball
}

src_prepare()
{
	mkdir ${S}/usr/portage
    rsync -ruiv --exclude=/distfiles --exclude=/*games* --exclude=/app-emacs --exclude=/x11-apps /usr/portage/ ${S}/usr/portage/
    rm ${S}/etc/portage/profile
    ln -s ${S}/usr/portage/profiles/arch/amd64 ${S}/etc/portage/profile
	cat ${FILESDIR}/make.conf >> ${S}/etc/portage/make.conf
    default_src_prepare
}

src_install()
{
    emerge --root=${D} --config-root=${S} --nodeps --keep-going sys-devel/gcc

}
