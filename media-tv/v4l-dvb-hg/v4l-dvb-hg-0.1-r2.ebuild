# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/v4l-dvb-hg/v4l-dvb-hg-0.1-r2.ebuild,v 1.6 2006/11/20 09:19:12 zzam Exp $


: ${EHG_REPO_URI:=${V4l_DVB_HG_REPO_URI:-http://linuxtv.org/hg/v4l-dvb}}

inherit linux-mod eutils toolchain-funcs mercurial

DESCRIPTION="live development version of v4l&dvb-driver for Kernel 2.6"
SRC_URI=""
HOMEPAGE="http://www.linuxtv.org"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND=""

S=${WORKDIR}/${EHG_REPO_URI##*/}/v4l

pkg_setup()
{
	linux-mod_pkg_setup
	if [[ "${KV_MAJOR}.${KV_MINOR}" != "2.6"  ]]; then
		ewarn "other Kernel than 2.6.x are not supported at the moment."
		die "unsupported Kernel (not 2.6.x)"
	fi
	MODULE_NAMES="dvb(dvb:${S})"
	BUILD_PARAMS="KDIR=${KERNEL_DIR}"
	BUILD_TARGETS="default"

	if [[ -d ${ROOT}/lib/modules/${KV_FULL}/v4l-dvb-cvs ]]; then
		ewarn "There are stale dvb-modules from the ebuild v4l-dvb-cvs."
		ewarn "Please remove the directory /lib/modules/${KV_FULL}/v4l-dvb-cvs"
		ewarn "with all its files and subdirectories and then restart emerge."
		ewarn
		ewarn "# rm -rf /lib/modules/${KV_FULL}/v4l-dvb-cvs"
		die "Stale dvb-modules found, restart merge after removing them."
	fi
}

src_unpack() {
	# download and copy files
	mercurial_src_unpack

	cd ${S}
	epatch ${FILESDIR}/${PN}-fix-makefile-recursion.diff

	export ARCH=$(tc-arch-kernel)
	make allmodconfig ${BUILD_PARAMS}
	export ARCH=$(tc-arch)

	# apply local patches
	if test -n "${DVB_LOCAL_PATCHES}";
	then
		ewarn "Applying local patches:"
		for LOCALPATCH in ${DVB_LOCAL_PATCHES};
		do
			if test -f "${LOCALPATCH}";
			then
				if grep -q linux/drivers ${LOCALPATCH}; then
					cd ${S}/..
				else
					cd ${S}
				fi
				epatch ${LOCALPATCH}
			fi
		done
	else
		einfo "No additional local patches to use"
	fi
	echo

	einfo "Removing autoload-entry from stradis-driver."
	sed -i ${S}/../linux/drivers/media/video/stradis.c -e '/MODULE_DEVICE_TABLE/d'

	cd ${S}
	sed -e 's#/lib/modules/$(KERNELRELEASE)/kernel/drivers/media#$(DESTDIR)/$(DEST)#' \
		-e '/-install::/s:rminstall::' \
		-i Makefile

	einfo "Removing depmod-calls"
	sed -e '/depmod/d' -i Makefile* scripts/make_makefile.pl scripts/make_kconfig.pl \
	|| die "Failed removing depmod call from Makefile"

	grep depmod * && die "Not removed depmod found."
}

src_install() {
	# install the modules
	make install DESTDIR="${D}" \
		DEST="/lib/modules/${KV_FULL}/v4l-dvb" \
	|| die "make install failed"

	cd ${S}/..
	dodoc linux/Documentation/dvb/*.txt
	dosbin linux/Documentation/dvb/get_dvb_firmware
}

pkg_postinst() {
	einfo
	einfo "Firmware-files can be found in media-tv/linuxtv-dvb-firmware"
	einfo

	linux-mod_pkg_postinst
	einfo
	einfo
	einfo "if you want to use the IR-port or networking"
	einfo "with the dvb-card you need to"
	einfo "install linuxtv-dvb-apps"
	einfo
}
