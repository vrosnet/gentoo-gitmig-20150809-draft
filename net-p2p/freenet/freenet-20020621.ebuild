# Copyright (c) 2002, Per Wigren <wigren@home.se>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/freenet/freenet-20020621.ebuild,v 1.7 2002/10/24 23:23:45 blizzy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Freenet server"
SRC_URI="http://freenetproject.org/snapshots/${P}.tgz"
HOMEPAGE="http://freenetproject.org"
DEPEND="virtual/jdk"
SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL"

src_compile () {
    cd ${S}
    # Set storeSize to a 3rd of the available space on /var
    VARSZ=$(df -m /var|tail -n1|awk '{print $4}')
    if [ $VARSZ -gt 2048 ]; then
        STORSZ=1073741824
    else
        let STORSZ=($VARSZ/3)*1024*1024
    fi

    # Create a default freenet.conf
    (  echo ipAddress=$(hostname)
       echo listenPort=$(let PORT=($RANDOM%30000)+9000; echo $PORT)
       echo seedFile=/var/freenet/seednodes.ref
       echo storeFile=/var/freenet/store
       echo storeSize=$STORSZ
       echo nodeFile=/var/freenet/node
       echo diagnosticsPath=/var/freenet/stats
       echo logLevel=normal
       echo logFile=/var/log/freenet.log
       echo maxHopsToLive=25
       echo fproxy.class=freenet.client.http.FproxyServlet
       echo fproxy.port=8888
       echo fproxy.insertHtl=25
       echo fproxy.requestHtl=25
       echo fproxy.params.filter=false
       echo nodestatus.class=freenet.client.http.NodeStatusServlet
       echo nodestatus.port=8889
       echo logInboundContacts=true
       echo logOutboundContacts=true
       echo logInboundRequests=true
    ) >freenet.conf
}

src_install () {

	dodir /var/freenet/stats

	insinto /usr/lib/freenet 
	doins lib/freenet.jar lib/freenet-ext.jar

	insinto /etc
	doins freenet.conf
	
	exeinto /etc/init.d 
	doexe ${FILESDIR}/freenet

	dosbin ${FILESDIR}/update-freenet
}

pkg_postinstall () {
	einfo "freenet is built every night, but we cannot guarantee the"
	einfo "integrity of the files with our current Portage version."
	einfo "Use \"update-freenet\" to update your version of freenet."
}

pkg_postrm () {
	einfo "Note that if updates freenat after emerge, the /var/freenet"
	einfo "dir don't is removed in unemerge. Please do it manually"
	einfo "(rm -rf /var/freenet) if you want it."
}
