# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM/XML-DOM-1.39.ebuild,v 1.3 2002/07/11 06:30:23 drobbins Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Perl module for an DOM Level 1 compliant interface"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp DOM.pm DOM.pm.orig
  sed -e 's:\\\d:[0-9]:' DOM.pm.orig > DOM.pm
}
