# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2x00/rt2x00-9999.ebuild,v 1.15 2006/10/05 15:16:00 uberlord Exp $

inherit linux-mod cvs

DESCRIPTION="Driver for the RaLink RT2x00 wireless chipsets"
HOMEPAGE="http://rt2x00.serialmonkey.com"
LICENSE="GPL-2"

ECVS_SERVER="rt2400.cvs.sourceforge.net:/cvsroot/rt2400"
ECVS_MODULE="source/rt2x00"
ECVS_LOCALNAME="${P}"

KEYWORDS="-* ~amd64 ~x86"
RDEPEND="net-wireless/wireless-tools"

IUSE_RT2X00_DEVICES="rt2400pci rt2500pci rt2500usb rt61pci rt73usb"
IUSE_RT2X00_EXTRA="rfkill"
IUSE="asm debug"

for x in ${IUSE_RT2X00_DEVICES} ${IUSE_RT2X00_EXTRA} ; do
	IUSE="${IUSE} ${x}"
done

pkg_setup() {
	CONFIG_CHECK="NET_RADIO"
	ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

	# dScape requires some crypto
	CONFIG_CHECK="${CONFIG_CHECK} CRYPTO_AES CRYPTO_MICHAEL_MIC CRYPTO_ARC4"
	ERROR_CRYPTO_AES="${P} requires support for AES Cryptography (CONFIG_CRYPTO_AES)."
	ERROR_CRYPTO_MICHAEL_MIC="${P} requires support for Michael MIC Cryptography (CONFIG_CRYPTO_MICHAEL_MIC)."
	ERROR_CRYPTO_ARC4="${P} requires support for ARC4 Cryptography (CONFIG_CRYPTO_ARC4)."

	if use rfkill ; then
		CONFIG_CHECK="${CONFIG_CHECK} INPUT"
	fi

	if use rt2400pci \
		|| use rt2500pci \
		|| use rt61pci ; then
		CONFIG_CHECK="${CONFIG_CHECK} PCI"
	fi

	if use rt2500usb || use rt73usb ; then
		CONFIG_CHECK="${CONFIG_CHECK} USB"
	fi

	if use rt61pci || use rt73usb ; then
		CONFIG_CHECK="${CONFIG_CHECK} FW_LOADER"
		ERROR_FW_LOADER="${P} requires support for Firmware module loading (CONFIG_FW_LOADER)."
	fi

	kernel_is lt 2 6 17 && die "${P} requires at least kernel 2.6.17"
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNDIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
	BUILD_TARGETS=" " # Target "module" is not supported, so we blank it
}

src_compile() {
	local m= asm="n" button="n" debug="n" full="y" yn= M=

	use asm && asm="y"
	use debug && debug="y"

	for m in ${IUSE_RT2X00_DEVICES} ; do
		if use "${m}" ; then
			full="n"
			break
		fi
	done

	if [[ ${full} == "n" ]] ; then
		use rfkill && button="y"
	else
		ewarn "No module specified in USE flags - building everything."
		button="y"
	fi

	# Generate the config file now
	echo "# Config file generated by portage" > config

	MODULE_NAMES="80211(rt2x00:) rc80211_simple(rt2x00:)"
	# RT61 and RT73 require CONFIG_CRC_ITU_T
	if [[ ${full} == "y" ]] || \
		use rt61pci || use rt73usb ; then
		echo "CONFIG_CRC_ITU_T=y" >> config
		MODULE_NAMES="${MODULE_NAMES} crc-itu-t(rt2x00:)"
	fi

	for m in d80211 ${IUSE_RT2X00_EXTRA} ${IUSE_RT2X00_DEVICES} ; do
		local yn="n" M=$(echo "${m}" | tr '[:lower:]' '[:upper:]')

		if [[ ${m} == "d80211" || ${full} == "y" ]] || use "${m}" ; then
			yn="y"
		fi
		echo "CONFIG_${M}=${yn}" >> config
		echo "CONFIG_${M}_ASM=${asm}" >> config
		echo "CONFIG_${M}_DEBUG=${debug}" >> config
		echo "CONFIG_${M}_BUTTON=${button}" >> config

		if [[ ${m} != "d80211" && ${yn} == "y" ]] ; then
			MODULE_NAMES="${MODULE_NAMES} ${m}(rt2x00:)"
		fi
	done

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc CHANGELOG COPYING README THANKS
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn
	ewarn "This is a CVS ebuild - please report any bugs to the rt2x00 forums"
	ewarn "http://rt2x00.serialmonkey.com/phpBB2/viewforum.php?f=5"
	ewarn
	ewarn "Any bugs reported to Gentoo will be marked INVALID"
	ewarn
}
