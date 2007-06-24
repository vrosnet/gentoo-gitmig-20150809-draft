# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/at76c503a/at76c503a-0.14_beta1.ebuild,v 1.5 2007/06/24 09:52:12 genstef Exp $

inherit linux-mod eutils

MY_P=at76_usb-${PV/_}
DESCRIPTION="at76c503 is a Linux driver for the wlan USB adapter based on the Atmel at76c503 chip. It currently supports ad-hoc mode, infrastructure mode, and WEP. It supports adapters from Atmel, the Belkin F5D6050, Netgear MA101, and others."
HOMEPAGE="http://developer.berlios.de/projects/at76c503a/"
SRC_URI="http://download.berlios.de/at76c503a/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="net-wireless/atmel-firmware
		|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )
		>=net-wireless/wireless-tools-26-r1"
S=${WORKDIR}/${MY_P}

MODULE_NAMES="at76_usb(net:)"
BUILD_TARGETS="all"

CONFIG_CHECK="NET_RADIO"
NET_RADIO_ERROR="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_PATH=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/at76c503a-2.6.20-init_work.patch
	epatch ${FILESDIR}/at76c503a-2.6.20.patch
}

src_install() {
	linux-mod_src_install

	dodoc README CHANGELOG
}
