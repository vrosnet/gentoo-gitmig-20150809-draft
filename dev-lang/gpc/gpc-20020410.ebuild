# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: George Shapovalov <georges@its.caltech.edu>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp

# Source directory; the dir where the sources can be found
# (automatically unpacked) inside ${WORKDIR}.	Usually you can just
# leave this as-is.
S="${WORKDIR}/gcc-2.95.3"

DESCRIPTION="Gnu Pascal Compiler"

SRC_URI="http://gnu-pascal.de/current/${P}.tar.gz
		ftp://gcc.gnu.org/pub/gcc/releases/gcc-2.95.3/gcc-2.95.3.tar.gz"
#only need gcc-core (smaller download), but user will likely have this one already

HOMEPAGE="http://gnu-pascal.de"

DEPEND="virtual/glibc
		~sys-devel/gcc-2.95.3"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${P}.tar.gz"
	unpack "gcc-2.95.3.tar.gz"

	cd "${WORKDIR}/${P}/p"

	cp config-lang.in config-lang.in.orig
    sed -e "s:read:#read:" config-lang.in.orig > config-lang.in

	cd "${WORKDIR}/${P}"	
	mv p "${S}/gcc/"

	cd "${S}"
}

src_compile() {

	#lets reduce optimisation somewhat
	export CFLAGS="${CFLAGS/-O?/-O2}"
    export CXXFLAGS="${CXXFLAGS/-O?/-O2}"

	#it also looks like gpc does not like -pipe
    export CFLAGS="${CFLAGS/-pipe/}"
    export CXXFLAGS="${CXXFLAGS/-pipe/}"

	./configure --enable-languages=pascal\
		--host=${CHOST} --build=${CHOST} --target=${CHOST} \
		--prefix=/usr \
		--enable-version-specific-runtime-libs \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	#now for the true magic :)
	#gpc is based on gcc and therefore rebuilds gcc backend when compiled
	#we do not want to overwrite it, do we? (even though the binaries are supposed to be the same)
	#so do a dirty hack:
	#go in to the image dir and delete everything inappropriate
	
	cd ${D}/usr/

	mv bin bin.orig
	mkdir bin
	mv bin.orig/gpc* bin
	rm -rf bin.orig

	#now lib
	cd ${D}/usr/lib/
	rm libiberty.a
	
	cd ${D}/usr/lib/gcc-lib/i686-pc-linux-gnu/
	mv 2.95.3 2.95.3.orig
	mkdir 2.95.3
	mv 2.95.3.orig/{gpc1,gpcpp,libgpc.a,units} 2.95.3
	mkdir 2.95.3/include
	mv 2.95.3.orig/include/gpc-in-c.h 2.95.3/include/
	rm -rf 2.95.3.orig
	

	# Install documentation.
	#gpc wants to install some files and a lot of demos under /usr/doc
	#lets move it under /usr/share/doc
	#(Ok, this is not the most buitiful way to do it, but it seems to be the easiest here :))
	cd ${D}/usr/doc
	mkdir -p ${D}/usr/share/doc/
	mv gpc/ ${D}/usr/share/doc/${P}
	cd ${D}/usr/share/doc/${P}
	for fn in *; do [ -f $fn ] && gzip $fn; done

	cd ${D}/usr/
	rmdir doc
}
