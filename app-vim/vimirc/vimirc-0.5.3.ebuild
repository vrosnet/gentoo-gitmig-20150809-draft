# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimirc/vimirc-0.5.3.ebuild,v 1.2 2004/03/16 00:36:44 dholm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: IRC Client"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=931"
LICENSE="vim"
KEYWORDS="~x86 ~sparc ~mips ~ppc"

pkg_postinst() {
	einfo " "
	einfo "This plugin requires a Vim with perl support enabled. This is"
	einfo "controlled by the 'perl' USE flag."
	einfo " "
}

