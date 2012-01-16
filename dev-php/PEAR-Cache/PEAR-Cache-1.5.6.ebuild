# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Cache/PEAR-Cache-1.5.6.ebuild,v 1.2 2012/01/16 12:42:35 ago Exp $

inherit php-pear-r1

DESCRIPTION="Framework for caching of arbitrary data"

LICENSE="PHP-2.02"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=dev-php/PEAR-PEAR-1.7.0"
RDEPEND="dev-php/PEAR-HTTP_Request"
