# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-2.2.0_alpha3.ebuild,v 1.1 2001/03/28 16:37:55 achim Exp $

A=${PN}-2.2.0-alpha3.tar.bz2
S=${WORKDIR}/${PN}-2.2.0-alpha3
DESCRIPTION="Samba"
SRC_URI="ftp://ftp.samba.org/pub/samba/alpha/${A}"
HOMEPAGE="http://www.samba.org"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.72 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

#ssl support removed -- it doesn't work...

src_compile() { 
  local myconf
  if [ "`use pam`" ]
  then
    myconf="--with-pam"
  else
    myconf="--without-pam"
  fi
#  if [ "`use tcpd`" ]
#  then
#    myconf="$myconf --with-smbwrapper"
#  else
#    myconf="$myconf --without-smbwrapper"
#  fi

  cd ${S}/source

  # Disabled automout support, because it failed
  # Added -lncurses for readline detection

  try LDFLAGS="-lncurses" ./configure --prefix=/usr \
	--sysconfdir=/etc/smb --localstatedir=/var/log --libdir=/etc/smb --sbindir=/usr/sbin \
	--without-automount --with-utmp --without-sambabook --with-netatalk --with-smbmount \
	--with-privatedir=/etc/smb/private --with-lockdir=/var/lock --with-swatdir=/usr/share/swat \
	--with-mandir=/usr/share/man ${myconf}
  try make
}

src_install() { 
	cd ${S}/source
	dodir /usr
	dodir /etc/smb
	dodir /usr/share/swat
	dodir /usr/share/doc/${P}/html/book
	dodir /var/log
	dodir /var/lock
	try make install prefix=${D}/usr BASEDIR=${D}/usr LIBDIR=${D}/etc/smb VARDIR=${D}/var/log \
		PRIVATEDIR=${D}/etc/smb/private SWATDIR=${D}/usr/share/swat \
		LOCKDIR=${D}/var/lock SBINDIR=${D}/usr/sbin MANDIR=${D}/usr/share/man
	into /usr
	cd ${S}
	dodoc COPYING Manifest README Roadmap WHATSNEW.txt
	cd ${S}/docs
	dodoc announce history NT4-Locking.reg NT4_PlainPassword.reg
	dodoc samba.lsm THANKS Win*
	docinto html
	dodoc htmldocs/*.html
	docinto html/book
	dodoc htmldocs/using_samba/*.html
	docinto html/book/gifs
	dodoc htmldocs/using_samba/gifs/*
	docinto html/book/figs
	dodoc htmldocs/using_samba/figs/*
	docinto faq
	dodoc faq/*.txt
	docinto html/faq
	dodoc faq/*.html
	docinto textdocs
	dodoc textdocs/*
	cd ${S}
	cp -a examples ${D}/usr/share/doc/${PF}
	cp examples/smb.conf.default ${D}/etc/smb/smb.conf.example
	
	#touch ${D}/etc/smb/smb.conf to create a dummy file so that people installing samba
	#just to mount smb shares don't get annoying warnings all the time

	touch ${D}/etc/smb/smb.conf
	
	exeinto /etc/rc.d/init.d
	doexe ${FILESDIR}/samba ${FILESDIR}/svc-samba
	diropts -m0700
	dodir /etc/smb/private

	#now, we move smbmount from /usr/sbin to /sbin, and rename it to mount.smbfs
	#this allows it to work perfectly with the standard Linux mount command
	# :)

	dodir /sbin
	mv ${D}/usr/bin/smbmount ${D}/sbin/mount.smbfs


	#supervise support
	local x
	for x in smbd nmbd
	do
		dodir /var/lib/supervise/services/${x}/log
		chmod +t ${D}/var/lib/supervise/services/${x}
		exeinto /var/lib/supervise/services/${x}
		newexe ${FILESDIR}/${x}-run run
		exeinto /var/lib/supervise/services/${x}/log
		newexe ${FILESDIR}/${x}-log run
	done
}

pkg_postinst() {
	echo "Samba installed.  To configure samba (the server) to start on boot, type:"
	echo
	echo "# rc-update add svc-samba    [ for high-availability supervised Samba -- recommended ]"
	echo "# rc-update add samba		[ for normal non-supervised Samba ]"
	echo 
	echo "Also, please note that you must configure /etc/smb/smb.conf before Samba (the server) will "
	echo "work properly.  Mounting smb shares and the smbclient program should work immediately,"
	echo "without any tweaking required."
	echo
	echo "To mount SMB shares, type something like this.  You'll need kernel SMB support to do this:"
	echo "# mount -t smbfs -o username=drobbins,password=foo,ip=192.168.1.1 //mybox/drobbins /mnt/foo" 
	echo
	echo "An empty file exists at /etc/smb/smb.conf at this moment, so that mounting smb shares won't"
	echo "produce an annoying warning message."
	echo
	echo "Another note.  If you want to allow normal users to mount smb shares, type the following as"
	echo "root:"
	echo "# chmod u+s /usr/bin/smbmnt"
}






