# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Compare/Data-Compare-0.11.ebuild,v 1.5 2005/03/08 18:20:07 mcummings Exp $

inherit perl-module

DESCRIPTION="compare perl data structures"
HOMEPAGE="http://search.cpan.org/~dcantrell/${P}/"
SRC_URI="http://www.cpan.org/authors/id/D/DC/DCANTRELL/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/File-Find-Rule
		dev-perl/Scalar-Properties"
