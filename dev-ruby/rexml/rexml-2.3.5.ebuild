# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rexml/rexml-2.3.5.ebuild,v 1.3 2002/07/11 06:30:24 drobbins Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Ruby Electric XML"
SRC_URI="http://www.germane-software.com/~ser/Software/archives/${PN}_${PV}.tgz"
HOMEPAGE="http://www.germane-software.com/~ser/Software/rexml/"
DEPEND=">=dev-lang/ruby-1.6.0"
LICENSE="Ruby"
KEYWORDS="x86"
SLOT="0"

src_unpack () {
	unpack ${A}
	cd ${S}/bin
	patch < ${FILESDIR}/${P}-gentoo.diff || die
}

src_install () {
	PORTAGETMP=${D} ruby bin/install.rb
}
