# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/pcsc-perl/pcsc-perl-1.4.10.ebuild,v 1.2 2010/12/06 17:11:04 flameeyes Exp $

inherit perl-module eutils multilib

DESCRIPTION="A Perl Module for PC/SC SmartCard access."
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/pcsc-perl/"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=sys-apps/pcsc-lite-1.6.0
	<sys-apps/pcsc-lite-1.6.5
	dev-lang/perl"

myconf="-I/usr/include/ -l/usr/$(get_libdir)"

mydoc="README Changelog"
