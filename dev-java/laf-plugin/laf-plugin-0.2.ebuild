# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/laf-plugin/laf-plugin-0.2.ebuild,v 1.1 2007/04/28 22:08:06 caster Exp $

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

DESCRIPTION="A generic plugin framework for look-and-feels"
HOMEPAGE="http://${PN}.dev.java.net/"
# repackaged from zip and renamed to contain PV
SRC_URI="mirror://gentoo/${P}-src.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	cp "${FILESDIR}/${P}-build.xml" build.xml || die
}

EANT_BUILD_TARGET="dist"

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dojavadoc api
	use source $$ java-pkg_dosrc src/org
}
