# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.32.ebuild,v 1.13 2007/05/12 03:10:55 chtekk Exp $

inherit perl-module

DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.masonhq.com/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha amd64 ppc sparc x86"
IUSE="modperl doc"
SRC_TEST="do"

DEPEND="!modperl? ( virtual/perl-CGI )
	modperl? (
		>=net-www/apache-2
		www-misc/libapreq2
		>=www-apache/mod_perl-2
	)
	>=dev-perl/Params-Validate-0.7
	>=dev-perl/module-build-0.28
	>=dev-perl/Class-Container-0.08
	>=dev-perl/Exception-Class-1.15
	virtual/perl-Scalar-List-Utils
	virtual/perl-File-Spec
	>=dev-perl/Cache-Cache-1.01
	dev-lang/perl"


mydoc="CREDITS UPGRADE"
myconf="--noprompts"

perl-module_src_prep() {
	# Note about new modperl use flag
	if use !modperl ; then
		ewarn "HTML-Mason will only install with modperl support"
		ewarn "if the use flag modperl is enabled."
		sleep 5
	fi
	# rendhalver - needed to set an env var for the build script so it finds our apache.
	APACHE="/usr/sbin/apache2" perl ${S}/Build.PL installdirs=vendor destdir=${D} ${myconf}
}

src_install () {
	perl-module_src_install
	# rendhalver - the html docs have subdirs so this gets all of them
	use doc && dohtml -r htdocs/*
}


