# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8,9,10} )
inherit git-r3 python-r1 scons-utils toolchain-funcs
DESCRIPTION="shortcuts"
HOMEPAGE=""
EGIT_REPO_URI="${CODEDIR}/${PN} https://github.com/alexander-n8hgeg5e/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS="~*"
IUSE="rind neovim github pyopen X"

RDEPEND="dev-python/pexpect[${PYTHON_USEDEP}]
			dev-python/pylib[${PYTHON_USEDEP}]
			>=dev-python/columnize-0.3.9[${PYTHON_USEDEP}]
			rind? ( app-misc/rind )
			neovim?	(   app-editors/neovim
			app-misc/tmux
					)
			github? ( dev-python/github3[${PYTHON_USEDEP}] )
			pyopen? ( app-misc/pyopen )
			X?	(	x11-apps/xset
					x11-misc/wmctrl
					dev-python/psutil[${PYTHON_USEDEP}]
				)
			dev-python/deprecation[${PYTHON_USEDEP}]
		"

BDEPEND="dev-util/scons[${PYTHON_USEDEP}]"

#src_configure(){
#	true;
#}

src_compile(){
	python_setup
	if use X;then
    	escons menu
	fi
	escons skyscraper_activate_monitor_onoff_button
}


src_install(){
dobin c
dobin convert_all_mp4_2_aac
dobin disk_smart_report
dobin dotf
python_foreach_impl python_doscript e
python_foreach_impl python_doscript edit_nvim_win_back
python_foreach_impl python_doscript edit_nvim_tag_browser
python_foreach_impl python_doscript elp
python_foreach_impl python_doscript elpau
python_foreach_impl python_doscript elpau!
python_foreach_impl python_doscript elpau!!
dobin extra_disk_einbinden
dobin g
dobin g.c
dobin ga
dobin gi
dobin git_commit_nvim
python_foreach_impl python_doscript github_create_repo
python_foreach_impl python_doscript gl
dobin goo
dobin gpc
dobin guc
dobin img_comp_all_here
dobin keyblayout_set
dobin m
python_foreach_impl python_doscript mail_attach_mutt_nvim
dobin mailstart
python_foreach_impl python_doscript manif
dobin maup
dobin mount-notmuchfs
dobin mutt-notmuch
dobin np
dobin nvim_commit_git_history
dobin nvim_git_history
dobin obexit
dobin p1
dobin pwfind
dobin rg
dobin rg
dobin rg.c
dobin rga
dobin rga
dobin rgi
dobin rgl
dobin rgpc
dobin rguc
#dobin rsync_handy2_dcimdir_fast
#dobin rsync_handy_dcimdir_fast
dobin sd
dobin speech-wrapper
dobin gi
python_foreach_impl python_doscript github_create_repo
dobin nvim_commit_git_history
dobin nvim_git_history
dobin c
python_foreach_impl python_doscript gl
python_foreach_impl python_doscript print_foldable
dobin sus
python_foreach_impl python_doscript u
dobin umount-notmuchfs
dobin de_st_nvim
dobin st_nvim
dobin t
doman mutt-notmuch.1
dobin list_firewall
dobin setup_x
dobin gu
dobin g.
dobin ga
dobin ga
dobin g.
dobin gu
dobin rga
dobin rg.
dobin rgu
dobin rgit
dobin rg
dobin rg.
dobin rg.c
dobin rga
dobin rgi
dobin rgit
dobin rgl
dobin rgpc
dobin rgu
dobin rguc
dobin rgc
dobin gic      # file collison , should be gc
dosym rgc /usr/bin/rgic    # alias
dosym sgc /usr/bin/sgic    # alias
dobin sgc
dobin sg.
dobin sg.c
dobin sga
dobin sgc
dobin sgit
dobin sgits # sg collision
dobin sgl
dobin sgpc
dobin sgu
dobin sguc
dobin sgi
dobin cg
dobin cg.
dobin cg.c
dobin cga
dobin cgc
dobin cgi
dobin cgit
dobin cgl
dobin cgpc
dobin cgu
dobin cguc
python_foreach_impl python_doscript r
python_foreach_impl python_doscript set_nvim_var
python_foreach_impl python_doscript rub
python_foreach_impl python_doscript nvim_call
python_foreach_impl python_doscript nvim_command
insinto /usr/share/applications
doins w3m.desktop
python_foreach_impl python_doscript br
python_foreach_impl python_doscript bh
dobin l0
dobin l1
dobin ic
dobin st_de_nvim
dobin tv
dobin tmux_nvim_session
dobin tmux_nvim_new_session
dobin mknewappuser
dobin saau
python_foreach_impl python_doscript ba
python_foreach_impl python_doscript ne
dobin dg
dobin haw
dobin preloadwins
dobin i
dobin compile_in_kernel_loaded_modules
dobin realtime
python_foreach_impl python_doscript nvim_open_browsertab
dobin synergy_tmrl_esadc_client
dobin synergy_tmrl_esadc_server
dobin tmux_nvim_update_nvim_listen_addr
dobin tmrl_blo
dobin rh
dobin rl
dobin xc
dobin tmrlfs
dobin sed_inplace_insert_between_lines
dobin sed_inplace_insert_dobin_into_ebuild
dobin rallnodes
dobin check_synergy_ssh_connection
dobin _check_synergy_ssh_connection
if use X ; then
	dobin menu/r_menuwin
	dobin menu/l_menuwin
	dobin menu/menuwin
	dobin menu/menu_run
	python_foreach_impl python_doscript menu/menu_search
fi
dobin qb
dobin ginf
dobin pcfs
dobin gip
python_foreach_impl python_doscript gb
dobin set_portage_access_to_code
dobin unabsorb_git_dirs
dobin random_seq
dobin get_free_nodes
dobin check_node
python_foreach_impl python_doscript check_nodes
dobin get_nodes_load
dobin get_node_load
dobin list_my_procs_on_nodes
dobin list_proc_on_node_by_pid
dobin list_my_procs_on_node
dobin list_my_procs_on_nodes_sorted
dobin get_submodule_path_list
dobin wget_em
dobin snap
dobin gbrd
dobin gbr
dobin gprh
dobin gcb
dobin get_dotf_gitdirs
dobin get_root_gitdirs
dobin get_home_gitdirs
python_foreach_impl python_doscript pp
dobin gh
dobin ds
dobin gsu
dobin gsd
dobin guno
dobin kernel_update
python_foreach_impl python_doscript github
dobin gsbrd
dobin gisfor
dobin gcb
dobin gbs
dobin gsuf
dobin "gsu!"
dobin gscb
dobin checkout_failed
dobin conky_all
dobin parse_xrandr_conf
python_foreach_impl python_doscript setup_xrandr
dobin set_max_cpu_f
dobin maups
dobin gsb
dobin gsc
dobin git_change_commit_date
dobin datef
dobin git_del_all_worktree_conf
dobin ghb
python_foreach_impl python_doscript elpauc!
python_foreach_impl python_doscript elpauc
python_foreach_impl python_doscript elpauc!!
dobin gcmb
dobin gbrod
dobin gbro
dobin git_update_process
dobin get_latest_portage_build_logs
dobin write_latest_portage_build_logs_to_shm
python_foreach_impl python_doscript sc
dobin xauth_push
dobin ovpn
dobin invert_and_darken_screen
dobin darken_screen
dobin blink
dobin dedupe
dobin dotf_gsu
dobin .g
dobin .g.
dobin .g.c
dobin .ga
dobin .gb
dobin .gbr
dobin .gbrd
dobin .gbro
dobin .gbrod
dobin .gbs
dobin .gcb
dobin .gcmb
dobin .gh
dobin .ghb
dobin .gi
dobin .gic
dobin .gl
dobin .gpc
dobin .gprh
dobin .grt
dobin .gsb
dobin .gsbrd
dobin .gsc
dobin .gscb
dobin .gsd
dobin .gsu
dobin .gsuf
dobin .gu
dobin .guc
dobin .guno
dobin .gd
dobin .gdc
dobin grt
dobin gd
dobin gdc
dobin erc
dobin uerc
dobin uerc!
dobin uerc!!
dobin xauth_pull
python_foreach_impl python_doscript xis
dobin tmrlso
dobin youtube
dobin xi
dobin gg
dobin sed_comment_exclude_git
dobin prepare_nvim_git_history
dobin n
dobin screen_on_control_1
dobin screen_on_control
dobin colorfade
python_foreach_impl python_doscript mm
dobin .gdcs
dobin .gds
dobin gds
dobin gdcs
python_foreach_impl python_doscript gidb
dobin mirrorlink
dobin homelink
dobin run_env_eprefix_shebang
python_foreach_impl python_doscript timewatch
dobin old
python_foreach_impl python_doscript feedkeys_screen
python_foreach_impl python_doscript wm_conf_adj
python_foreach_impl python_doscript add_modelines
python_foreach_impl python_doscript pav
python_foreach_impl python_doscript k
python_foreach_impl python_doscript pyprep
dobin webserv
dobin tt
python_foreach_impl python_doscript I
dosym gur /usr/bin/git-unpack-refs    # alias
dobin git-unpack-refs
dobin gco
python_foreach_impl python_doscript synergy_skyscraper
python_foreach_impl python_doscript pw
dobin lf
python_foreach_impl python_doscript pf
dobin iit
dobin iit2
dobin iit3
dobin iit4
dobin it
dobin it1
dobin it2
dobin it3
dobin it4
python_foreach_impl python_doscript py
dobin cl
python_foreach_impl python_doscript p2c
python_foreach_impl python_doscript pw2handy
python_foreach_impl python_doscript G
python_foreach_impl python_doscript group_access
dobin check_git
dobin pip3_source_download
python_foreach_impl python_doscript wl
python_foreach_impl python_doscript dms
dobin stripcolors
dobin gl1
python_foreach_impl python_doscript cmdowner
dobin iptables_log_rejected
dobin w3mimgdisplay
python_foreach_impl python_doscript ssnd
python_foreach_impl python_doscript stnd
python_foreach_impl python_doscript srnd
python_foreach_impl python_doscript bn
python_foreach_impl python_doscript msky
dobin skyscraper_activate_monitor_onoff_button
python_foreach_impl python_doscript monitor_samsung_control
dobin mec
dobin git_reverse_graph_color
python_foreach_impl python_doscript fgd
python_foreach_impl python_doscript ff
python_foreach_impl python_doscript datesort
python_foreach_impl python_doscript snap2
python_foreach_impl python_doscript check_userids_groupids
dobin eixv
python_foreach_impl python_doscript fname_clean
dobin defrag
dobin eixc
python_foreach_impl python_doscript get_room_temp
python_foreach_impl python_doscript get_outside_temp
python_foreach_impl python_doscript mti
dobin gitpack_remote_up2date_check
dobin ssh-akl
python_foreach_impl python_doscript logfilter_old
dobin tox
dobin mecl
python_foreach_impl python_doscript xi2
python_foreach_impl python_doscript gr
python_foreach_impl python_doscript statm
python_foreach_impl python_doscript find-git-objects
dobin df-GMK
dobin n2s
dobin sed_align4
python_foreach_impl python_doscript diskstats
dobin stop_keyev_mouseev
dobin b
dobin random_file_read
dobin show_cg_io_latency_stats
dobin ch
dobin ct
python_foreach_impl python_doscript set_cpu_governor
python_foreach_impl python_doscript pyxd
python_foreach_impl python_doscript git-unpack-packs
python_foreach_impl python_doscript git-fetch-objects
dobin show_dirtytime
python_foreach_impl python_doscript random-update
dobin f0
python_foreach_impl python_doscript check_pkg_hashes
dobin get_fetch_failed_list
python_foreach_impl python_doscript get_scans
dobin dmo
dobin list_service_scripts_in_use
python_foreach_impl python_doscript sf
python_foreach_impl python_doscript radios
dobin git-rm-unverifiable-refs
python_foreach_impl python_doscript grr
dobin grsp
dobin gds1
dobin gd1
dobin get_mounted_nfs
dobin umount_node
dobin get_mounted_nfs
dobin git_clone_github-code-pack
dobin vv
dobin vs
python_foreach_impl python_doscript feedpts
dobin pager
dobin ordsortuniq
dobin m10
dobin m11
python_foreach_impl python_doscript git_find_min_diff
dobin mountpp
dobin push_missing_distfiles
dobin show_python_not_in_ebuild
python_foreach_impl python_doscript pdf_mass_zoom_prepare
python_foreach_impl python_doscript py_io_control
python_foreach_impl python_doscript ran
python_foreach_impl python_doscript serve_http
python_foreach_impl python_doscript set-dark_kicad
python_foreach_impl python_doscript sharg
python_foreach_impl python_doscript fetch_failed
dobin alarm
dobin check_nodes_old
dobin cuc
dobin cz
dobin dn
dobin forward_clipster_socket
dobin forward_nvim_socket
dobin gen_fish_completions
dobin get_sub_git_dirs
dobin glsi_git_ls_index
dobin go_mirror
dobin go_prefix
dobin gsu!
dobin http-serv
dobin iit1
dobin iit1n
dobin iit2n
dobin iit3n
dobin iit4n
dobin iitn
dobin it1n
dobin it2n
dobin it3n
dobin it4n
dobin itn
dobin klima_off
dobin list_elf_with_dynlibs
dobin m1t
dobin m20
dobin m21
dobin portage_repo_git_fix
dobin power_dusteater_off
dobin power_dusteater_on
dobin rambuffer
dobin read_clipboard
dobin sed_inplace_insert_python_script_into_ebuild
dobin set-dark_gtk3
dobin set-light_gtk3
dobin sgits
dobin show_shell_script_not_in_ebuild
dobin smc
dobin ud
dobin uercd
dobin uercd!
dobin uercd!!
dobin unabsorb_git_dirs_only_cleanup
dobin emerge-node
dobin x2myclip
dobin x20
dobin x21
dobin txt2pdf
dobin power_ac_off
dobin power_ac_on
dobin power_audio_off
dobin power_audio_on
dobin power_esadc_off
dobin power_esadc_on
dobin power_fan_off
dobin power_fan_on
dobin power_klima_off
dobin power_klima_on
dobin power_led-stripe_off
dobin power_led-stripe_on
dobin power_light0_off
dobin power_light0_on
dobin power_light1_off
dobin power_light1_on
dobin luksFormat
dobin qr
dobin qrd
dobin sX
dobin watch_node_top
dobin shs
dobin get_nodes_relative_loadavg
dobin ceph_daemons
dobin show_cluster_top_all-r
dobin diff_cpu_flags
dobin urlscan_0
dobin useradd_push
dobin show_cg_io_latency_targets
}
