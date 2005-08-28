# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moinmoin/moinmoin-1.3.5.ebuild,v 1.1 2005/08/28 23:38:26 rl03 Exp $

inherit webapp

PN0="moin"
S=${WORKDIR}/${PN0}-${PV}

DESCRIPTION="Python WikiClone"
SRC_URI="http://download.sourceforge.net/${PN0}/${PN0}-${PV}.tar.gz"
HOMEPAGE="http://moin.sourceforge.net"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
LICENSE="GPL-2"
IUSE="rss"

SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

DEPEND=">=dev-lang/python-2.2"
RDEPEND="${DEPEND}
	rss? ( >=dev-python/pyxml-0.8.4 )
	!<www-apps/moinmoin-1.3.5"

src_compile() {
	python setup.py build || die "python build failed"
}

src_install () {
	webapp_src_preinst

	python setup.py install --root=${D} --prefix=/usr install || die "python install failed"

	dodoc ChangeLog README docs/CHANGES docs/README.migration
	dohtml docs/INSTALL.html docs/UPDATE.html
	cd ${D}/usr/share/moin
	cp -r data underlay htdocs/* server/moin.cgi config/wikiconfig.py \
		${D}/${MY_HTDOCSDIR}
	cp -r config ${D}/${MY_HTDOCSDIR}/altconfigs
	cp -r server ${D}/${MY_HTDOCSDIR}/altserver
	cd ${D}/${MY_HTDOCSDIR}

	# data needs to be serverowned per moin devs
	for file in `find data underlay`; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done
	chmod +x moin.cgi

	webapp_configfile ${MY_HTDOCSDIR}/wikiconfig.py
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

pkg_postinst() {
	ewarn "If you are upgrading from 1.2.x to 1.3.x, please read"
	ewarn "/usr/share/doc/${P}/README.migration.gz"
	webapp_pkg_postinst
}
