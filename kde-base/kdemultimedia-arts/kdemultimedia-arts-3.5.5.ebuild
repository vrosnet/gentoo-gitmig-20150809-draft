# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-arts/kdemultimedia-arts-3.5.5.ebuild,v 1.10 2007/08/09 19:47:43 philantrop Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=arts
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="aRts pipeline builder and other tools"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
KMEXTRACTONLY="mpeglib_artsplug/configure.in.in" # needed because the artsc-config call is here
KMEXTRA="doc/artsbuilder"
