# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-launcher/commons-launcher-0.9.ebuild,v 1.6 2004/10/17 07:26:07 absinthe Exp $

inherit java-pkg

DESCRIPTION="Commons-launcher eliminates the need for a batch or shell script to launch a Java class."
HOMEPAGE="http://jakarta.apache.org/commons/launcher/"
SRC_URI="ftp://ftp.ibiblio.org/pub/mirrors/apache/jakarta/commons/launcher/source/launcher-0.9-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"
IUSE="jikes doc"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-1.4"

S=${WORKDIR}/${PN}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation problem"
}

src_install () {
	java-pkg_dojar dist/bin/*.jar || die "java-pkg_dojar died"
	dohtml *.html
	use doc && java-pkg_dohtml -r dist/docs/*
}
