# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.6.0.ebuild,v 1.2 2004/12/18 21:32:55 absinthe Exp $

inherit libtool

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.6/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390 ~ppc-macos"
IUSE="doc static"

DEPEND=">=dev-util/pkgconfig-0.14
	>=sys-devel/gettext-0.11
	doc? ( >=dev-util/gtk-doc-1 )"

RDEPEND="virtual/libc"

src_compile() {

	if use macos; then
		glibtoolize
	elif use ppc-macos; then
		glibtoolize
	else
		elibtoolize
	fi

	econf \
		--with-threads=posix \
		`use_enable static` \
		`use_enable doc gtk-doc` \
		|| die

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	# Do not install charset.alias for ppc-macos since it already exists.
	if (use macos || use ppc-macos); then
		einfo "Not installing charset.alias on macos"
		rm ${D}/usr/lib/charset.alias || die "Cannot remove charset.alias from the image"
	fi

	# Consider invalid UTF-8 filenames as locale-specific.
	# FIXME : we should probably move to suggesting G_FILENAME_ENC
	dodir /etc/env.d
	echo "G_BROKEN_FILENAMES=1" > ${D}/etc/env.d/50glib2

	dodoc AUTHORS ChangeLog* README* INSTALL NEWS*

}
