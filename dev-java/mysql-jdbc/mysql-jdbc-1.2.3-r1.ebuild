# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/mysql-jdbc/mysql-jdbc-1.2.3-r1.ebuild,v 1.8 2002/09/20 20:59:58 vapier Exp $

MY_P=${P/-/.}
MY_P=mm.${MY_P/.3/c}
S=${WORKDIR}/${MY_P}
DESCRIPTION="JDBC Driver for MySQL"
SRC_URI="http://www.mysql.com/Downloads/Contrib/${MY_P}.tar.gz"
HOMEPAGE="http://mmmysql.sourceforge.net/"
DEPEND=">=virtual/jdk-1.2.2"
RDEPEND="$DEPEND"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

src_compile() {                           
	jar -cf mysql-jdbc.jar org
}

src_install() {                               
	cd ${S}
	dojar mysql-jdbc.jar

	dohtml -r doc/*
}
