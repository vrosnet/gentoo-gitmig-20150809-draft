# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: system@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.9-r1.ebuild,v 1.2 2002/04/16 03:15:43 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="DirectFB is a thin library on top of the Linux framebuffer devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"
HOMEPAGE="http://www.directfb.org"

DEPEND="sys-devel/perl
	avi? ( =media-video/avifile-0.6* )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	flash? ( >=media-libs/libflash-0.4.10 )
	libmpeg3? ( >=media-libs/libmpeg3-1.2.3 )
	truetype? ( >=media-libs/freetype-2.0.1 )
	quicktime? ( media-libs/quicktime4linux )"

RDEPEND="${DEPEND}"

extralibinfo=""
use libmpeg3 && extralibinfo="LIBMPEG3_DIR=/usr/lib LIBMPEG3_LIBS=-lmpeg3"

src_unpack() {

	unpack ${A}

	use libmpeg3 \
		&& cp /usr/lib/libmpeg3.a ${S}/interfaces/IDirectFBVideoProvider/no
}

src_compile() {
	
	
	use mmx	\
		&& myconf="${myconf} --enable-mmx"	\
		|| myconf="${myconf} --disable-mmx"

# avifile that is in portage currently does not work with directfb
# an older one in the 0.6.0 series is required.
#	use avi	\
#		&& myconf="${myconf} --enable-avifile"	\
#		|| myconf="${myconf} --disable-avifile"
	
	myconf="${myconf} --disable-avifile"
    
	use libmpeg3 \
		&& myconf="${myconf} --with-libmpeg3=/usr/include/libmpeg3"	\
		&& mkdir ${S}/interfaces/IDirectFBVideoProvider/no	\
		|| myconf="${myconf} --without-libmpeg3"

#	use libmpeg3 \
#		&& myconf="${myconf} --with-libmpeg3=/usr/include/libmpeg3" \
#		|| myconf="${myconf} --without-libmpeg3"

	use jpeg \
		&& myconf="${myconf} --enable-jpeg" \
		|| myconf="${myconf} --disable-jpeg"

	use png \
		&& myconf="${myconf} --enable-png" \
		|| myconf="${myconf} --disable-png"

	use gif \
		&& myconf="${myconf} --enable-gif" \
		|| myconf="${myconf} --disable-gif"

	use truetype \
		&& myconf="${myconf} --enable-freetype" \
		|| myconf="${myconf} --disable-freetype"
	
	if [ "$DEBUG" ] ; then
      myconf="${myconf} --enable-debug"
    else
      myconf="${myconf} --disable-debug"
    fi
	
    ./configure	\
		--prefix=/usr \
		${myconf} || die

	make \
		"${extralibinfo}" || die

}

src_install () {
	
	insinto /etc
	doins fb.modes

	make 	\
		DESTDIR=${D}	\
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
	dohtml -r docs/html
}
