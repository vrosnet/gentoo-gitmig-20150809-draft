# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.3.1-r8.ebuild,v 1.11 2003/12/06 17:53:18 strider Exp $

inherit java nsplugins

S=${WORKDIR}/j2re1.3.1
DESCRIPTION="Blackdown Java Runtime Environment 1.3.1"
SRC_URI="x86? ( mirror://blackdown.org/JDK-${PV}/i386/FCS/j2re-${PV}-FCS-linux-i386.tar.bz2 )
	ppc? ( mirror://blackdown.org/JDK-${PV}/ppc/FCS-02b/j2re-${PV}-02b-FCS-linux-ppc.bin )
	sparc? ( mirror://blackdown.org/JDK-${PV}/sparc/FCS-02b/j2re-${PV}-02b-FCS-linux-sparc.bin )"

HOMEPAGE="http://www.blackdown.org"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.5"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3.1
	virtual/java-scheme-2"
SLOT="0"
LICENSE="sun-bcla-java-vm"
KEYWORDS="~x86 ~ppc ~sparc"

src_unpack () {
	if (use ppc) || (use sparc) ; then
		tail -n +422 ${DISTDIR}/${A} | tar xjf -
	else
		unpack ${A}
	fi
	if (use sparc) ; then
		# The files are owned by 1000.100, for some reason.
		chown -R root:root
	fi
}

src_install () {
	dodir /opt/${P}

	cp -dpR ${S}/{bin,lib,man,plugin} ${D}/opt/${P}/
	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	if [ "${ARCH}" == "x86" ] ; then
		PLATFORM="i386"
	elif [ "${ARCH}" == "ppc" ] ; then
		PLATFORM="ppc"
	elif [ "${ARCH}" == "sparc" ] ; then
		PLATFORM="sparc"
	fi
	inst_plugin /opt/${P}/plugin/${PLATFORM}/mozilla/javaplugin_oji.so

	mv ${D}/opt/${P}/lib/font.properties ${D}/opt/${P}/lib/font.properties.orig
	sed "s/standard symbols l/symbol/g" \
		< ${D}/opt/${P}/lib/font.properties.orig \
		> ${D}/opt/${P}/lib/font.properties
	rm ${D}/opt/${P}/lib/font.properties.orig

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	java_pkg_postinst
}

