# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-panel/xfce4-panel-4.9.2.ebuild,v 1.3 2012/05/05 09:12:18 jdhore Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Panel for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug"

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.24
	>=x11-libs/cairo-1
	>=x11-libs/gtk+-2.20:2
	x11-libs/libX11
	>=x11-libs/libwnck-2.31:1
	>=xfce-base/exo-0.7.3
	>=xfce-base/garcon-0.1.12
	>=xfce-base/libxfce4ui-4.9.2
	>=xfce-base/libxfce4util-4.9.1
	>=xfce-base/xfconf-4.9.1"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	DOCS=( AUTHORS ChangeLog NEWS THANKS )
}
