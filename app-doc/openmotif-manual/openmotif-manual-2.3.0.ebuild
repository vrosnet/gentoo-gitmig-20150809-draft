# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/openmotif-manual/openmotif-manual-2.3.0.ebuild,v 1.6 2010/03/29 19:48:35 phajdan.jr Exp $

DESCRIPTION="Manual for Open Motif"
HOMEPAGE="http://www.motifzone.net/"
SRC_URI="ftp://ftp.ics.com/openmotif/openmotif-${PV}-manual.pdf.tgz"

LICENSE="OPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~sh ~sparc x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

S="${WORKDIR}"

src_install() {
	dodoc *.pdf || die
}
