# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jitac/jitac-0.2.0-r2.ebuild,v 1.2 2006/10/05 14:32:09 gustavoz Exp $

inherit java-pkg-2

DESCRIPTION="An image to ASCII converter written in Java"
HOMEPAGE="http://www.roqe.org/jitac/"
SRC_URI="http://www.roqe.org/jitac/${P}.src.jar"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3
		dev-java/sun-jimi"
RDEPEND=">=virtual/jre-1.3
		dev-java/sun-jimi"

S=${WORKDIR}

src_unpack() {
	cd ${S}
	jar -xvf ${DISTDIR}/${A} || die "failed to unpack"
}

src_compile() {
	ejavac -classpath $(java-pkg_getjars sun-jimi):. $(find -name *.java)
	find . -name "*.class" -or -name "*.bdf" -or -name "*.properties" | xargs jar -cf ${PN}.jar || die "failes to ceate jar"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dolauncher ${PN} --main org.roqe.jitac.Jitac

	dodoc org/roqe/jitac/README
	use doc && java-pkg_dohtml -r org/roqe/jitac/docs/*
}

