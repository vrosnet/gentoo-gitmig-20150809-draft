# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.6.6.7.ebuild,v 1.1 2002/05/11 18:37:58 g2boojum Exp $

S=${WORKDIR}/${PN}
PV0=0.6.6
PVP=${PV0}-7
DESCRIPTION="Utility to download mail from a HotMail account"
SRC_URI="http://ftp.debian.org/debian/pool/main/g/${PN}/${PN}_${PV0}.orig.tar.gz 
		 http://ftp.debian.org/debian/pool/main/g/${PN}/${PN}_${PVP}.diff.gz"
HOMEPAGE="http://www.preikschat.com/gotmail.html"

DEPEND="net-ftp/curl
	dev-perl/URI"

src_unpack() {
	unpack ${PN}_${PV0}.orig.tar.gz
	zcat ${DISTDIR}/${PN}_${PVP}.diff.gz | patch -d ${S} -p1
}

src_compile() {
	echo "Nothing to compile"
}

src_install () {
	dobin gotmail.pl
	dodoc COPYING ChangeLog README TODO sample.gotmailrc debian.changelog
	doman debian/gotmail.1
}
