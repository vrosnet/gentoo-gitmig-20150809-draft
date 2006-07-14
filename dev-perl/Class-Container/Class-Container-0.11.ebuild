# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Container/Class-Container-0.11.ebuild,v 1.14 2006/07/14 16:41:31 mcummings Exp $

inherit perl-module

DESCRIPTION="Class-Container module for perl"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MS/MSCHWERN/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND=">=dev-perl/module-build-0.28
	>=dev-perl/Params-Validate-0.24-r1
	>=virtual/perl-Scalar-List-Utils-1.08"
RDEPEND="${DEPEND}"
