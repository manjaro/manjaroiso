#!/bin/bash

# switch to basic language
export LANG=C
export LC_MESSAGES=C

if [ ! -e options.conf ] ; then
    echo " "
    echo "the config file options.conf is missing, exiting..."
    echo " "
    exit
fi

if [ ! -e /usr/share/manjaroiso/functions/messages ] ; then
    echo " "
    echo "missing manjaroiso functions file, please run «sudo make install» inside manjaroiso/"
    echo " "
    exit
fi

.  /usr/share/manjaroiso/functions/messages
. options.conf
get_colors

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


if [ ! -e Packages ] ; then
    echo " "
    error "the config file Packages is missing, exiting..."
    echo " "
    exit
fi

if [ ! -e "pacman-${arch}.conf" ] ; then
    echo " "
    error "the config file pacman-${arch}.conf is missing, exiting..."
    echo " "
    exit
fi

set -e -u

pwd=`pwd`

if [ "${arch}" == "i686" ]; then
	packages=$(sed "s|#.*||g" Packages | sed "s| ||g" | sed "s|>dvd.*||g"  | sed "s|>blacklist.*||g" | sed "s|>x86_64.*||g" | sed "s|>i686||g" | sed ':a;N;$!ba;s/\n/ /g')
elif [ "${arch}" == "x86_64" ]; then
	packages=$(sed "s|#.*||g" Packages | sed "s| ||g" | sed "s|>dvd.*||g"  | sed "s|>blacklist.*||g" | sed "s|>i686.*||g" | sed "s|>x86_64||g" | sed ':a;N;$!ba;s/\n/ /g')
fi

if [ -e Packages-Xorg ] ; then
     if [ "${arch}" == "i686" ]; then
     	xorg_packages=$(sed "s|#.*||g" Packages-Xorg | sed "s| ||g" | sed "s|>dvd.*||g"  | sed "s|>blacklist.*||g" | sed "s|>cleanup.*||g" | sed "s|>x86_64.*||g" | sed "s|>i686||g" | sed ':a;N;$!ba;s/\n/ /g')
     elif [ "${arch}" == "x86_64" ]; then
     	xorg_packages=$(sed "s|#.*||g" Packages-Xorg | sed "s| ||g" | sed "s|>dvd.*||g"  | sed "s|>blacklist.*||g" | sed "s|>cleanup.*||g" | sed "s|>i686.*||g" | sed "s|>x86_64||g" | sed ':a;N;$!ba;s/\n/ /g')
     fi
     xorg_packages_cleanup=$(sed "s|#.*||g" Packages-Xorg | grep cleanup | sed "s|>cleanup||g")
fi

if [ -e Packages-Xfce ] ; then
     if [ "${arch}" == "i686" ]; then
     	xfce_packages=$(sed "s|#.*||g" Packages-Xfce | sed "s| ||g" | sed "s|>dvd.*||g"  | sed "s|>blacklist.*||g" | sed "s|>x86_64.*||g" | sed "s|>i686||g" | sed ':a;N;$!ba;s/\n/ /g')
     elif [ "${arch}" == "x86_64" ]; then
     	xfce_packages=$(sed "s|#.*||g" Packages-Xfce | sed "s| ||g" | sed "s|>dvd.*||g"  | sed "s|>blacklist.*||g" | sed "s|>i686.*||g" | sed "s|>x86_64||g" | sed ':a;N;$!ba;s/\n/ /g')
     fi
fi

# Base installation (root-image)
make_root_image() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
         echo -e -n "$_r >$_W Base installation (root-image) \n $_n"
         mkiso -v -C "pacman-${arch}.conf" -a "${arch}" -D "${install_dir}" -i "root-image" -p "${packages}" create "${work_dir}"
         pacman -Qr "${work_dir}/root-image" > "${work_dir}/root-image/root-image-pkgs.txt"
         cp ${work_dir}/root-image/etc/locale.gen.bak ${work_dir}/root-image/etc/locale.gen
         if [ -e ${work_dir}/root-image/etc/plymouth/plymouthd.conf ] ; then
            sed -i -e "s/^.*Theme=.*/Theme=$plymouth_theme/" ${work_dir}/root-image/etc/plymouth/plymouthd.conf
         fi
         : > ${work_dir}/build.${FUNCNAME}
         echo -e "$_g >$_W done $_n"
    fi
}

