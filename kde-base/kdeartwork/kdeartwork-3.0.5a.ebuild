# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.0.5a.ebuild,v 1.1 2002/12/21 13:48:19 hannes Exp $
inherit kde-dist 

DESCRIPTION="KDE $PV - artwork"

KEYWORDS="x86 ~ppc ~alpha"

newdepend "opengl? ( virtual/opengl ) ~kde-base/kdebase-${PV}"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl" 

src_unpack() {

    base_src_unpack

    cd ${S}
    # added to fix GL problems within xscreensavers
    patch -p1 < ${FILESDIR}/kdeartwork-screensaver.patch

}

# kepp this here just in case, seems fixed though
src_install() {
	dodir ${PREFIX}/share/apps/kthememgr/Themes
	kde_src_install all
}
