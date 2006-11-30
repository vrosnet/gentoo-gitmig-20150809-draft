# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-validator/commons-validator-1.1.3-r1.ebuild,v 1.5 2006/11/30 15:33:11 caster Exp $

inherit java-pkg

DESCRIPTION="Jakarta component to validate user input, or data input"
HOMEPAGE="http://jakarta.apache.org/commons/validator/"
SRC_URI="mirror://apache/jakarta/commons/validator/source/${P}-src.tar.gz mirror://gentoo/commons-validator-1.1.3-gentoo-missingfiles.tar.bz2"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~x86"
IUSE="doc examples jikes source"
RDEPEND=">=virtual/jre-1.3
	=dev-java/jakarta-oro-2.0*
	>=dev-java/commons-digester-1.5
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.3
	=dev-java/commons-beanutils-1.6*
	>=dev-java/xerces-2.7"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}
	cd ${S}
	#dirty hack
	sed -e 's:target name="compile" depends="static":target name="compile" depends="prepare":' -i build.xml || die "sed failed"
	echo "oro.jar=$(java-pkg_getjars jakarta-oro-2.0)" >> build.properties
	echo "commons-digester.jar=$(java-pkg_getjars commons-digester)" >> build.properties
	echo "commons-collections.jar=$(java-pkg_getjars commons-collections)" >> build.properties
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" >> build.properties
	echo "commons-beanutils.jar=$(java-pkg_getjars commons-beanutils-1.6)" >> build.properties
	echo "xerces.jar=$(java-pkg_getjar xerces-2 xercesImpl.jar)" >> build.properties
}

src_compile() {
	local antflags="compile"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "build failed"
	jar -cf ${PN}.jar -C target/classes/ . || die "could not create jar"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	if use doc; then
		java-pkg_dohtml -r dist/docs/
		java-pkg_dohtml PROPOSAL.html STATUS.html
		dodoc LICENSE.txt
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/example/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/share/*
}
