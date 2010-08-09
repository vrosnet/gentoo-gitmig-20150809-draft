# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/compizconfig-backend-kconfig4/compizconfig-backend-kconfig4-0.8.4.ebuild,v 1.2 2010/08/09 12:51:43 scarabeus Exp $

EAPI=2

inherit kde4-base

DESCRIPTION="Compizconfig Kconfig Backend"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-dbus:4
	>=x11-libs/libcompizconfig-${PV}
	>=x11-wm/compiz-${PV}"
