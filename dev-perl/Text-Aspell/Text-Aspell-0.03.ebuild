# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Aspell/Text-Aspell-0.03.ebuild,v 1.3 2004/05/26 20:57:40 kloeri Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl interface to the GNU Aspell Library"
SRC_URI="http://www.cpan.org/modules/by-authors/id/H/HA/HANK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/H/HA/HANK/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~amd64 alpha ~hppa ~mips ~ppc ~sparc"

DEPEND="app-text/aspell"

