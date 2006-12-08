# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmi-interface/jmi-interface-1.0-r2.ebuild,v 1.2 2006/12/08 23:58:01 caster Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java Metadata Interface Sample Class Interface"
HOMEPAGE="http://java.sun.com/products/jmi/"
JMI_ZIP="jmi-${PV/./_}-fr-interfaces.zip"
MOF_XML="mof-${PV}.xml.bz2"
SRC_URI="mirror://gentoo/${JMI_ZIP}
		 mirror://gentoo/${MOF_XML}"

LICENSE="sun-bcla-jmi"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}"

src_unpack() {
	mkdir "${S}/src" && cd "${S}/src"
	unpack ${JMI_ZIP}

	cd "${S}"
	# rename enum keywords because javadoc hates them
	# even with -source 1.4, bummer
	epatch "${FILESDIR}/${P}-enum.patch"
	cp "${FILESDIR}/${P}-build.xml" build.xml

	#adding mof.xml required by Netbeans #98603
	mkdir -p "${S}/build/javax/jmi/model/resources"
	cd "${S}/build/javax/jmi/model/resources"
	unpack ${MOF_XML}
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_dojar dist/*.jar

	use doc && java-pkg_dojavadoc doc
	use source && java-pkg_dosrc src/javax
}
