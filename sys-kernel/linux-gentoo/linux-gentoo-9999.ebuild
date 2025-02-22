# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="Linux kernel installation ebuild.
	Read the ebuild! I't contains further important description."

#	Experimental ebuild that may destroy the computer.
#	Version 999935 installs the version
#	the symlink \"${EROOT}/usr/linux\" points at.
#	Version 9999 pulls in sys-kernel/gentoo-sources-9999 as dependency.
#	Otherwise the version pulls in the corresponding gentoo-sources
#	as dependency.
#	Except of the first case,(\"999935\")
#	a use flag \"set-kernel-source-link\"
#	is evaluated and if the flag is set
#	the symlink \"${EROOT}/usr/src/linux is
#	adjusted to point at the installed kernel-sources.
#	The kernel config is obtained via git from a git-repository in
#	\"/usr/src/kernel_config.git\"
#	The currently checked out branch is used.
#	Uncommited changes are not used.
#	Then \"make olddefconfig\" is run to set new values to the default.
#	If not already existing, a symlink at \"${EROOT}/usr/src/linux/.git\"
#	is created that points at \"${EROOT}/usr/src/kernel_config.git\"
#	The group and permissions oft the kernel_config.git dir
#	and the kernel source tree
#	is changed to portage and group read-access if
#	the use-flag \"set-perms\" is set.


if [[ ${PV} == 999935 ]]; then
	# eselect your version
	# no need to set the kernel source tree link
	BDEPEND="virtual/linux-sources"
	IUSE=""
else
	IUSE="-set-kernel-source-link"
	BDEPEND="	=sys-kernel/gentoo-sources-${PV} \
				sys-apps/grep \
				sys-apps/sed \
			"
fi

HOMEPAGE=""
EGIT_REPO_URI="${EROOT}/usr/src/kernel_config.git"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="${IUSE} -test -set-perms kernel-inst-method-copy2boot kernel-inst-method-mkinstall\
	kernel_install_method-sbin-instkern +backup mount-boot"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="	dev-vcs/git
			virtual/linux-sources
			app-misc/shortcuts
			>net-misc/rsync-3
		"
RESTRICT="distcc"

pkg_setup(){
	if [[ ${PV} = 999935 ]]; then
		# use the existing symlink to get the kernel source tree
		# or whatever the user is keeping at that path
		kernel_source_tree="${EROOT}/usr/src/linux"
		[[ -e "${kernel_source_tree}" ]] \
			|| die \
			"No kernel source at: \"${kernel_source_tree}\"
			Version 999935 needs kernel sources there.
			Choose another version or set a symlink to the kernel sources there."

		[[ -h "${kernel_source_tree}" ]] \
			|| ewarn \
			"No symlink at \"${kernel_source_tree}\"
			This could be unintended.
			Installation is proceeding and expecting the kernel sources for compilation there"
	else
		# can not use the kernel source symlink
		# to get the source tree do some pkg data base check
		symlink_target="$(cat "${EPREFIX}"/var/db/pkg/sys-kernel/gentoo-sources-"${PV}"/CONTENTS \
			| grep -E '^dir[ ]+[/]usr[/]src[/]linux[-][^/]+$' \
			| sed -E 's@^dir[ ]+${EROOT}/usr/src/(linux[-][^/]+$)@\1@')" \
				|| die "could not infer kernel source tree from pkg database"
		kernel_source_tree="${EROOT}/usr/src/${symlink_target}"
		[[ -e "${kernel_source_tree}" ]] || die \
			"Kernel source tree should be at: \"${kernel_source_tree}\", but there is nothing.
			Something went wrong.
			The dependencies of this ebuild should have installed a kernel source at this place.
			Here the Build-time dependencies:
			${BDEPEND}"
	fi


	einfo "useing kernel: ${kernel_source_tree}"

	if use set-perms ; then
		find "${EGIT_REPO_URI}/" \! -group portage -exec chown :portage "{}" \;
		find "${EGIT_REPO_URI}/" \! -type f -perm \g=r -exec chmod g=r "{}" \;
		find "${EGIT_REPO_URI}/" \! -type d -perm \g=rx -exec chmod g=rx "{}" \;

		find "${kernel_source_tree}" \! -group portage -exec chown :portage "{}" \;
		find "${kernel_source_tree}" \! -type f -perm \g=r -exec chmod g=r "{}" \;
		find "${kernel_source_tree}" \! -type d -perm \g=rx -exec chmod g=rx "{}" \;
	fi

	# check for read-access
	# find exits 1 if something unreadable is found
	# no matter the "!" prefix
	find "${EROOT}/usr/src/linux/" ! -readable || die

	# choose the kernel installation method
	# this need to fit the system
	if use kernel-inst-method-copy2boot;then
		kernel_install_method="copy2boot"
		einfo "Kernel install method copy2boot choosen."
		einfo "This method mounts the boot partition,copies the bzImage and some stuff there
			and links it from vmlinuz. This is a incomplete description."

	elif use kernel-inst-method-mkinstall;then
		kernel_install_method="mkinstall"
		einfo "Kernel install method mkinstall choosen."
		einfo "This method runs \"make install\" from the kernel source tree."

	elif use kernel_install_method-sbin-instkern;then
		kernel_install_method="sbin-instkern"
		einfo "Kernel install method sbin-instkern choosen."
		einfo "This method runs /sbin/installkernel with the usual parameters."

	else
		die "This ebuild requires to choose a kernel install method via use flag."
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
			if
				[[ -e /etc/kernel-update-backup-cmd ]];then
				backupmethod=cmd
			else
				backupmethod=tar
			fi
		fi
		einfo "backupmethod: ${backupmethod}"
	else
		ewarn "no kernel backup will be made, set backup use flag to enable backups"
	fi
}

