# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/pisg/pisg-0.70.ebuild,v 1.1 2006/10/22 21:28:01 swegener Exp $

inherit perl-app

DESCRIPTION="Perl IRC Statistics Generator"
HOMEPAGE="http://pisg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Text-Iconv"
DEPEND="dev-lang/perl
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	sed -i \
		-e 's!lang\.txt!/usr/share/pisg/lang.txt!' \
		-e 's!layout/!/usr/share/pisg/layout/!' \
		"${S}"/modules/Pisg.pm \
		|| die "sed failed"
}

src_install () {
	perlinfo

	dobin pisg || die "dobin failed"

	insinto "${VENDOR_LIB}"
	doins -r modules/. || die "doins failed"

	insinto /usr/share/pisg
	doins -r gfx layout lang.txt || die "doins failed"

	dodoc \
		docs/{CREDITS,Changelog,FORMATS,pisg-doc.txt} \
		docs/dev/API pisg.cfg README || die "dodoc failed"
	doman docs/pisg.1 || die "doman failed"
	dohtml docs/pisg-doc.html || die "dohtml failed"
}

pkg_postinst() {
	einfo
	einfo "The pisg images have been installed in /usr/share/pisg/gfx"
	einfo
}
