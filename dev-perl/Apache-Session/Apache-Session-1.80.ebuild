# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.80.ebuild,v 1.11 2007/01/14 22:11:00 mcummings Exp $

inherit perl-module
IUSE=""

DESCRIPTION="Perl module for Apache::Session"
SRC_URI="mirror://cpan/authors/id/C/CW/CWEST/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~cwest/Apache-Session-1.80/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

DEPEND="virtual/perl-Digest-MD5
	virtual/perl-Storable
	dev-lang/perl"
