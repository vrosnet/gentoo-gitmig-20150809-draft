# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_vdbh/mod_vdbh-1.0.2-r1.ebuild,v 1.5 2005/01/09 00:13:00 hollow Exp $

DESCRIPTION="An Apache2 DSO for mass virtual hosting using a MySQL database"
HOMEPAGE="http://www.synthemesc.com/mod_vdbh/"
SRC_URI="http://www.synthemesc.com/downloads/${PN}/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=net-www/apache-2*
	>=dev-db/mysql-3.23*
	>=sys-libs/zlib-1.1.4"

src_compile() {
	apxs2 -DHAVE_STDDEF_H -I/usr/include/mysql -Wl,-lmysqlclient \
		-c ${PN}.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/21_mod_vdbh.conf
	dodoc ${FILESDIR}/21_mod_vdbh.conf AUTHORS COPYING README TODO
}
