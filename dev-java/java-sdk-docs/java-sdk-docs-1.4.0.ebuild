# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

At="j2sdk-1_4_0-doc.zip"
S="${WORKDIR}/docs"
SRC_URI=""
DESCRIPTION="Javadoc for Java SDK version 1.4"
HOMEPAGE="http://java.sun.com/j2se/1.4/download.html"
LICENSE="sun-j2sl"
SLOT="1.4"
KEYWORDS="x86 ppc sparc"

DEPEND="app-arch/unzip"
	
src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE} and move it to ${DISTDIR}"
	fi
	unpack ${At} || die
}

src_install(){
	dohtml index.html

	local dirs="api guide images relnotes tooldocs"
	
	for i in $dirs ; do
		cp -a $i ${D}/usr/share/doc/${P}/html
	done	
}
