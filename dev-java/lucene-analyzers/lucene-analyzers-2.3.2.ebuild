# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/lucene-analyzers/lucene-analyzers-2.3.2.ebuild,v 1.4 2009/10/03 12:41:29 volkmar Exp $

JAVA_PKG_IUSE="source"
inherit java-pkg-2 java-ant-2 java-osgi

MY_PN="${PN/lucene-}"
MY_P="${P/-${MY_PN}}"

DESCRIPTION="Lucene Analyzers additions"
HOMEPAGE="http://lucene.apache.org/java"
SRC_URI="mirror://apache/lucene/java/${MY_P}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="2.3"
KEYWORDS="amd64 ~ia64 ppc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}/contrib/${MY_PN}"

src_install() {
	java-osgi_newjar-fromfile "${WORKDIR}/${MY_P}/build/contrib/${MY_PN}/${PN}-${SLOT}.jar" \
			"${FILESDIR}/manifest" "Apache Lucene Analysis"

	use source && java-pkg_dosrc "${S}/src/java/org"
}
