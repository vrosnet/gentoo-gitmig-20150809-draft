# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Find/Email-Find-0.09.ebuild,v 1.1 2004/06/06 03:20:32 mcummings Exp $

inherit perl-module

DESCRIPTION="Find RFC 822 email addresses in plain text"
HOMEPAGE="http://search.cpan.org/~miyagawa/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/MI/MIYAGAWA/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha  ~amd64"

SRC_TEST="do"

DEPEND="dev-perl/MailTools
	dev-perl/Email-Valid
	dev-perl/Test-Simple"
