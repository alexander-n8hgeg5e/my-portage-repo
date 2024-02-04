# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION=""
ACCT_USER_ID=47836
ACCT_USER_GROUPS=( wayland vglusers video )

acct-user_add_deps

