# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Tests/Pod-Tests-1.190.0.ebuild,v 1.3 2012/02/24 16:55:30 jer Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.19
inherit perl-module

DESCRIPTION="Extracts embedded tests and code examples from POD"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="virtual/perl-File-Spec"
DEPEND="${RDEPEND}"

SRC_TEST="do"
