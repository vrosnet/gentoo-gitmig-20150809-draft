# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Runtime/Module-Runtime-0.13.0.ebuild,v 1.2 2012/03/24 12:58:59 grobian Exp $

EAPI=4

MODULE_AUTHOR=ZEFRAM
MODULE_VERSION=0.013
inherit perl-module

DESCRIPTION="Runtime module handling"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
