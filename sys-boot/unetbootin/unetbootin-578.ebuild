# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/unetbootin/unetbootin-578.ebuild,v 1.3 2012/07/26 15:20:46 johu Exp $

EAPI="4"

inherit qt4-r2

DESCRIPTION="Universal Netboot Installer creates Live USB systems for various OS
distributions."
HOMEPAGE="http://unetbootin.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-source-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

UNBI_LINGUAS="
	am ar ast be bg bn ca cs da de el eo es et eu fi fo fr gl he hr hu id it ja lt
	lv ml ms nan nb nl nn pl pt pt_BR ro ru sk sl sr sv sw tr uk ur vi zh_CN zh_TW
"

for lingua in ${UNBI_LINGUAS}; do
	IUSE="${IUSE} linguas_${lingua}"
done

S="${WORKDIR}"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
		 sys-fs/mtools
		 sys-boot/syslinux
		 app-arch/p7zip"

src_prepare() {
	# QA check in case linguas are added or removed
	enum() {
		echo ${#}
	}
	[[ $(enum ${UNBI_LINGUAS}) -eq $(( $(enum $(echo ${PN}_*.ts) ) -1 )) ]] \
		|| die "Numbers of recorded and actual linguas do not match"
	unset enum

	# Put all localisation file names on a single line
	sed -i ${PN}.pro \
		-e ':a;/unetbootin_[[:graph:]]*\.ts \\/{N;s|\\\n| |;s|    ||g;ba}' \
		|| die

	# Remove localisations
	local lingua
	for lingua in ${UNBI_LINGUAS}; do
		if ! use linguas_${lingua}; then
			sed -i ${PN}.pro -e "s| ${PN}_${lingua}.ts||g" || die
			rm ${PN}_${lingua}.ts || die
		fi
	done
}

src_configure() {
	lupdate ${PN}.pro || die
	lrelease ${PN}.pro || die
	eqmake4 ${PN}.pro || die
}

src_install() {
	dobin ${PN}

	insinto /usr/share/applications
	doins ${PN}.desktop

	for file in ${PN}*.png; do
		size="${file/${PN}_}"
		size="${size/.png}x${size/.png}"
		insinto /usr/share/icons/hicolor/${size}/apps
		newins ${file} ${PN}.png
	done

	local lingua
	for lingua in ${UNBI_LINGUAS}; do
		if use linguas_${lingua}; then
			insinto /usr/share/${PN}
			doins ${PN}_${lingua}.qm
		fi
	done
}
