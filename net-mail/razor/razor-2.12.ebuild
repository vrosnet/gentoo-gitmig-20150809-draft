# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/razor/razor-2.12.ebuild,v 1.4 2002/10/04 06:09:28 vapier Exp $

inherit perl-module

S="${WORKDIR}/razor-agents-${PV}"

DESCRIPTION="Vipul's Razor is a distributed, collaborative spam detection and filtering network"
HOMEPAGE="http://razor.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/razor/razor-agents-${PV}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND="sys-devel/perl
	dev-perl/Net-DNS
	dev-perl/Time-HiRes
	dev-perl/Digest-SHA1
	dev-perl/URI
	dev-perl/Digest-Nilsimsa"
