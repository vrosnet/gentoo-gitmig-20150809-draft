# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-nn/myspell-nn-20080310.ebuild,v 1.3 2009/06/22 13:43:01 jer Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"nn,NO,nn_NO,Norwegian nynorsk (Norway),nn_NO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"nn,NO,hyph_nn_NO,Norwegian nynorsk (Norway),hyph_nn_NO.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"nn,NO,th_nn_NO_v2,Norwegian nynorsk (Norway),th_nn_NO_v2.zip"
)

inherit myspell

DESCRIPTION="Norwegian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://spell-norwegian.alioth.debian.org/"

KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
