# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Request/PEAR-HTTP_Request-1.3.0.ebuild,v 1.2 2005/11/22 17:35:15 corsair Exp $

inherit php-pear-r1

DESCRIPTION="Provides an easy way to perform HTTP requests"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-Net_URL-1.0.14-r1
	>=dev-php/PEAR-Net_Socket-1.0.6-r1"
