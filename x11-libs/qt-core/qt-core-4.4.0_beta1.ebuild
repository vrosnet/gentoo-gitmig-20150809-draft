# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-core/qt-core-4.4.0_beta1.ebuild,v 1.1 2008/03/05 23:07:18 ingmar Exp $

EAPI="1"
inherit qt4-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework."
HOMEPAGE="http://www.trolltech.com/"

LICENSE="|| ( QPL-1.0 GPL-3 GPL-2 )"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="doc glib +qt3support ssl"

RDEPEND="sys-libs/zlib
	glib? ( dev-libs/glib )
	ssl? ( dev-libs/openssl )
	!<=x11-libs/qt-4.4.0_alpha:${SLOT}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

QT4_TARGET_DIRECTORIES="
src/tools/moc
src/tools/rcc
src/tools/uic
src/corelib
src/xml
src/network
src/plugins/codecs"

pkg_setup() {
	qt4-build_pkg_setup

	if has_version x11-libs/qt-core; then
		# Check to see if they've changed the glib flag since the last time installing this package.

		if use glib && ! built_with_use x11-libs/qt-core glib && has_version x11-libs/qt-gui; then
			ewarn "You have changed the \"glib\" use flag since the last time you have emerged this package."
			ewarn "You should also re-emerge x11-libs/qt-gui in order for it to pick up this change."
		elif ! use glib && built_with_use x11-libs/qt-core glib && has_version x11-libs/qt-gui; then
			ewarn "You have changed the \"glib\" use flag since the last time you have emerged this package."
			ewarn "You should also re-emerge x11-libs/qt-gui in order for it to pick up this change."
		fi

		# Check to see if they've changed the qt3support flag since the last time installing this package.
		# If so, give a list of packages they need to uninstall first.

		if use qt3support && ! built_with_use x11-libs/qt-core qt3support; then
			local need_to_remove
			ewarn "You have changed the \"qt3support\" use flag since the last time you have emerged this package."
			for x in sql opengl gui qt3support; do
				local pkg="x11-libs/qt-${x}"
				if has_version $pkg; then
					need_to_remove="${need_to_remove} ${pkg}"
				fi
			done
			if [[ -n ${need_to_remove} ]]; then
				die "You must first uninstall these packages before continuing: \n\t\t${need_to_remove}"
			fi
		elif ! use qt3support && built_with_use x11-libs/qt-core qt3support; then
			local need_to_remove
			ewarn "You have changed the \"qt3support\" use flag since the last time you have emerged this package."
			for x in sql opengl gui qt3support; do
				local pkg="x11-libs/qt-${x}"
				if has_version $pkg; then
					need_to_remove="${need_to_remove} ${pkg}"
				fi
			done
			if [[ -n ${need_to_remove} ]]; then
				die "You must first uninstall these packages before continuing: \n\t\t${need_to_remove}"
			fi
		fi
	fi
}

src_compile() {
	unset QMAKESPEC
	local myconf

	myconf="${myconf}
		$(qt_use glib)
		$(qt_use ssl openssl)
		$(qt_use qt3support)"

	myconf="${myconf} -no-xkb -no-tablet -no-fontconfig -no-xrender -no-xrandr
		-no-xfixes -no-xcursor -no-xinerama -no-xshape -no-sm -no-opengl
		-no-nas-sound -no-qdbus -iconv -no-cups -no-nis -no-gif -no-libpng
		-no-libmng -no-libjpeg -system-zlib -no-webkit -no-phonon -no-xmlpatterns
		-no-freetype -no-libtiff  -no-accessibility -no-fontconfig -no-opengl"

	qt4-build_src_compile
}

src_install() {
	dobin "${S}"/bin/{qmake,moc,rcc,uic} || die "dobin failed."

	install_directories src/{corelib,xml,network,plugins/codecs}

	emake INSTALL_ROOT="${D}" install_mkspecs || die "emake install_mkspecs failed"

	if use doc; then
		emake INSTALL_ROOT="${D}" install_htmldocs || die "emake install_htmldocs failed."
	fi

	emake INSTALL_ROOT="${D}" install_translations || die "emake install_translations failed"

	fix_library_files

	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${libdirs}:/usr/${libdir}/qt4"
	done

	cat <<-EOF > "${T}/44qt4"
	LDPATH=${libdirs:1}
	EOF
	doenvd "${T}/44qt4"

	dodir /${QTDATADIR}/mkspecs/gentoo
	mv "${D}"/${QTDATADIR}/mkspecs/qconfig.pri "${D}${QTDATADIR}"/mkspecs/gentoo || \
		die "Failed to move qconfig.pri"

	sed -i -e '2a#include <Gentoo/gentoo-qconfig.h>\n' \
		"${D}${QTHEADERDIR}"/QtCore/qconfig.h \
		"${D}${QTHEADERDIR}"/Qt/qconfig.h || die "sed for qconfig.h failed."

	if use glib; then
		QCONFIG_DEFINE="$(use glib && echo QT_GLIB)
		$(use ssl && echo QT_OPENSSL)"
		install_qconfigs
	fi

	keepdir "${QTSYSCONFDIR}"
}
