# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetfilter/knetfilter-3.1.0.ebuild,v 1.2 2003/01/30 20:03:54 danarmak Exp $
inherit kde-base

need-kde 3

LICENSE="GPL-2"
DESCRIPTION="Manage Iptables firewalls with this KDE app"
SRC_URI="http://expansa.sns.it:8080/knetfilter/${P}.tar.gz"
HOMEPAGE="http://expansa.sns.it:8080/knetfilter/"
KEYWORDS="~x86"

newdepend ">=sys-apps/iptables-1.2.5"

src_unpack() {
    kde_src_unpack
    cd $S
    make distclean
    rm src/knat.moc
    kde_sandbox_patch ${S}/src ${S}/src/scripts
}

