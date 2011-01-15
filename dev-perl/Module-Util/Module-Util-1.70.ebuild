# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Util/Module-Util-1.70.ebuild,v 1.1 2011/01/15 08:35:47 tove Exp $

EAPI=3

MODULE_AUTHOR=MATTLAW
MODULE_VERSION=1.07
inherit perl-module

DESCRIPTION="Module name tools and transformations"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build"

SRC_TEST=do
