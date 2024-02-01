# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit systemd toolchain-funcs fcaps

DESCRIPTION="port of the OpenBSD TFTP server, feature add: run unpriv fcap user"
HOMEPAGE="https://www.kernel.org/pub/software/network/tftp/"
SRC_URI="https://www.kernel.org/pub/software/network/tftp/${PN}/${P}.tar.xz"

LICENSE="BSD-4"
SLOT="1" #  vim slot change: %s/s1/s1/g|%s/SLOT="0"/SLOT="1"/
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-macos"
IUSE="ipv6 readline selinux tcpd systemd"

CDEPEND="
	readline? ( sys-libs/readline:0= )
	tcpd? ( sys-apps/tcp-wrappers )
	!net-ftp/atftp
	!net-ftp/netkit-tftp"
DEPEND="${CDEPEND}
	app-arch/xz-utils"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-tftp )
"
src_prepare() {
	einfo "TFTPD_FCAP_USERS=${TFTPD_FCAP_USERS}"
	eapply_user

	sed -i "/^AR/s:ar:$(tc-getAR):" MCONFIG.in || die
}

src_configure() {
	econf \
		$(use_with ipv6) \
		$(use_with tcpd tcpwrappers) \
		$(use_with readline)
}

src_install() {
	emake INSTALLROOT="${D}" install
	dodoc README* CHANGES tftpd/sample.rules

	# iputils installs this
	rm "${ED}"/usr/share/man/man8/tftpd.8 || die

	newconfd "${FILESDIR}"/in.tftpd.confd-0.44 in.tftpd_s1
	newinitd "${FILESDIR}"/in.tftpd.rc6 in.tftpd_s1

	if use systemd;then
		systemd_dounit "${FILESDIR}"/tftp_s1.service
		systemd_dounit "${FILESDIR}"/tftp_s1.socket
	fi

	insinto /etc/xinetd.d
	newins "${FILESDIR}"/tftp.xinetd tftp_s1

	#---------------------------#
	#  handle colliding files   #
	#---------------------------#
	mv "${ED}/usr/sbin/in.tftpd"             "${ED}/usr/sbin/in.tftpd_s1"             || die
	mv "${ED}/usr/bin/tftp"                  "${ED}/usr/bin/tftp_s1"                  || die
	mv "${ED}/usr/share/man/man1/tftp.1"     "${ED}/usr/share/man/man1/tftp_s1.1"     || die
	mv "${ED}/usr/share/man/man8/in.tftpd.8" "${ED}/usr/share/man/man8/in.tftpd_s1.8" || die
	if [[ $SLOT -eq 0 ]];then
		dosym "in.tftpd_s1" 	"usr/sbin/in.tftpd"                  || die
		dosym "tftp_s1"     	"/usr/bin/tftp"                      || die
		dosym "tftp_s1.1"     	"/usr/share/man/man1/tftp.1"         || die
		dosym "in.tftpd_s1.8"   "/usr/share/man/man8/in.tftpd.8"     || die
	fi

	#------------#
	# fcap_users #
	#------------#
	rel_inst_path="usr/sbin"
	regex="([a-zA-Z_-]+)"
	if [[ "${TFTPD_FCAP_USERS}" =~ $regex ]];then
		for username in $TFTPD_FCAP_USERS ;do
			name="in_tftpd_fc_s1_${username}"
			insinto "${rel_inst_path}"
			newins tftpd/tftpd "${name}"
			fperms 0750 "/${rel_inst_path}/${name}"
			fowners "root:${username}" "/${rel_inst_path}/${name}"
		done
	fi
}

pkg_postinst() {
	for username in $TFTPD_FCAP_USERS ;do
		fcaps cap_net_bind_service,cap_setgid,cap_setuid,cap_sys_chroot=ep "usr/sbin/in_tftpd_fc_s1_${username}" || die
	done
}
