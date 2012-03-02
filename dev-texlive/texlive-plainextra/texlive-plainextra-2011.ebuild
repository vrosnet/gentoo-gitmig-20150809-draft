# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-plainextra/texlive-plainextra-2011.ebuild,v 1.6 2012/03/02 20:14:56 ranger Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="figflow fixpdfmag font-change fontch graphics-pln hyplain js-misc mkpattern newsletr pitex placeins-plain plnfss present resumemac timetable treetex varisize collection-plainextra
"
TEXLIVE_MODULE_DOC_CONTENTS="figflow.doc font-change.doc fontch.doc graphics-pln.doc hyplain.doc js-misc.doc mkpattern.doc newsletr.doc pitex.doc plnfss.doc present.doc resumemac.doc treetex.doc varisize.doc "
TEXLIVE_MODULE_SRC_CONTENTS="graphics-pln.source "
inherit  texlive-module
DESCRIPTION="TeXLive Plain TeX supplementary packages"

LICENSE="GPL-2 as-is LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
!<dev-texlive/texlive-langvietnamese-2009
"
RDEPEND="${DEPEND} "
