# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-dsa/crypt-dsa-0.13.ebuild,v 1.1 2005/11/12 15:59:54 mcummings Exp $

inherit perl-module

MY_P=Crypt-DSA-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="DSA Signatures and Key Generation"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/data-buffer
	dev-perl/math-pari
	dev-perl/crypt-random
	dev-perl/Digest-SHA1
	dev-perl/convert-pem"