src_unpack(){
    EGIT_MIRROR_URI=""
	git-r3_src_unpack || die
	einfo "preparing build dir..."
	rsync --info=none,progress2 -ac --delete --partial \
		--progress --exclude='/.git' \
		--exclude='/.git/***' \
		--exclude='/.config' \
		"${EROOT}/usr/src/linux/" "${S}" \
			|| die "ERROR: rsync failed"
}

src_configure(){
	unset ARCH
	if use test; then
		einfo "checking for readable source dir..."
		find "${S}" ! -readable || die
	fi
	emake olddefconfig || die
}

src_install(){
	if use kernel-inst-method-copy2boot ; then
		export INSTALL_PATH="${ED}boot"
		export INSTALL_MOD_PATH="${ED}"
		nonfatal emake modules_install || ewarn no modules or some error

		kernelrelease="$(make -s kernelrelease)" || die
		image_path="$(make -s image_name)" || die
		image_name="$(basename ${image_path})" || die

		dodir   /boot || die
		insinto /boot || die

		insopts "-m440"
		newins "${S}/System.map"     "System.map-${kernelrelease}" || die
		insopts "-m550"
		newins "${S}/${image_path}"  "${image_name}-${kernelrelease}" || die
		insopts "-m440"
		newins "${S}/.config"        "config-${kernelrelease}" || die

		dosym "System.map-${kernelrelease}" /boot/System.map || die
		dosym "${image_name}-${kernelrelease}" /boot/vmlinuz || die

		group_id=$(stat /boot --printf "%g") || die "error: could not stat /boot"
		fperms ug=rx,o=        "/boot/${image_name}-${kernelrelease}" || die
		fowners ":${group_id}"  "/boot/${image_name}-${kernelrelease}" || die
		fperms ug=r,o=         "/boot/System.map-${kernelrelease}"
		fowners ":${group_id}"  "/boot/System.map-${kernelrelease}"
		fperms ug=rx,o=        "/boot/config-${kernelrelease}"
		fowners ":${group_id}"  "/boot/config-${kernelrelease}"
	else
		die \
			"Sorry, only install method copy2boot is currently implemented.
			FIXME"
	fi

	if [[ ${PV} != 999935 ]] && use set-kernel-source-link;then
		symlink_target="$(cat "${EPREFIX}"/var/db/pkg/sys-kernel/gentoo-sources-"${PV}"/CONTENTS \
			| grep -E '^dir[ ]+[/]usr[/]src[/]linux[-][^/]+$' \
			| sed -E 's@^dir[ ]+${EROOT}/usr/src/(linux[-][^/]+$)@\1@')" \
				|| die "could not infer symlink target tree from pkg database"

		symlink_path="${EPREFIX}/usr/src/linux"

		einfo "installing kernel source link at \"${symlink_path}\",  pointing at: \"${symlink_target}\""
		dosym "${symlink_target}" "${symlink_path}" || die

		einfo "installing kernel git symlink"
		dosym "/usr/src/kernel_config.git" "${symlink_path}/.git" || die
	fi
}

pkg_preinst(){
	# mount the boot partition
	use mount-boot && mount /boot && mounted_boot=1 || mounted_boot=0

	if use backup; then

		# alright, doing backup

		if [[ $backupmethod = btrfs ]];then
			btrfs sub snap -r "/boot/." "/boot/snapshots/$(date +%y_%m_%d_%H_%M_%S)" \
				|| die
		elif [[ $backupmethod = cmd ]];then
			/etc/kernel-update-backup-cmd || die
		elif [[ $backupmethod = tar ]] ; then
			inc_tarfilepath="/boot/kernel_backup.tar.inc"
			tarfilepath="/boot/kernel_backup.tar"
			if [[ $(find /boot -regextype 'posix-extended' -regex '.*[/][.](cvs|git|bzr|hg)ignore'|wc -l) -gt 0 ]] ;then
				einfo "excluding \"vcs-ignores\" from backup (tar option)"
			fi
			if [[ $(find /boot -path /boot/snapshots|wc -l) -gt 0 ]] ;then
				einfo "excluding /boot/snapshots from backup"
			fi
    		tar -cf "${tarfilepath}" -g "${inc_tarfilepath}" \
				--exclude-vcs-ignores \
				--exclude '*backup*' \
				--exclude 'snapshots' \
				/boot || die "failed to do backup"
		else
			die "No backupmethod could be infered."
		fi

	elif use backup;then
		die \
			"To enable backupmethods, read the code and check if it will do what you want."
	else
		ewarn "Warning: No kernel backup will be made."
	fi
}

pkg_config(){
	[[ $mounted_boot -eq 1 ]] && umount /boot
}
