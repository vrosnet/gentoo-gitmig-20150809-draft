# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/yup/yup-0.6.5-r1.ebuild,v 1.4 2000/11/01 04:44:10 achim Exp $

P=yup-0.6.5
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Interactive automated package management program for RPM-based distributions"
SRC_URI="ftp://ftp.yellowdoglinux.com/pub/yellowdog/software/yup/"${A}

DEPEND="|| ( >=sys-devel/python-basic-1.5.2 >=dev-lang/python-1.5.2 )"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  try make build
}

src_install() {                               
  cd ${S}
  dodir /etc
  dodir /usr/sbin
  try make PREFIX=${D} install
  dodoc BUGS ChangeLog CONTRIBUTORS COPYING NEWS README TODO
}




