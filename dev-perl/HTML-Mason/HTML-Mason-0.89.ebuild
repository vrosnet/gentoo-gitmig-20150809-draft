# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-0.89.ebuild,v 1.2 2000/12/15 07:29:29 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="http://www.masonhq.com/download/${A}"
HOMEPAGE="http://www.masonhq.com/"

DEPEND=">=sys-devel/perl-5"

src_compile() {
    cd ${S}
    perl Makefile.PL
    try make 
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc Changes README CREDITS UPGRADE htdocs/*
}
