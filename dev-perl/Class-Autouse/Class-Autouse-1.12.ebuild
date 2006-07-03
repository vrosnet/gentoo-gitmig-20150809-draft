# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Autouse/Class-Autouse-1.12.ebuild,v 1.12 2006/07/03 21:03:13 ian Exp $

inherit perl-module
DESCRIPTION="Runtime aspect loading of one or more classes"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Class/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha ppc sparc"
DEPEND="virtual/perl-Test-Simple
		dev-perl/ExtUtils-AutoInstall
		dev-perl/module-build
		virtual/perl-Scalar-List-Utils"
RDEPEND="${DEPEND}"

SRC_TEST="do"