# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/httpd-php/httpd-php-5.3.ebuild,v 1.2 2010/07/19 19:14:13 jer Exp $

EAPI="2"

DESCRIPTION="Virtual to provide PHP-enabled webservers"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="5.3"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="|| ( =dev-lang/php-5.3*[apache2]
			  =dev-lang/php-5.3*[cgi]
			  =dev-lang/php-5.3*[fpm] )"
DEPEND=""
