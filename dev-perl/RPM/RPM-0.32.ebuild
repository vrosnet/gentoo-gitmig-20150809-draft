# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPM/RPM-0.32.ebuild,v 1.1 2002/01/27 03:32:57 woodchip Exp $

S=${WORKDIR}/Perl-${P}
DESCRIPTION="RPM:: module for perl"
SRC_URI="http://www.cpan.org/authors/id/RJRAY/Perl-${P}.tar.gz"

DEPEND="virtual/glibc >=sys-devel/perl-5 app-arch/rpm"

src_compile() {

	OPTIMIZE="$CFLAGS" perl Makefile.PL /usr
	make || die
}

src_install () {

	eval `perl '-V:installarchlib'`
	mkdir -p ${D}/$installarchlib

	make \
		PREFIX=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		install || die

	dodoc ChangeLog MANIFEST README ToDo
}
