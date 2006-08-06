# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Writer/XML-Writer-0.510.ebuild,v 1.13 2006/08/06 01:57:56 mcummings Exp $

inherit perl-module

DESCRIPTION="XML Writer Perl Module"
HOMEPAGE="http://search.cpan.org/~josephw/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JO/JOSEPHW/${P}.tar.gz"
IUSE=""
LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 mips ppc64"

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
