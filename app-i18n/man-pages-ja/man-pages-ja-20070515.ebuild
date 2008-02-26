# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-ja/man-pages-ja-20070515.ebuild,v 1.3 2008/02/26 18:35:21 armin76 Exp $

IUSE=""

GENTOO_MAN_P="portage-${PN}-20060415"

DESCRIPTION="A collection of manual pages translated into Japanese"
HOMEPAGE="http://www.linux.or.jp/JM/ http://www.gentoo.gr.jp/jpmain/translation.xml"
SRC_URI="http://www.linux.or.jp/JM/${P}.tar.gz
	http://dev.gentoo.org/~hattya/distfiles/${GENTOO_MAN_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
SLOT="0"

RDEPEND="virtual/man"

src_compile() {

	sed -i -e "/^\(man\|shadow\)/s:Y:N:" script/pkgs.list || die

	# remove man pages that are provided by other packages.
	# - sys-apps/shadow +nls
	rm -f manual/*/man1/{chfn,chsh,newgrp,su,passwd,groups}.1
	rm -f manual/*/man8/{vigr,vipw}.8

}

src_install() {

	local x y z pkg

	for x in $(tac script/pkgs.list | grep -v '^[#].*'); do
		if [[ -z "$pkg" ]]; then
			pkg=$x
			continue
		fi

		if [[ "$x" == "N" ]]; then
			pkg=
			continue
		fi

		einfo "install $pkg"

		for y in $(ls -d manual/$pkg/man* 2>/dev/null); do
			doman -i18n=ja $y/*
		done

		pkg=
	done

	dodoc ChangeLog README

	cd "${WORKDIR}"/${GENTOO_MAN_P}

	for x in *; do
		if [ -d "$x" ]; then
			einfo "install $x"

			for z in $(for y in $x/*.[1-9]; do echo ${y##*.}; done | sort | uniq); do
				doman -i18n=ja $x/*.$z
			done
		fi
	done

	newdoc ChangeLog ChangeLog.GentooJP

}

pkg_postinst() {

	echo
	elog "You need to set appropriate LANG variables to use"
	elog "Japanese manpages."
	elog "e.g."
	elog "\tLANG=\"ja_JP.eucJP\""
	elog "\texport LANG"
	echo

}
