# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fastutil/fastutil-5.0.5.ebuild,v 1.1 2007/01/13 13:20:09 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Provides type-specific maps, sets and lists with a small memory footprint for much faster access and insertion."
SRC_URI="http://fastutil.dsi.unimi.it/${P}-src.tar.gz"
HOMEPAGE="http://fastutil.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="5.0"
IUSE="doc source"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND=">=virtual/jdk-1.5
	>=dev-java/ant-core-1.6
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.5"

src_compile() {
	emake sources || die "failed to make sources"
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar

	dodoc CHANGES README || die

	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc java/it
}

