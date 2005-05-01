# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcmdline/jcmdline-1.0.2.ebuild,v 1.2 2005/05/01 17:48:50 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="This package facilitates parsing/handling of command line paramters with an aim at adding consistency across various applications."
HOMEPAGE="http://jcmdline.sourceforge.net/"
SRC_URI="mirror://sourceforge/jcmdline/${P}.zip"
LICENSE="MPL-1.1"
SLOT="1.0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jikes source"
DEPEND=">=virtual/jdk-1.4
	>=app-arch/unzip-5.50
	>=dev-java/ant-core-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}

	rm -f *.jar
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} doc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar *.jar

	dodoc CHANGES CREDITS README
	use doc && java-pkg_dohtml -r doc/jcmdline/api/*
	use source && java-pkg_dosrc src/*
}
