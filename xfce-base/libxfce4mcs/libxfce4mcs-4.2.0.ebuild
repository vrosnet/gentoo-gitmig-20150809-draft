# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfce4mcs/libxfce4mcs-4.2.0.ebuild,v 1.1 2005/01/17 01:50:46 bcowan Exp $

DESCRIPTION="Libraries for Xfce 4"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

BZIPPED=1
XRDEPEND=">=xfce-base/libxfce4util-${PV}
	>=xfce-base/libxfcegui4-${PV}"

inherit xfce4
