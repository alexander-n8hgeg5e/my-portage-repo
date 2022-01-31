# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="generates kernel with genkernel and installs it"
HOMEPAGE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
IUSE="set-perms backup"

BDEPEND="dev-libs/libgcrypt[static]"

pkg_setup(){
	_GENKERNEL_CONF="/etc/genkernel.conf"
	KERNEL_SOURCE_TREE=$(source "${_GENKERNEL_CONF}" &>/dev/null && echo ${DEFAULT_KERNEL_SOURCE})
	einfo "useing kernel source-tree at: ${KERNEL_SOURCE_TREE}"
	[[ -n "${KERNEL_SOURCE_TREE}" ]] && [[ -d "${KERNEL_SOURCE_TREE}" ]] || die

	if use set-perms ; then
		einfo "setting permission of entrire kernel source tree to group=portage and g+rwX"
		find "${KERNEL_SOURCE_TREE}" \! -group portage -exec chown :portage "{}" \;
		find "${KERNEL_SOURCE_TREE}" \! -type f -perm \g=r -exec chmod g+r "{}" \;
		find "${KERNEL_SOURCE_TREE}" \! -type d -perm \g=rx -exec chmod g+rx "{}" \;
	fi

	# test for the backupmethod
	if use backup ; then
		if findmnt --fstab -a /boot ;then
			bootfstype=$(findmnt --noheadings -M /boot -o FSTYPE)
			if [ -z $bootfstype ] ;then
				mount /boot || die
				bootfstype=$(findmnt --noheadings -M /boot -o FSTYPE)
			fi
			[[ -n $bootfstype ]] || die
		else
			boot_fstype=$(findmnt --noheadings   -o FSTYPE -S $(stat /boot --format "%t:%d")|sort -u|tr -d ' ')
			mount /boot 2>/dev/null
		fi
		if [[ ${bootfstype} = btrfs ]];then
			backupmethod=btrfs
		else
			backupmethod=tar
		fi
		einfo "backupmethod: ${backupmethod}"
	else
		ewarn "no kernel backup will be made, set backup use flag to enable backups"
	fi
}

src_unpack(){
	# probably there is a better way,...
	einfo "preparing build dir..."
	rsync --info=none,progress2 -ac --delete --partial \
		--progress --exclude='/.git' \
		--exclude='/.git/***' \
		"${KERNEL_SOURCE_TREE%/}"/ "${S}" \
			|| die "ERROR: rsync failed"
}

src_prepare(){
	# need to prepare a new config

	cp /etc/genkernel.conf "${WORKDIR}"/ || die

	do_append_to_config(){
		varname="${1}"
		value="${2}"
		sed -i -E '$a\
			'"${varname}=${value}"'
		' "${WORKDIR}/genkernel.conf"
	einfo $(tail -n1 "${WORKDIR}/genkernel.conf")
	}

	do_mkdir_and_append_to_config(){
		varname="${1}"
		value="${2}"
		if ! [[ -e "${value}" ]] ;then
			mkdir -p "${value}" || eend 1
		fi
		do_append_to_config "${varname}" "${value}"
	}

	varname="DEFAULT_KERNEL_SOURCE"
	value="${S}"
	do_mkdir_and_append_to_config $varname $value || die

	varname="BOOTDIR"
	value="${WORKDIR}/boot"
	do_mkdir_and_append_to_config $varname $value || die

	varname="LOGFILE"
	value="${T}/genkernel.log"
	do_append_to_config $varname $value || die

	varname="SAVE_CONFIG"
	value="no"
	do_mkdir_and_append_to_config $varname $value || die
	ewarn "SAVE_CONFIG option ignored, unable to save config from sandbox."

	varname="CACHE_DIR"
	value="${WORKDIR}/cache"
	do_mkdir_and_append_to_config $varname $value || die
	ewarn "CACHE_DIR option ignored, useing new empty path."

	varname="SANDBOX"
	value="no"
	do_mkdir_and_append_to_config $varname $value || die
	ewarn "genkernel SANDBOX option ignored, portage sandbox is used if enabled."

	varname="TMPDIR"
	value="${WORKDIR}/TMPDIR"
	do_mkdir_and_append_to_config $varname $value || die
	ewarn "genkernel config option TMPDIR ignored"
	eapply_user
}

src_compile(){
	einfo "Found SANDBOX_ON=${SANDBOX_ON} in env, Sandbox of genkernel had to be disabled."
	einfo "The surrounding sandbox of the ebuild system is active if enabled and would be the reason."
	INITIAL_KERNEL_CONFIG="/etc/kernelconfig"

	kconfmsg="Remove kernel config from \"${INITIAL_KERNEL_CONFIG}\" in order "
	kconfmsg="${kconfmsg} to proceed with default automatic kernel config selection behaviour of genkernel."
	if [[ -e "${INITIAL_KERNEL_CONFIG}" ]];then
		einfo "Using initial kernel config from \"${INITIAL_KERNEL_CONFIG}\"."
		einfo "${kconfmsg}"
		genkernel --config="${WORKDIR}/genkernel.conf" --kernel-config="${INITIAL_KERNEL_CONFIG}" --no-clean bzImage   || die
		genkernel --config="${WORKDIR}/genkernel.conf" --kernel-config="${INITIAL_KERNEL_CONFIG}" --no-clean initramfs || die
	else
		einfo "Put your initial kernel config at \"${INITIAL_KERNEL_CONFIG}\"."
		einfo "${kconfmsg}"
		genkernel --config="${WORKDIR}/genkernel.conf" --no-clean bzImage   || die
		genkernel --config="${WORKDIR}/genkernel.conf" --no-clean initramfs || die
	fi
	die
}
