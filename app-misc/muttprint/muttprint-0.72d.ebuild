# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/muttprint/muttprint-0.72d.ebuild,v 1.5 2005/09/02 19:23:55 hansmi Exp $

inherit eutils

DESCRIPTION="Script for pretty printing of your mails"
HOMEPAGE="http://muttprint.sf.net/"
SRC_URI="mirror://sourceforge/muttprint/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ia64 ppc ~ppc64 x86"
IUSE=""

RDEPEND="virtual/tetex
	dev-lang/perl
	dev-perl/TimeDate
	dev-perl/Text-Iconv
	dev-perl/File-Which
	app-text/psutils"

src_unpack() {
	unpack ${A} && cd ${S} || die
	epatch ${FILESDIR}/${PN}-rem_sig.patch
}

src_install() {
	make prefix=${D}/usr docdir=${D}/usr/share/doc docdirname=${P} install
}
