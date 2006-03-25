# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdrip/dvdrip-0.97.6.ebuild,v 1.8 2006/03/25 04:11:06 morfic Exp $


inherit perl-module eutils flag-o-matic

MY_P=${P/dvdr/Video-DVDR}
MY_URL="dist/pre"

S=${WORKDIR}/${MY_P}
DESCRIPTION="Dvd::rip is a graphical frontend for transcode"
HOMEPAGE="http://www.exit1.org/dvdrip/"
SRC_URI="http://www.exit1.org/${PN}/${MY_URL}/${MY_P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
# ~ppc needs subtitleripper
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="cdr gnome xvid rar mplayer ogg fping subtitles"

DEPEND="gnome? ( gnome-extra/gtkhtml )
	cdr? ( >=media-video/vcdimager-0.7.19
		>=app-cdr/cdrdao-1.1.7
		virtual/cdrtools
		>=media-video/mjpegtools-1.6.0 )
	xvid? ( media-video/xvid4conf )
	rar? ( app-arch/rar )
	mplayer? ( media-video/mplayer )
	>=media-video/transcode-0.6.14
	>=media-gfx/imagemagick-5.5.3
	dev-perl/gtk2-perl
	>=dev-perl/gtk2-ex-formfactory-0.59
	>=dev-perl/Event-RPC-0.84
	virtual/perl-Storable
	dev-perl/Event"
RDEPEND="${DEPEND}
	fping? ( >=net-analyzer/fping-2.3 )
	ogg? ( >=media-sound/ogmtools-1.000 )
	subtitles? ( media-video/subtitleripper )
	>=media-video/lsdvd-0.15
	virtual/eject
	dev-perl/libintl-perl"

pkg_setup() {
	built_with_use media-video/transcode dvdread \
		|| die	"transcode needs dvdread support builtin." \
				"Please re-emerge transcode with the dvdread USE flag."
	built_with_use media-video/transcode extrafilters \
		&& die  "Please remerge transcode with -extrafilters in USE=, " \
				"you have filters installed not compatible with dvdrip."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	filter-flags "-ftracer"
	epatch ${FILESDIR}/${P}-fix_nptl_workaround.patch
	sed -i -e 's:cc :$(CC) :' src/Makefile || die "sed failed"
}

src_install() {
	newicon lib/Video/DVDRip/icon.xpm dvdrip.xpm
	make_desktop_entry dvdrip dvd::rip dvdrip.xpm Video

	perl-module_src_install
	use fping || rm ${D}/usr/bin/dvdrip-master
}
