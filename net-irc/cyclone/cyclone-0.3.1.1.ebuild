# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/cyclone/cyclone-0.3.1.1.ebuild,v 1.6 2003/02/13 14:14:24 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IRC daemon with hostname cloaking, SOCKS proxy checking and other advanced features"
SRC_URI="ftp://ftp.slashnet.org/pub/cyclone/server/${P}.tar.gz"
HOMEPAGE="http://www.slashnet.org"
SLOT="0"
KEYWORDS="~ppc"
LICENSE="GPL & BSD"
DEPEND="virtual/glibc"

src_unpack() {

	unpack ${P}.tar.gz
	cp ${FILESDIR}/res_init.c ${S}/src	

}

src_compile() {

	# Server administrators are encouraged to customize the following
	# variables if actually deploying cyclone in an IRC network.  Upon
	# merging of this package a config file is created in /etc/cyclone
	# which is reused whenever this package is upgraded.

	# If you wish to modify this configuration in the future, you can 
	# either edit this ebuild or edit the created /etc/cyclone/config and 
	# remerge this ebuild.

	if [ -f /etc/cyclone/config ]
	then
		einfo Reusing compile time configuration stored in /etc/cyclone/config...
		einfo To reset the configuration delete the config file and remerge.
		
		cp /etc/cyclone/config ${S}/.config
	else
		einfo No previous configuration found... using defaults defined in ebuild...

		cat << END_OF_CONFIG > ${S}/.config
#
# VERSION: cyclone0.3.1.1
# DATE:    `date`
# GENERATED BY: Gentoo - ${P}.ebuild
#
#
# This file was automatically generated by Portage using ${P}.ebuild and
# stored in /etc/cyclone/config for future reuse and modification
#

LAST_VERSION="cyclone0.3.1.1"
NOSPOOF_SEED01="0x12345678"
NOSPOOF_SEED02="0x9abcdef0"
CONTACT_URL=""
CONTACT_EMAIL=""
SERVICES_NAME=""
KLINE_ADDRESS="ADMIN@DID.NOT.READ.MANUAL.OR.EBUILD"
DPATH="/etc/cyclone"
SPATH="/usr/bin"
CRYPT_OPER_PASSWORD="1"
CRYPT_LINK_PASSWORD=""
LISTEN_SIZE="5"
SOCKSPORT="6013"
MAXSENDQLENGTH="3000000"
BUFFERPOOL="(9 * MAXSENDQLENGTH)"
MAXCONNECTIONS="256"
DOMAINNAME="foo"
NICKNAMEHISTORYLENGTH="2000"
SERVICES_NAME="none"

END_OF_CONFIG

	fi

	# Now we run ./Config which generates the makefiles... This is a
	# nasty hack that will probably need to be changed from version to
	# version...

	mv Config Config.orig
	sed -e 's|DEFOPT="-O2"|DEFOPT="${CFLAGS}"|' \
		-e 's|more ChangeLog||' \
		-e 's|clear||' Config.orig > Config
	chmod +x Config
	yes "" | ./Config -n

	# compile it
	emake RES="res_init.o" || die

}

src_install () {

	# store generated .config file
	dodir /etc/cyclone
	cp ${S}/.config ${D}/etc/cyclone/config

	# make install
	dodir /usr/bin
	make DPATH="${D}/etc/cyclone" SPATH="${D}/usr/bin" install || die

	# renamed ircd binary to avoid conflicts with other packages
	mv ${D}/usr/bin/ircd ${D}/usr/bin/cyclone-ircd

	# documentation files
	dodoc AUTHORS ChangeLog COPYING INSTALL README doc/oper.txt
	dodoc doc/NOTICE doc/rfc* doc/Crule.readme doc/cyclone.gif doc/Operators

	# install sample configuration file
	cp ${S}/doc/example.conf ${D}/etc/cyclone/ircd.conf

	# Generate sample motd file
	echo "Gentoo Linux - Cyclone ${PV}" > ${D}/etc/cyclone/ircd.motd

	# fix permissions
	chmod 755 ${D}/usr/bin/cyclone-ircd
	chmod 755 ${D}/etc/cyclone/chkconf ${D}/etc/cyclone/encrypt
	chmod 644 ${D}/etc/cyclone/example.conf ${D}/etc/cyclone/ircd.motd
	chmod 600 ${D}/etc/cyclone/ircd.conf ${D}/etc/cyclone/config

}


src_postinst()
{

	einfo Please read the documentation.  The default /etc/cyclone/ircd.conf
	einfo will need to be edited and file permissions changed so only root
	einfo and the account under which the ircd will run can read the plaintext
	einfo passwords stored in that file.
	einfo
	einfo Failure to modify the ircd.conf will result in cyclone-ircd
	einfo quietly refusing to run.  Read the documentation and config file.

}

