# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tom von Schwerdtner <tvon@etria.org>

A=libdbi-0.6.2.tar.gz
S=${WORKDIR}/libdbi-0.6.2
DESCRIPTION="libdbi implements a database-independent abstraction layer in C -- PostgreSQL plugin"
SRC_URI="http://prdownloads.sourceforge.net/libdbi/${A}"
HOMEPAGE="http://libdbi.sourceforge.net/"


DEPEND="virtual/glibc
	>=dev-db/postgresql-7.1
	>=dev-libs/libdbi-0.6.2"

src_compile() {

	local myconf

	./configure --prefix=/usr --with-pgsql || die  
	make || die
}

src_install() {

	cd plugins/postgresql/
	make DESTDIR=${D} install || die
}

