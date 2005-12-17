# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-pdflib/pecl-pdflib-2.0.4-r1.ebuild,v 1.4 2005/12/17 21:24:01 chtekk Exp $

PHP_EXT_NAME="pdf"
PHP_EXT_PECL_PKG="pdflib"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~ppc ~ppc64 ~sparc ~x86"
DESCRIPTION="PHP extension for creating PDF files."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}
		media-libs/pdflib"

need_php_by_category

src_unpack() {
	unpack ${A}

	cd "${S}"

	# Patch for http://pecl.php.net/bugs/bug.php?id=3554
	epatch "${FILESDIR}/ifgd-patch.diff"
}
