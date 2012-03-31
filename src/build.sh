#!/bin/bash

if [ ! -e options.conf ] ; then
    echo " "
    echo "the config file options.conf is missing, exiting..."
    echo " "
    exit
fi

if [ ! -e /usr/share/manjaroiso/functions/colors ] || [ ! -e /usr/share/manjaroiso/functions/messages ] ; then
    echo " "
    echo "missing manjaro-live functions file, please run «sudo make install» inside manjaroiso/"
    echo " "
    exit
fi

source /usr/share/manjaroiso/functions/colors
.  /usr/share/manjaroiso/functions/messages
. options.conf

# do UID checking here so someone can at least get usage instructions
if [ "$EUID" != "0" ]; then
    echo "error: This script must be run as root."
    exit 1
fi

banner

if [ -z "${arch}" ] ; then
    arch=$(pacman -Qi bash | grep "Architecture" | cut -d " " -f 5)
    echo " "
    msg  "architecture not supplied, defaulting to host's architecture: ${arch}"
fi


if [ ! -e overlay-pkgs.${arch} ] ; then
    echo " "
    error "the config file overlay-pkgs.${arch} is missing, exiting..."
    echo " "
    exit
fi

set -e -u

pwd=`pwd`
packages=`sed -e 's/\#.*//' -e 's/[ ^I]*$$//' -e '/^$$/ d' packages.${arch}`
_kernver=`pacman -Q linux | cut -c7-9 | sed 's/linux //g'`-MANJARO

export LANG=C
export LC_MESSAGES=C

# Base installation (root-image)
make_root_image() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
         echo -e -n "$_r >$_W Base installation (root-image) \n $_n"
         mkiso -v -C pacman.conf -a "${arch}" -D "${install_dir}" -p "${packages}" create "${work_dir}"
         pacman -Qr "${work_dir}/root-image" > "${work_dir}/root-image/root-image-pkgs.txt"
         cp ${work_dir}/root-image/etc/locale.gen.bak ${work_dir}/root-image/etc/locale.gen
         : > ${work_dir}/build.${FUNCNAME}
         echo -e "$_g >$_W done $_n"
    fi
}

# Prepare ${install_dir}/boot/
make_boot() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
	echo -e -n "$_r >$_W Prepare ${install_dir}/boot/ \n $_n"
	mkdir -p ${work_dir}/iso/${install_dir}/boot/${arch}
	cp ${work_dir}/root-image/boot/vmlinuz-linux ${work_dir}/iso/${install_dir}/boot/${arch}/manjaroiso
	cp -Lr boot-files/isolinux ${work_dir}/iso/
	cp ${work_dir}/root-image/usr/lib/syslinux/isolinux.bin ${work_dir}/iso/isolinux/
	cp /lib/initcpio/hooks/m* ${work_dir}/root-image/lib/initcpio/hooks
	mkinitcpio -c ./mkinitcpio.conf -b ${work_dir}/root-image -k $_kernver -g ${work_dir}/iso/${install_dir}/boot/${arch}/manjaro.img
	rm ${work_dir}/root-image/lib/initcpio/hooks/m*
	: > ${work_dir}/build.${FUNCNAME}
	echo -e "$_g >$_W done $_n"
    fi
}

# Prepare overlay-image
make_overlay() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        echo -e -n "$_r >$_W Prepare overlay-image \n $_n"
        mkdir -p ${work_dir}/overlay/etc/pacman.d
        cp -Lr overlay ${work_dir}/
        wget -O ${work_dir}/overlay/etc/pacman.d/mirrorlist https://git.manjaro.org/packages-sources/core-stable/blobs/raw/master/pacman-mirrorlist/mirrorlist
        sed -i "s/#Server/Server/g" ${work_dir}/overlay/etc/pacman.d/mirrorlist
        sed -i -e "s/@carch@/${arch}/g" ${work_dir}/overlay/etc/pacman.d/mirrorlist
        cp ${work_dir}/overlay/etc/locale.gen ${work_dir}/root-image/etc
        chroot "${work_dir}/root-image" locale-gen
        cp ${work_dir}/root-image/etc/locale.gen.bak ${work_dir}/root-image/etc/locale.gen
        mkdir -p ${work_dir}/overlay/usr/lib/locale/
        mv ${work_dir}/root-image/usr/lib/locale/locale-archive ${work_dir}/overlay/usr/lib/locale/
        chmod -R 755 ${work_dir}/overlay/home
        : > ${work_dir}/build.${FUNCNAME}
        echo -e "$_g >$_W done $_n"
    fi
}

# Prepare overlay-pkgs-image
make_overlay_pkgs() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        echo -e -n "$_r >$_W Prepare overlay-pkgs-image \n $_n"
        overlay-pkgs ${arch} ${work_dir}
        : > ${work_dir}/build.${FUNCNAME}
        echo -e "$_g >$_W done $_n"
    fi
}

# Process isomounts
make_isomounts() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        echo -e -n "$_r >$_W Process isomounts \n $_n"
        sed "s|@ARCH@|${arch}|g" isomounts > ${work_dir}/iso/${install_dir}/isomounts
        : > ${work_dir}/build.${FUNCNAME}
        echo -e "$_g >$_W done $_n"
    fi
}

# Build ISO
make_iso() {
        echo -e -n "$_r >$_W Build ISO \n $_n"
        mkiso "${verbose}" "${overwrite}" -D "${install_dir}" -L "${iso_label}" -a "${arch}" -c "${compression}" "${high_compression}" iso "${work_dir}" "${name}-${version}-${arch}.iso"
        echo -e "$_g >$_W done $_n"
}

if [[ $verbose == "y" ]]; then
    verbose="-v"
else
    verbose=""
fi

if [[ $overwrite == "y" ]]; then
    overwrite="-f"
else
    overwrite=""
fi

if [[ $high_compression == "y" ]]; then
    high_compression="-x"
else
    high_compression=""
fi

make_root_image
make_boot
make_overlay
make_overlay_pkgs
make_isomounts
make_iso
