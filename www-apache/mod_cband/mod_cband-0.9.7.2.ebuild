# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_cband/mod_cband-0.9.7.2.ebuild,v 1.1 2006/02/28 21:10:06 nelchael Exp $

inherit apache-module

DESCRIPTION="Apache 2 bandwidth quota and throttling module"
HOMEPAGE="http://dembol.nasa.pl/?op=projekty&it=cband&pg="
LICENSE="GPL-2"
SRC_URI="http://cband.linux.pl/download/mod-cband-${PV}.tgz"

KEYWORDS="~x86"
IUSE=""
SLOT="0"

S="${WORKDIR}/mod-cband-${PV}"

DOCFILES="conf/vhosts3.conf.example \
		conf/vhosts2.conf.example \
		conf/vhosts.conf.example \
		Changes AUTHORS doc/*"
APACHE2_MOD_DEFINE="CBAND"
APACHE2_MOD_CONF="10_mod_cband"

need_apache2

src_compile() {

	econf || die "econf failed"
	emake || die "emake failed"

}
