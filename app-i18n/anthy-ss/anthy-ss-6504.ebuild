# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy-ss/anthy-ss-6504.ebuild,v 1.2 2005/05/14 08:20:35 blubb Exp $

inherit elisp-common eutils

IUSE="emacs ucs4"

MY_P="${P/-ss/}"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/14562/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="emacs? ( virtual/emacs )
	!app-i18n/anthy"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-mkdic-gcc34.diff

}

src_compile() {

	local myconf
	local cannadicdir=/var/lib/canna/dic/canna

	use emacs || myconf="EMACS=no"
	use ucs4 && myconf="${myconf} --enable-ucs4"

	if has_version 'app-dicts/canna-zipcode'; then
		einfo "Adding zipcode.t and jigyosyo.t to anthy.dic."
		cp ${cannadicdir}/{zipcode,jigyosyo}.t mkanthydic
		sed -i -e "/^EXTRA_DICS/s|$| zipcode.t jigyosyo.t|" mkanthydic/Makefile.in
	fi

	if has_version 'app-dicts/canna-2ch'; then
		einfo "Adding nichan.ctd to anthy.dic."
		cp ${cannadicdir}/nichan.ctd mkanthydic/2ch.t
		sed -i -e "/^EXTRA_DICS/s|$| 2ch.t|" mkanthydic/Makefile.in
	fi

	econf ${myconf} || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	use emacs && elisp-site-file-install ${FILESDIR}/50anthy-gentoo.el

	rm doc/Makefile*

	dodoc AUTHORS COPYING DIARY INSTALL NEWS README ChangeLog
	dodoc doc/*

}

pkg_postinst() {

	use emacs && elisp-site-regen

}

pkg_postrm() {

	has_version virtual/emacs && elisp-site-regen

}
