# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.9.7.ebuild,v 1.2 2002/12/16 23:15:52 agriffis Exp $

inherit eutils

IUSE="perl gnome ssl gtk python mmx ipv6 nls kde" 
S=${WORKDIR}/${P}
DESCRIPTION="X-Chat is a graphical IRC client for UNIX operating systems."
SRC_URI="http://www.xchat.org/files/source/1.9/${P}.tar.bz2"
HOMEPAGE="http://www.xchat.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	perl?   ( >=sys-devel/perl-5.6.1 )
	gnome? ( >=x11-libs/libzvt-2.0.1
		 >=gnome-base/libgnome-2.0.1
		 >=gnome-base/gnome-applets-2.0.0
		 >=gnome-base/gnome-panel-2.0.1 )
	ssl?	( >=dev-libs/openssl-0.9.6d ) 
	python? ( dev-lang/python )"               

DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_unpack() {
	unpack ${A}	
	epatch ${FILESDIR}/${P}-serverlist-corruption-fix.patch
}

src_compile() {
	local myopts myflags

	if [ ! `use perl` ] ; then
		use gnome \
			&& myopts="${myopts} --enable-gnome --enable-panel" \
			|| myopts="${myopts} --enable-gtkfe --disable-gnome --disable-zvt"
		
	#	use gnome \
	#		&& CFLAGS="${CFLAGS} -I/usr/include/orbit-2.0" \
	#		|| myopts="${myopts} --disable-gnome"
	fi

	use gtk \
		&& myopts="${myopts} --enable-gtkfe" \
		|| myopts="${myopts} --disable-gtkfe"
	use ssl \
		&& myopts="${myopts} --enable-openssl" \
		|| myopts="${myopts} --disable-openssl"
	use perl \
		&& myopts="${myopts} --enable-perl" \
		|| myopts="${myopts} --disable-perl"
	use python \
		&& myopts="${myopts} --enable-python" \
                || myopts="${myopts} --disable-python"
	use nls \
		&& myopts="${myopts} --enable-nls --enable-hebrew" \
		|| myopts="${myopts} --disable-nls --disable-hebrew"
	# --enable-japanese-conv  is broken
	use mmx	\
		&& myopts="${myopts} --enable-mmx"	\
		|| myopts="${myopts} --disable-mmx"
	use ipv6 \
		&& myopts="${myopts} --enable-ipv6" \
		|| myopts="${myopts} --disable-ipv6"

	[ -n "${DISABLE_XFT}" ] && myopts="${myopts} --disable-xft"
	
	econf \
		--program-suffix=-2 \
		${myopts} || die "Configure failed"
	
	MAKEOPTS="-j1" emake || die "Compile failed"
}

src_install() {
	# some magic to create a menu entry for xchat 2	
	mv xchat.desktop xchat.desktop.old
	sed -e "s:Exec=xchat:Exec=xchat-2:" -e "s:Name=XChat IRC:Name=XChat 2 IRC:" xchat.desktop.old > xchat.desktop

	einstall install || die "Install failed"

	dodoc AUTHORS COPYING ChangeLog README
}

pkg_postinst() {
	einfo "If you want X-Chat to correctly display Hebrew (bidi) do "
	einfo "'export DISABLE_XFT=1' and re-emerge xchat"
}
