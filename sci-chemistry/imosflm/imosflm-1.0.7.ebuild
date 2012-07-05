# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/imosflm/imosflm-1.0.7.ebuild,v 1.1 2012/07/05 14:33:38 jlec Exp $

EAPI=4

inherit eutils multilib toolchain-funcs versionator

MY_PV="$(delete_all_version_separators ${PV})"

DESCRIPTION="A new GUI for the Mosflm crystallographic data processing tool"
HOMEPAGE="http://www.mrc-lmb.cam.ac.uk/harry/imosflm"
SRC_URI="${HOMEPAGE}/ver${MY_PV}/downloads/${P}.zip"

LICENSE="ccp4"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-lang/tcl
	>=dev-tcltk/itcl-3.3
	>=dev-tcltk/itk-3.3
	>=dev-tcltk/iwidgets-4
	>=dev-tcltk/tdom-0.8
	>=dev-tcltk/tkimg-1.3
	>=dev-tcltk/tktreectrl-2.1
	dev-tcltk/anigif
	dev-tcltk/combobox
	dev-tcltk/tablelist
	>=sci-chemistry/mosflm-7.0.4"
DEPEND="app-arch/unzip"

S="${WORKDIR}"/${PN}

src_install(){
	rm -rf lib/{*.so,anigif,combobox}

	insinto /usr/$(get_libdir)/${PN}
	doins -r "${S}"/{src,bitmaps,lib}
	fperms 775 /usr/$(get_libdir)/${PN}/src/imosflm

	cat >> "${T}"/23imosflm <<- EOF
	IMOSFLM_VERSION="${PV}"
	EOF

	doenvd "${T}"/23imosflm

	make_wrapper imosflm /usr/$(get_libdir)/${PN}/src/imosflm
}
