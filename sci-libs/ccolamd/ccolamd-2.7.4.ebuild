# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ccolamd/ccolamd-2.7.4.ebuild,v 1.3 2012/05/30 13:39:45 aballier Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

MY_PN=CCOLAMD

DESCRIPTION="Constrained column approximate minimum degree ordering algorithm"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/ccolamd/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

DEPEND="sci-libs/ufconfig"
RDEPEND="${DEPEND}"

DOCS=( README.txt Doc/ChangeLog )
PATCHES=( "${FILESDIR}"/${PN}-2.7.1-autotools.patch )

S="${WORKDIR}/${MY_PN}"
