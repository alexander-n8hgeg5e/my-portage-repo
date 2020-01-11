# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit systemd eutils toolchain-funcs fcaps

DESCRIPTION="port of the OpenBSD TFTP server, feature add: run unpriv fcap user"
HOMEPAGE="https://www.kernel.org/pub/software/network/tftp/"
SRC_URI="https://www.kernel.org/pub/software/network/tftp/${PN}/${P}.tar.xz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-macos"
IUSE="ipv6 readline selinux tcpd"

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

	newconfd "${FILESDIR}"/in.tftpd.confd-0.44 in.tftpd
	newinitd "${FILESDIR}"/in.tftpd.rc6 in.tftpd

	systemd_dounit "${FILESDIR}"/tftp.service
	systemd_dounit "${FILESDIR}"/tftp.socket

	insinto /etc/xinetd.d
	newins "${FILESDIR}"/tftp.xinetd tftp

	regex="([a-zA-Z_-]+)"
	if [[ "${TFTPD_FCAP_USERS}" =~ $regex ]];then
		rel_inst_path="usr/sbin"
		rm "${ED}/${rel_inst_path}/in.tftpd"

		for username in $TFTPD_FCAP_USERS ;do
			name="in_tftpd_${username}"
			insinto "${rel_inst_path}"
			newins tftpd/tftpd "${name}"
			fperms 0750 "/${rel_inst_path}/${name}"
			fowners "root:${name}" "/${rel_inst_path}/${name}"
		done
	fi
}

pkg_postinst() {
	for username in $TFTPD_FCAP_USERS ;do
		fcaps cap_net_bind_service "usr/sbin/in_tftpd_${username}" || die
	done
}
