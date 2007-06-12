# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-SmallProf/Devel-SmallProf-2.02.ebuild,v 1.1 2007/06/12 18:37:07 mcummings Exp $

inherit perl-module

DESCRIPTION="per-line Perl profiler"
HOMEPAGE="http://search.cpan.org/~salva/"
SRC_URI="mirror://cpan/authors/id/S/SA/SALVA/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
