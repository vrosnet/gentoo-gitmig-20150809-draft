# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Tester/Test-Tester-0.103.ebuild,v 1.2 2006/07/16 08:59:26 dertobi123 Exp $

inherit perl-module
IUSE=""

DESCRIPTION="Perl module for Apache::Session"
SRC_URI="mirror://cpan/authors/id/F/FD/FDALY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~fdaly/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

SRC_TEST="do"
