# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-extras/xfce4-extras-4.2.3.2.ebuild,v 1.12 2007/03/02 22:37:24 drac Exp $

DESCRIPTION="Xfce4 extras ebuild"
HOMEPAGE="http://www.xfce.org/"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
IUSE="battery"

RDEPEND=">=xfce-base/xfce4-${PV}
	>=xfce-extra/xfce4-showdesktop-0.4.0-r1
	battery? ( >=xfce-extra/xfce4-battery-0.2.0-r1 )
	>=xfce-extra/xfce4-systemload-0.3.4-r1
	>=xfce-extra/xfce4-minicmd-0.3.0-r1
	>=xfce-extra/xfce4-netload-0.2.3-r1
	>=xfce-extra/xfce4-clipman-0.4.1-r1
	>=xfce-extra/xfce4-cpugraph-0.2.2-r1
	>=xfce-extra/xfce4-notes-0.9.7-r1
	>=xfce-extra/xfce4-taskbar-0.2.2-r1
	>=xfce-extra/xfce4-windowlist-0.1.0-r1"
