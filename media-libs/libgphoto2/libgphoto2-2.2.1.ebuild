# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgphoto2/libgphoto2-2.2.1.ebuild,v 1.2 2006/07/07 11:20:59 flameeyes Exp $

inherit libtool eutils

DESCRIPTION="Library that implements support for numerous digital cameras"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls doc exif usb hal"

# needs >usbutils-0.11-r2 to avoid /usr/lib/libusb*
# conflicts with dev-libs/libusb
RDEPEND="usb? (
		>=dev-libs/libusb-0.1.8
		>=sys-apps/usbutils-0.11-r2
		kernel_linux? ( sys-apps/hotplug )
	)
	exif? ( >=media-libs/libexif-0.5.9 )
	hal? ( >=sys-apps/hal-0.5 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

# By default, drivers for all supported cards will be compiled.
# If you want to only compile for specific card(s), set CAMERAS
# environment to a comma-separated list (no spaces) of drivers that
# you want to build.
IUSE_CAMERAS="adc65 agfa-cl20 aox barbie canon casio clicksmart310
	digigr8 digita dimera directory enigma13 fuji gsmart300 hp215 iclick jamcam
	jd11 kodak konica largan lg_gsm mars minolta mustek panasonic pccam300
	pccam600 polaroid ptp2 ricoh samsung sierra sipix smal sonix sonydscf1
	sonydscf55 soundvision spca50x sq905 stv0674 stv0680 sx330z template
	toshiba"

RESTRICT="confcache"

pkg_setup() {
	if [[ -z "${CAMERAS}" ]] ; then
		ewarn "All camera drivers will be built since you did not specify"
		ewarn "via the CAMERAS variable what camera you use."
		einfo "libgphoto2 supports: all ${IUSE_CAMERAS}"
	fi
	echo

	enewgroup plugdev || die "Error creating plugdev group"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.1.2-norpm.patch
	epatch ${FILESDIR}/${PN}-2.2.0-includes.patch

	# make default group 'plugdev', not camera
	sed -e 's:=camera:=plugdev:' -i packaging/linux-hotplug/usbcam.group
}

src_compile() {
	local cameras
	local cam
	for cam in ${CAMERAS} ; do
		has ${cam} ${IUSE_CAMERAS} && cameras="${cameras},${cam}"
	done
	[[ -z "${cameras}" ]] \
		&& cameras="all" \
		|| cameras="${cameras:1}"
	einfo $cameras

	elibtoolize

	local myconf

	use exif \
		&& myconf="${myconf} --with-exif-prefix=/usr" \
		|| myconf="${myconf} --without-exif"

	econf \
		--with-drivers=${cameras} \
		$(use_enable nls) \
		$(use_enable doc docs) \
		${myconf} || die "econf failed"

	# or the documentation fails.
	emake || die "make failed"
}

src_install() {
	if use usb && use kernel_linux; then
		make DESTDIR=${D} \
			gphotodocdir=/usr/share/doc/${PF} \
			HTML_DIR=/usr/share/doc/${PF}/sgml \
			hotplugdocdir=/usr/share/doc/${PF}/linux-hotplug \
			install || die "install failed"
	else
		make DESTDIR=${D} \
			gphotodocdir=/usr/share/doc/${PF} \
			HTML_DIR=/usr/share/doc/${PF}/sgml \
			install || die "install failed"
	fi

	# manually move apidocs
	if use doc; then
		dodir /usr/share/doc/${PF}/api
		mv ${D}/usr/share/doc/libgphoto2/html/api/* ${D}/usr/share/doc/${PF}/api/
		mv ${D}/usr/share/doc/libgphoto2_port/html/api/* ${D}/usr/share/doc/${PF}/api/
	fi
	rm -rf ${D}/usr/share/doc/libgphoto2
	rm -rf ${D}/usr/share/doc/libgphoto2_port

	dodoc ChangeLog NEWS* README AUTHORS TESTERS MAINTAINERS HACKING CHANGES

	# install hotplug support
	if use usb && use kernel_linux; then
		insinto /etc/hotplug/usb
		newins ${S}/packaging/linux-hotplug/usbcam.group usbcam
		chmod +x ${D}/etc/hotplug/usb/usbcam
	fi

	if [[ -x ${D}/usr/$(get_libdir)/libgphoto2/print-camera-list ]]; then
		HOTPLUG_USERMAP="/etc/hotplug/usb/usbcam-gphoto2.usermap"
		HAL_FDI="/usr/share/hal/fdi/information/10freedesktop/10-camera-libgphoto2.fdi"

		if use usb && use kernel_linux; then
			einfo "Generating usbcam-gphoto2.usermap ..."
			echo "# !!! DO NOT EDIT THIS FILE !!! This file is automatically generated." > ${D}/${HOTPLUG_USERMAP}
			echo "# Put your custom entries in /etc/hotplug/usb/usbcam.usermap" >> ${D}/${HOTPLUG_USERMAP}
			${D}/usr/$(get_libdir)/libgphoto2/print-camera-list usb-user-map >> ${D}/${HOTPLUG_USERMAP}

		fi

		if use hal; then
			einfo "Generating HAL FDI files ..."
			${D}/usr/$(get_libdir)/libgphoto2/print-camera-list hal-fdi >> ${D}/${HAL_FDI}
		fi
	else
		eerror "Unable to find ${ROOT}/usr/$(get_libdir)/libgphoto2/print-camera-list"
		eerror "and therefore unable to generate hotplug usermap or HAL FDI files."
		eerror "You will have to manually generate it by running:"
		eerror " /usr/$(get_libdir)/libgphoto2/print-camera-list usb-usermap > ${HOTPLUG_USERMAP}"
		eerror " /usr/$(get_libdir)/libgphoto2/print-camera-list hal-fdi > ${HAL_FDI}"
	fi

}

pkg_postinst() {
	einfo "Don't forget to add yourself to the plugdev group "
	einfo "if you want to be able to access your camera."
}
