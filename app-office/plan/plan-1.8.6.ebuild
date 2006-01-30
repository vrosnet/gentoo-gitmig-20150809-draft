# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/plan/plan-1.8.6.ebuild,v 1.9 2006/01/30 19:02:22 blubb Exp $

inherit eutils

DESCRIPTION="Motif based schedule planner"
HOMEPAGE="http://www.bitrot.de/plan.html"
SRC_URI="ftp://plan.ftp.fu-berlin.de/${P}.tar.gz
		 mirror://gentoo/${P}-gentoo.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 sparc"
IUSE=""

DEPEND="virtual/x11
	x11-libs/openmotif"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${P}-errno.patch
	epatch ${WORKDIR}/${P}-gentoo.patch
	epatch ${WORKDIR}/${P}-webplan.patch
}

src_compile() {
	make linux || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	keepdir /usr/share/plan/netplan.dir

	cd ${S}/..
	dodoc HISTORY README || die "dodoc failed"

	cd ${S}/../misc
	doman netplan.1 plan.1 plan.4 || die "doman failed"

	insinto /usr/share/${PN}/misc
	doins netplan.boot BlackWhite Monochrome plan.fti Plan.xpm plan.xpm \
		|| die "misc files install failed"
	exeinto /usr/share/${PN}/misc
	doexe Killpland cvs vsc msschedule2plan plan2vcs || die "misc files install failed"

	cd ${S}/../web
	insinto /usr/share/${PN}/web
	doins help.html bottom.html cgi-lib.pl common.pl holiday_webplan rtsban.jpg \
		|| die "webplan install failed"
	exeinto /usr/share/${PN}/web
	doexe *.cgi || die "webplan install failed"
}

pkg_postinst() {
	einfo
	einfo " Check /usr/share/${PN}/holiday for examples to set your"
	einfo " ~/.holiday according to your country."
	einfo
	einfo " WebPlan 1.8 can be found in /usr/share/${PN}/web."
	einfo
}
