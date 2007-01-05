# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/xvnkb/xvnkb-0.2.9.ebuild,v 1.4 2007/01/05 16:37:57 flameeyes Exp $

inherit eutils

IUSE="truetype spell"

DESCRIPTION="Vietnamese input keyboard for X"
SRC_URI="http://xvnkb.sourceforge.net/${P}.tar.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
RDEPEND="|| ( ( x11-libs/libX11
				truetype? ( virtual/xft )
				)
			virtual/x11 )"
DEPEND="${RDEPEND} || ( ( x11-proto/xproto ) virtual/x11 )"

src_compile() {
	local myconf

	use spell || myconf="${myconf} --no-spellcheck"
	use truetype || myconf="${myconf} --no-xft"

	# *not* autotools
	./configure \
		--use-extstroke ${myconf} \
		|| die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	dobin xvnkb
	dobin tools/xvnkb_ctrl

	dolib xvnkb.so.${PV}
	dosym /usr/lib/xvnkb.so.${PV} /usr/lib/xvnkb.so

	dodoc LICENSE ChangeLog AUTHORS THANKS TODO INSTALL* README* doc/*
	docinto scripts
	dodoc scripts/*
	docinto contrib
	dodoc contrib/*
}

pkg_postinst() {
	elog "Remember to"
	elog "$ export LANG=en_US.UTF-8"
	elog "(or any other UTF-8 locale) and"
	elog "$ export LD_PRELOAD=${DESTTREE}/lib/xvnkb.so"
	elog "before starting X Window"
	elog "More documents are in /usr/share/doc/${PF}"
	ewarn "Programs with suid/sgid will have LD_PRELOAD cleared"
	ewarn "You have to unset suid/sgid to use with xvnkb"
}
