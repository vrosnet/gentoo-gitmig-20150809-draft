# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ipchains/ipchains-1.3.10.ebuild,v 1.1 2000/11/26 13:42:00 achim Exp $
   
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="2.2 kernel equivalent of ipfwadm"
SRC_URI="http://netfilter.kernelnotes.org/ipchains/${A}"
HOMEPAGE="http://netfilter.filewatcher.org/ipchains/"


src_compile() {                           
    try make clean all
}

src_unpack() {

    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/= -g -O/= ${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}/libipfwc
    mv Makefile Makefile.orig
    sed -e "s/= -g -O/= ${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                               
    into /
    dosbin ipchains
    doman ipfw.4 ipchains.8
    dodoc COPYING README ipchains-quickref.ps
}


