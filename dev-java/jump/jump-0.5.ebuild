# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jump/jump-0.5.ebuild,v 1.1 2007/04/28 17:01:07 caster Exp $

JAVA_PKG_IUSE="doc examples source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="JUMP Ultimate Math Package (JUMP) is a Java-based extensible high-precision math package."
SRC_URI="mirror://sourceforge/${PN}-math/${P}.tar.gz"
HOMEPAGE="http://jump-math.sourceforge.net/"
KEYWORDS="~x86 ~ppc ~amd64"
LICENSE="BSD"
SLOT="0"
DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/ant-junit =dev-java/junit-3* )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i 's:${java.home}/src::' -i build.xml || die
	java-ant_rewrite-classpath
}

EANT_BUILD_TARGET="jar"
EANT_DOC_TARGET="apidocs"

src_test() {
	local cp="$(java-pkg_getjars junit)"
	ANT_TASKS="ant-junit" eant do-tests -Dgentoo.classpath="${cp}"
}

src_install() {
	java-pkg_dojar build/${PN}.jar

	use doc && java-pkg_dojavadoc  build/apidocs
	use examples && java-pkg_doexamples src/examples
	use source && java-pkg_dosrc src/main/org
}
