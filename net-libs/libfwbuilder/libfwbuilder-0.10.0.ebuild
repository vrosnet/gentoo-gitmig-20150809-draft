# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-0.10.0.ebuild,v 1.2 2001/11/16 12:37:17 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A firewall GUI"
SRC_URI="http://prdownloads.sourceforge.net/fwbuilder/$A"
HOMEPAGE="http://fwbuilder.sourceforge.net"

DEPEND=">=dev-libs/libsigc++-1.0.4
	>=dev-libs/libxslt-1.0.7-r1"

src_compile() {

    ./configure --prefix=/usr --host=${CHOST} || die
    if [ "`use static`" ] ; then
        make LDFLAGS="-static" || die
    else
        make || die
    fi

}

src_install () {

    make DESTDIR=${D} install || die
    prepalldocs

}

