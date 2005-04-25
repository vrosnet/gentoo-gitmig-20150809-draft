# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-FedEx-DirectConnect/Business-FedEx-DirectConnect-0.19.ebuild,v 1.2 2005/04/25 10:23:05 mcummings Exp $

inherit perl-module

DESCRIPTION="Interface to FedEx Ship Manager Direct"
SRC_URI="mirror://cpan/authors/id/J/JP/JPOWERS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JP/JPOWERS/${P}.readme"

SLOT="0"
IUSE=""
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86"

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	dev-perl/Tie-StrictHash"
