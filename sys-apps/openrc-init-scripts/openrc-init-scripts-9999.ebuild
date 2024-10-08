# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3
DESCRIPTION="my init scripts"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND} sys-apps/openrc
	acct-group/cg_bg
	acct-group/cg_realtime
"

src_install(){
	hostname="$(hostname)"
	doinitd etc/init.d/nbd-swap
	doinitd etc/init.d/x
	doinitd etc/init.d/node
	doinitd etc/init.d/in-tftpd-node
	doinitd etc/init.d/nbd-server
	doinitd etc/init.d/nbd-server-part

	etc_confd_dir="etc/conf.d"
	dodir "${etc_confd_dir}"
	insinto "${etc_confd_dir}"
	doins "${etc_confd_dir}/bootmisc"

	"usr/sbin/in_tftpd_all"
	dosym "in.tftpd" "usr/sbin/in_tftpd_all"

	# set_netifnames tool
	dosbin usr/sbin/set_netifnames
	doinitd etc/init.d/netifnames
	doinitd etc/init.d/cg_bg
	doinitd etc/init.d/cg_realtime
	dosbin usr/sbin/gen_io_lat_strings
	dosbin usr/sbin/gen_cgroup_io_controller_setup_strings
	doinitd etc/init.d/run_subdirs
	doinitd etc/init.d/tmp
	doinitd etc/init.d/tmp-backing-remote
	doinitd etc/init.d/tmp-backing-local
	doinitd etc/init.d/tmp_subdirs
	doinitd etc/init.d/nbd-blockdev
	doinitd etc/init.d/remote-service
	doinitd etc/init.d/cluster-service-linkname-config
	doinitd etc/init.d/cluster-service
	doinitd etc/init.d/depend-on
	doinitd etc/init.d/ramdisk-file
	doinitd etc/init.d/net.node
	doinitd etc/init.d/link-name-provide
	doinitd etc/init.d/node-bootpart
	doinitd etc/init.d/integrity-swap
	doinitd etc/init.d/integrity-swap_v2

	lib_rc_sh_dir="lib/rc/sh"
	dodir   "${lib_rc_sh_dir}"
	insinto "${lib_rc_sh_dir}"
	doins "${lib_rc_sh_dir}/rc-linkname-parsers.sh"

	doinitd etc/init.d/prepare_sysklogd
	doinitd etc/init.d/wait-ceph-pool
	doinitd etc/init.d/wait-nodes
	doinitd etc/init.d/wait-node
	doinitd etc/init.d/netmount
	doinitd etc/init.d/wait-ceph-mds
	doinitd etc/init.d/qtile
	doinitd etc/init.d/wayvnc
	doinitd etc/init.d/integrity-dev
}
