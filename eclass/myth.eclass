# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/myth.eclass,v 1.10 2005/04/18 07:37:39 eradicator Exp $
#
# Author: Daniel Ahlberg <aliz@gentoo.org>
#

inherit multilib versionator toolchain-funcs

ECLASS=myth
INHERITED="${INHERITED} ${ECLASS}"
IUSE="${IUSE} nls debug"

EXPORT_FUNCTIONS src_unpack src_compile src_install

MYTHPLUGINS="mythbrowser mythdvd mythgallery mythgame mythmusic mythnews mythphone mythvideo mythweather mythweb"

if version_is_at_least 0.18 && hasq ${PN} ${MYTHPLUGINS} ; then
	S="${WORKDIR}/mythplugins-${PV}"
fi

myth_src_unpack() {
	if version_is_at_least 0.18 && hasq ${PN} ${MYTHPLUGINS} ; then
		pkg_pro="mythplugins.pro"
	elif [ "${PN}" == "mythfrontend" ]; then
		pkg_pro="mythtv.pro"
	else
		pkg_pro="${PN}.pro"
	fi

	unpack ${A} ; cd ${S}

	sed -e "s:PREFIX = .*:PREFIX = /usr:" \
		-e "s:QMAKE_CXXFLAGS_RELEASE = .*:QMAKE_CXXFLAGS_RELEASE = ${CXXFLAGS}:" \
		-e "s:QMAKE_CFLAGS_RELEASE = .*:QMAKE_CFLAGS_RELEASE = ${CFLAGS}:" \
		-i 'settings.pro' || die "Initial setup failed"

	if ! use nls ; then
		sed -e "s:i18n::" \
		    -i ${pkg_pro} || die "Disable i18n failed"
	fi

        if use debug ; then
		FEATURES="${FEATURES} nostrip"
                sed -e 's:#CONFIG += debug:CONFIG += debug:' \
                    -e 's:CONFIG += release:#CONFIG += release:' \
                    -i 'settings.pro' || die "enable debug failed"
	fi

	setup_pro

	find ${S} -name '*.pro' -exec sed -i \
		-e "s:\$\${PREFIX}/lib/:\$\${PREFIX}/$(get_libdir)/:g" \
		-e "s:\$\${PREFIX}/lib$:\$\${PREFIX}/$(get_libdir):g" \
		{} \;
}

myth_src_compile() {
	export QMAKESPEC="linux-g++"

	if version_is_at_least 0.18 ; then
		if hasq ${PN} ${MYTHPLUGINS} ; then
			for x in ${MYTHPLUGINS} ; do
				if [[ ${PN} == ${x} ]] ; then
					myconf="${myconf} --enable-${x}"
				else
					myconf="${myconf} --disable-${x}"
				fi
			done
		fi 

		econf ${myconf}
	fi

	qmake -o "Makefile" "${S}/${pkg_pro}"
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" "${@}" || die
}

myth_src_install() {
	if version_is_at_least 0.18 && hasq ${PN} ${MYTHPLUGINS} ; then
		cd ${S}/${PN}
	fi

	einstall INSTALL_ROOT="${D}"
	for doc in AUTHORS COPYING FAQ UPGRADING ChangeLog README; do
		test -e "${doc}" && dodoc ${doc}
	done
}
