# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Raw-Zlib/Compress-Raw-Zlib-2.004.ebuild,v 1.8 2007/05/24 14:29:38 flameeyes Exp $

inherit perl-module

DESCRIPTION="Low-Level Interface to zlib compression library"
HOMEPAGE="http://search.cpan.org/~pmqs"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 m68k mips ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
