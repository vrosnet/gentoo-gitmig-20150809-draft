# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_QuickForm/PEAR-HTML_QuickForm-3.2.1-r1.ebuild,v 1.3 2004/09/25 00:20:08 pvdabeel Exp $

inherit php-pear

DESCRIPTION="The PEAR::HTML_QuickForm package provides methods for creating, validating, processing HTML forms."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND=">=dev-php/PEAR-HTML_Common-1.2.1
		dev-php/PEAR-HTML_Template_Flexy
		dev-php/PEAR-HTML_Template_IT"
# the last two would be option on doc? but I think we should put the docs there
# anyway
IUSE=""