if [ -e Packages-Xorg ] ; then
     # Prepare pkgs-image
     make_pkgs_image() {
         if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
             echo -e -n "$_r >$_W Prepare pkgs-image \n $_n"
             mkdir -p ${work_dir}/pkgs-image/opt/manjaro/pkgs
             mkdir -p ${work_dir}/pkgs-image/var/lib/pacman
             cp -r ${work_dir}/root-image/var/lib/pacman/local ${work_dir}/pkgs-image/var/lib/pacman
             pacman -v --config "pacman-${arch}.conf" --arch "${arch}" --root "${work_dir}/pkgs-image" --cache ${work_dir}/pkgs-image/opt/manjaro/pkgs -Syw ${xorg_packages} --noconfirm
             if [ "${xorg_packages_cleanup}" != "" ]; then
                for xorg_clean in ${xorg_packages_cleanup};
                   do  rm ${work_dir}/pkgs-image/opt/manjaro/pkgs/${xorg_clean}
                   done
             fi
             rm -r ${work_dir}/pkgs-image/var
             repo-add ${work_dir}/pkgs-image/opt/manjaro/pkgs/manjaro-pkgs.db.tar.gz ${work_dir}/pkgs-image/opt/manjaro/pkgs/*pkg*z
             : > ${work_dir}/build.${FUNCNAME}
             echo -e "$_g >$_W done $_n"
         fi
     }
fi

if [ -e Packages-Xfce ] ; then
     # XFCE installation (xfce-image)
     make_xfce_image() {
         if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
              echo -e -n "$_r >$_W XFCE installation (xfce-image) \n $_n"
              mkdir -p ${work_dir}/xfce-image/var/lib/pacman
              cp -r ${work_dir}/root-image/var/lib/pacman/local ${work_dir}/xfce-image/var/lib/pacman
              mkiso -v -C "pacman-${arch}.conf" -a "${arch}" -D "${install_dir}" -i "xfce-image" -p "${xfce_packages}" create "${work_dir}"
              pacman -Qr "${work_dir}/xfce-image" > "${work_dir}/xfce-image/xfce-image-pkgs.txt"
              cp -Lr xfce-overlay/* ${work_dir}/xfce-image
              : > ${work_dir}/build.${FUNCNAME}
              echo -e "$_g >$_W done $_n"
         fi
     }
fi

# Prepare ${install_dir}/boot/
make_boot() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
	echo -e -n "$_r >$_W Prepare ${install_dir}/boot/ \n $_n"
	mkdir -p ${work_dir}/iso/${install_dir}/boot/${arch}
        cp ${work_dir}/root-image/boot/memtest86+/memtest.bin ${work_dir}/iso/${install_dir}/boot/${arch}/memtest
	cp ${work_dir}/root-image/boot/vmlinuz* ${work_dir}/iso/${install_dir}/boot/${arch}/manjaroiso
	mkinitcpio -c ./mkinitcpio.conf -b ${work_dir}/root-image -k $_kernver -g ${work_dir}/iso/${install_dir}/boot/${arch}/manjaro.img
	: > ${work_dir}/build.${FUNCNAME}
	echo -e "$_g >$_W done $_n"
    fi
}

# Prepare /${install_dir}/boot/syslinux
make_syslinux() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        echo -e -n "$_r >$_W Prepare ${install_dir}/boot/${arch}/syslinux \n $_n"
        local _src_syslinux=${work_dir}/root-image/usr/lib/syslinux
        local _dst_syslinux=${work_dir}/iso/${install_dir}/boot/${arch}/syslinux
        mkdir -p ${_dst_syslinux}
        for confile in `ls syslinux/*.cfg`;
           do  sed "s|%MISO_LABEL%|${iso_label}|g;
                s|%INSTALL_DIR%|${install_dir}|g;
                s|%ARCH%|${arch}|g" ${confile} > ${work_dir}/iso/${install_dir}/boot/${arch}/${confile};
           done
        cp syslinux/splash.png ${_dst_syslinux}
        cp ${_src_syslinux}/*.c32 ${_dst_syslinux}
        cp ${_src_syslinux}/*.com ${_dst_syslinux}
        cp ${_src_syslinux}/*.0 ${_dst_syslinux}
        cp ${_src_syslinux}/memdisk ${_dst_syslinux}
        mkdir -p ${_dst_syslinux}/hdt
        wget -O - http://pciids.sourceforge.net/v2.2/pci.ids | gzip -9 > ${_dst_syslinux}/hdt/pciids.gz
        cat ${work_dir}/root-image/lib/modules/*-MANJARO/modules.alias | gzip -9 > ${_dst_syslinux}/hdt/modalias.gz

        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Prepare /isolinux
make_isolinux() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        echo -e -n "$_r >$_W Prepare ${install_dir}/iso/isolinux \n $_n"
        mkdir -p ${work_dir}/iso/isolinux
        sed "s|%INSTALL_DIR%|${install_dir}|g;
             s|%ARCH%|${arch}|g" isolinux/isolinux.cfg > ${work_dir}/iso/isolinux/isolinux.cfg
        cp ${work_dir}/root-image/usr/lib/syslinux/isolinux.bin ${work_dir}/iso/isolinux/
        cp ${work_dir}/root-image/usr/lib/syslinux/isohdpfx.bin ${work_dir}/iso/isolinux/
        : > ${work_dir}/build.${FUNCNAME}
    fi
}

# Prepare overlay-image
make_overlay() {
    if [[ ! -e ${work_dir}/build.${FUNCNAME} ]]; then
        echo -e -n "$_r >$_W Prepare overlay-image \n $_n"
        mkdir -p ${work_dir}/overlay/etc/pacman.d
        cp -Lrd overlay/* ${work_dir}/overlay
        wget -O ${work_dir}/overlay/etc/pacman.d/mirrorlist http://git.manjaro.org/packages-sources/basis/blobs/raw/master/pacman-mirrorlist/mirrorlist
        sed -i "s/#Server/Server/g" ${work_dir}/overlay/etc/pacman.d/mirrorlist
        #chmod -R 755 ${work_dir}/overlay/home
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

# install basic
make_root_image
# install xorg-drivers
if [ -e Packages-Xorg ] ; then
    make_pkgs_image
fi
# install DE(s)
if [ -e Packages-Xfce ] ; then
    make_xfce_image
fi
# install common
make_boot
make_syslinux
make_isolinux
make_overlay
make_isomounts
make_iso
