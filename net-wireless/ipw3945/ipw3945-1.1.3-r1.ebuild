# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw3945/ipw3945-1.1.3-r1.ebuild,v 1.1 2007/01/07 20:49:03 phreak Exp $

inherit linux-mod eutils

S=${WORKDIR}/${P/_pre/-pre}

IEEE80211_VERSION="1.2.15"
UCODE_VERSION="1.13"
DAEMON_VERSION="1.7.22"

DESCRIPTION="Driver for the Intel PRO/Wireless 3945ABG miniPCI express adapter"
HOMEPAGE="http://ipw3945.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_pre/-pre}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug"
DEPEND=">=virtual/linux-sources-2.6.19"
RDEPEND=">=net-wireless/ipw3945-ucode-${UCODE_VERSION}
		>=net-wireless/ipw3945d-${DAEMON_VERSION}"

BUILD_TARGETS="all"
MODULE_NAMES="ipw3945(net/wireless:)"
MODULESD_IPW3945_DOCS="README.ipw3945"

CONFIG_CHECK="NET_RADIO FW_LOADER IEEE80211 IEEE80211_CRYPT_CCMP IEEE80211_CRYPT_TKIP"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_FW_LOADER="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."
ERROR_IEEE80211="${P} requires support for Generic IEEE 802.11 Networking Stack (CONFIG_IEEE80211)."

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-Makefile.patch"

	if use debug ; then
		sed -i -e "s:^\(CONFIG_IPW3945_DEBUG\)=.*:\1=y:" "${S}"/Makefile || die
	fi
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	dodoc CHANGES ISSUES
}
