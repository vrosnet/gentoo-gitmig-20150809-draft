# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tracker/tracker-9999.ebuild,v 1.28 2010/11/14 17:43:22 eva Exp $

EAPI="2"
G2CONF_DEBUG="no"
PYTHON_DEPEND="2"

inherit autotools git gnome2 linux-info python

DESCRIPTION="A tagging metadata database, search tool and indexer"
HOMEPAGE="http://www.tracker-project.org/"
EGIT_REPO_URI="git://git.gnome.org/${PN}"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
# USE="doc" is managed by eclass.
IUSE="applet doc eds exif flac gif gnome-keyring gsf gstreamer gtk hal iptc +jpeg laptop mp3 nautilus networkmanager pdf playlist rss strigi test +tiff upnp +vorbis xine +xml xmp"

# TODO: rest -> flickr, qt vs. gdk
# vala is built with debug by default (see VALAFLAGS)
RDEPEND="
	>=app-i18n/enca-1.9
	>=dev-db/sqlite-3.7[threadsafe]
	>=dev-libs/dbus-glib-0.82-r1
	>=sys-apps/dbus-1.3.1
	>=dev-libs/glib-2.24:2
	|| (
		>=media-gfx/imagemagick-5.2.1[png,jpeg=]
		media-gfx/graphicsmagick[imagemagick,png,jpeg=] )
	>=media-libs/libpng-1.2
	>=x11-libs/pango-1
	sys-apps/util-linux

	applet? (
		gnome-base/gnome-panel
		>=x11-libs/gtk+-2.18:2 )
	eds? (
		>=mail-client/evolution-2.29.1
		>=gnome-extra/evolution-data-server-2.29.1 )
	exif? ( >=media-libs/libexif-0.6 )
	flac? ( >=media-libs/flac-1.2.1 )
	gif? ( media-libs/giflib )
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.26 )
	gsf? (
		app-text/odt2txt
		>=gnome-extra/libgsf-1.13 )
	upnp? ( >=media-libs/gupnp-dlna-0.3 )
	!upnp? (
		gstreamer? ( >=media-libs/gstreamer-0.10.12 )
		!gstreamer? ( !xine? ( || ( media-video/totem media-video/mplayer ) ) )
	)
	gtk? (
		>=dev-libs/libgee-0.3
		>=x11-libs/gtk+-2.18 )
	iptc? ( media-libs/libiptcdata )
	jpeg? ( virtual/jpeg:0 )
	laptop? (
		hal? ( >=sys-apps/hal-0.5 )
		!hal? ( >=sys-power/upower-0.9 ) )
	mp3? ( >=media-libs/taglib-1.6 )
	nautilus? (
		gnome-base/nautilus
		>=x11-libs/gtk+-2.18:2 )
	networkmanager? ( >=net-misc/networkmanager-0.8 )
	pdf? (
		>=x11-libs/cairo-1
		>=app-text/poppler-0.12.3-r3[cairo,utils]
		>=x11-libs/gtk+-2.12 )
	playlist? ( dev-libs/totem-pl-parser )
	rss? ( net-libs/libgrss )
	strigi? ( >=app-misc/strigi-0.7 )
	tiff? ( media-libs/tiff )
	vorbis? ( >=media-libs/libvorbis-0.22 )
	xine? ( >=media-libs/xine-lib-1 )
	xml? ( >=dev-libs/libxml2-2.6 )
	xmp? ( >=media-libs/exempi-2.1 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.14
	>=dev-util/pkgconfig-0.20
	dev-util/gtk-doc-am
	>=dev-util/gtk-doc-1.8
	applet? ( >=dev-lang/vala-0.11.1:0.12 )
	gtk? (
		>=dev-lang/vala-0.11.1:0.12
		>=dev-libs/libgee-0.3 )
	doc? (
		media-gfx/graphviz )
	test? (
		>=dev-libs/dbus-glib-0.82-r1
		>=sys-apps/dbus-1.3.1[X] )
"

function inotify_enabled() {
	if linux_config_exists; then
		if ! linux_chkconfig_present INOTIFY_USER; then
			ewarn "You should enable the INOTIFY support in your kernel."
			ewarn "Check the 'Inotify support for userland' under the 'File systems'"
			ewarn "option. It is marked as CONFIG_INOTIFY_USER in the config"
			die 'missing CONFIG_INOTIFY'
		fi
	else
		einfo "Could not check for INOTIFY support in your kernel."
	fi
}

pkg_setup() {
	linux-info_pkg_setup

	inotify_enabled

	if use upnp ; then
		G2CONF="${G2CONF} --enable-video-extractor=gupnp-dlna"
	elif use gstreamer ; then
		G2CONF="${G2CONF}
			--enable-video-extractor=gstreamer
			--enable-gstreamer-tagreadbin"
		# --enable-gstreamer-helix (real media)
	elif use xine ; then
		G2CONF="${G2CONF} --enable-video-extractor=xine"
	else
		G2CONF="${G2CONF} --enable-video-extractor=external"
	fi

	# hal and upower are used for AC power detection
	if use laptop; then
		G2CONF="${G2CONF} $(use_enable hal) $(use_enable !hal upower)"
	else
		G2CONF="${G2CONF} --disable-hal --disable-upower"
	fi

	if use applet || use gtk; then
		G2CONF="${G2CONF} VALAC=$(type -P valac-0.12)"
	fi

	# unicode-support: libunistring, libicu or glib ?
	G2CONF="${G2CONF}
		--enable-tracker-fts
		--with-enca
		--with-unicode-support=glib
		$(use_enable applet tracker-status-icon)
		$(use_enable applet tracker-search-bar)
		$(use_enable eds miner-evolution)
		$(use_enable exif libexif)
		$(use_enable flac libflac)
		$(use_enable gnome-keyring)
		$(use_enable gsf libgsf)
		$(use_enable gtk tracker-explorer)
		$(use_enable gtk tracker-preferences)
		$(use_enable gtk tracker-search-tool)
		$(use_enable iptc libiptcdata)
		$(use_enable jpeg libjpeg)
		$(use_enable mp3 taglib)
		$(use_enable nautilus nautilus-extension)
		$(use_enable networkmanager network-manager)
		$(use_enable pdf poppler)
		$(use_enable playlist)
		$(use_enable rss miner-rss)
		$(use_enable strigi libstreamanalyzer)
		$(use_enable test unit-tests)
		$(use_enable test functional-tests)
		$(use_enable tiff libtiff)
		$(use_enable vorbis libvorbis)
		$(use_enable xml libxml2)
		$(use_enable xmp exempi)"
		# FIXME: handle gdk vs qt for mp3 thumbnail extract
		# $(use_enable gtk gdkpixbuf)

	DOCS="AUTHORS ChangeLog NEWS README"

	python_set_active_version 2
}

src_unpack() {
	git_src_unpack
}

src_prepare() {
	gnome2_src_prepare

	# Fix functional tests scripts
	find "${S}" -name "*.pyc" -delete
	python_convert_shebangs 2 "${S}"/tests/tracker-writeback/*.py
	python_convert_shebangs 2 "${S}"/tests/functional-tests/*.py
	python_convert_shebangs 2 "${S}"/utils/data-generators/cc/{*.py,generate}
	python_convert_shebangs 2 "${S}"/utils/gtk-sparql/*.py
	python_convert_shebangs 2 "${S}"/examples/rss-reader/*.py

	gtkdocize || die "gtkdocize failed"
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_test() {
	export XDG_CONFIG_HOME="${T}"
	unset DBUS_SESSION_BUS_ADDRESS
	emake check || die "tests failed"
}

src_install() {
	gnome2_src_install
	# Tracker and none of the plugins it provides needs la files
	find "${D}" -name "*.la" -delete || die
}
