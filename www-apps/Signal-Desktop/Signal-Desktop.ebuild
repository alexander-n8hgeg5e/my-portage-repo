DESCRIPTION ?
Signal-Desktop
# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
inherit eutils git-r3
DESCRIPTION="Signal-Desktop"
EGIT_REPO_URI="https://github.com/WhisperSystems/Signal-Desktop.git"


src_prepare() {
npm install
node_modules/grunt-cli/bin/grunt
}

