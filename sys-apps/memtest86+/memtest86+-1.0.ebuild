# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtest86+/memtest86+-1.0.ebuild,v 1.1 2004/02/01 16:34:59 spock Exp $

DESCRIPTION="Memory tester based on memtest86"
HOMEPAGE="http://www.memtest.org/"
SRC_URI="http://www.memtest.org/download/memtest_source_v1.00.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e '/DISCARD/d' -i memtest_shared.lds
}

src_compile() {
	emake || die
}

src_install() {

	umountboot=0

	# no /boot? try to mount..
	if [ ! -d /boot ] ; then
		mount /boot 2>/dev/null >/dev/null

		if [ $? -eq 0 ] ; then
			umountboot=1
		else
			die "Can't find /boot"
		fi
	fi

	dodir /boot/memtest86plus
	cp memtest.bin ${D}/boot/memtest86plus/memtest.bin

	if [ "${umountboot}" -eq 1 ] ; then
		umount /boot 2>/dev/null >/dev/null
	fi

	dodoc README README.build-process
}

pkg_postinst() {
	einfo
	einfo "memtest.bin has been installed in /boot/memtest86plus/"
	einfo "You may wish to update your bootloader configs"
	einfo "by adding these lines:"
	einfo " - For grub:"
	einfo "    > title=Memtest86Plus"

	# a little magic to make users' life as easy as possible ;)
	bootpart=0
	root="(hd0,0)"
	res=`cat /etc/fstab | grep /boot | grep -v "^#" | awk '{print $1}' | grep '/dev/hd[a-z0-9]\+'`
	if [ -n "${res}" ] ; then
		bootpart=1
	else
		res=`cat /etc/fstab | grep -v '^#' | grep -e '/dev/hd[a-z0-9]\+[[:space:]]\+\/[[:space:]]\+' | awk '{print $1}'`
	fi

	if [ -n "${res}" ] ; then
		root=`echo ${res} | grep -o '[a-z][0-9]' | tr -t a-z 0123456789 | sed -e 's/\([0-9]\)\([0-9]\)/\1 \2/' | awk '{print "(hd" $1 "," $2-1 ")" }'`
	fi

	einfo "    > root ${root}"
	if [ "${bootpart}" -eq 1 ] ; then
		einfo "    > kernel /memtest86plus/memtest.bin"
	else
		einfo "    > kernel /boot/memtest86plus/memtest.bin"
	fi

	einfo " - For lilo:"
	einfo "    > image  = /boot/memtest86plus/memtest.bin"
	einfo "    > label  = Memtest86Plus"
	einfo
}

