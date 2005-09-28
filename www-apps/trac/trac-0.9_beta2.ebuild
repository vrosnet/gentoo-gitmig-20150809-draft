# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac/trac-0.9_beta2.ebuild,v 1.1 2005/09/28 22:35:52 dju Exp $

inherit distutils webapp

MY_P=${P/_beta/b}

DESCRIPTION="Trac is a minimalistic web-based project management, wiki and bug/issue tracking system."
HOMEPAGE="http://trac.edgewall.com/"
SRC_URI="http://ftp.edgewall.com/pub/trac/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="trac"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="vhosts cgi fastcgi postgres sqlite enscript silvercity"

# doing so because utils (such as trac-admin), manpages... overlap
SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

# we need virtual/httpd-cgi to bring apache/lighttpd/whatever in when USE cgi
# we need virtual/httpd-fcgi to bring mod_fastcgi/lighttpd/whtever in when USE fastcgi
# we need virtual/httpd-python to bring mod_python/whatever in (when USE python?)
DEPEND="$DEPEND
	>=dev-lang/python-2.3
	>=dev-python/docutils-0.3.3
	dev-libs/clearsilver
	>=dev-util/subversion-1.1
	sqlite? ( >=dev-python/pysqlite-2 )
	postgres? ( dev-python/psycopg )
	enscript? ( app-text/enscript )
	silvercity? ( app-text/silvercity )"

pkg_setup () {
	if ! use postgres && ! use sqlite ; then
		eerror "You must select at least one database backend,"
		eerror "using sqlite or postgres USE flags."
		die "no database backend selected!"
	fi

	webapp_pkg_setup
}

src_install () {
	# project databases might go in here
	keepdir /var/lib/trac

	webapp_src_preinst
	distutils_src_install

	dodoc AUTHORS INSTALL RELEASE THANKS UPGRADE
	rm ${D}/usr/share/doc/${P}/COPYING.gz
	rm ${D}/usr/share/doc/${P}/MANIFEST.in.gz
	rm ${D}/usr/share/doc/${P}/PKG-INFO.gz

	# if needed, install cgi/fcgi scripts for webapp-config
	local my_dir=${D}/usr/share/trac
	if use cgi ; then
		mv ${my_dir}/cgi-bin/trac.cgi ${D}${MY_CGIBINDIR} || die
	fi
	if use fastcgi ; then
		mv ${my_dir}/cgi-bin/trac.fcgi ${D}${MY_CGIBINDIR} || die
	fi
	rm -rf ${my_dir}/cgi-bin || die

	for lang in en; do
		webapp_postinst_txt ${lang} ${FILESDIR}/${PV}-postinst-${lang}.txt
	done

	webapp_src_install
}
