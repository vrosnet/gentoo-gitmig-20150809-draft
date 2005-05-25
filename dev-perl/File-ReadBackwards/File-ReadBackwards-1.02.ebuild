# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ReadBackwards/File-ReadBackwards-1.02.ebuild,v 1.8 2005/05/25 15:08:15 mcummings Exp $

inherit perl-module

DESCRIPTION="The Perl File-ReadBackwards Module"
SRC_URI="mirror://cpan/authors/id/U/UR/URI/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc alpha sparc ~hppa ~ppc64"
SRC_TEST="do"
DEPEND="|| ( perl-core/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
