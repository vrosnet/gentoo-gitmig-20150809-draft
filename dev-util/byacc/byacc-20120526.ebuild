# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/byacc/byacc-20120526.ebuild,v 1.1 2012/05/30 06:16:49 radhermit Exp $

EAPI=4

DESCRIPTION="the best variant of the Yacc parser generator"
HOMEPAGE="http://invisible-island.net/byacc/byacc.html"
SRC_URI="ftp://invisible-island.net/byacc/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DOCS=( ACKNOWLEDGEMENTS AUTHORS CHANGES NEW_FEATURES NOTES README )

src_configure() {
	econf --program-prefix=b
}
