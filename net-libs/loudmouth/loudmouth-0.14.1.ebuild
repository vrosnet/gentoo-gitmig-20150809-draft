# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-0.14.1.ebuild,v 1.4 2004/06/24 23:16:05 agriffis Exp $

inherit gnome2

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://www.imendio.com/projects/loudmouth/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"

IUSE="doc ssl"

RDEPEND=">=dev-libs/glib-2
	ssl? ( net-libs/gnutls )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.0 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

use ssl \
	&& G2CONF="${G2CONF} --with-ssl" \
	|| G2CONF="${G2CONF} --without-ssl"
