#!/bin/bash

# Configs
.  /usr/share/manjaroiso/functions/messages
get_colors

# Variables
CURRENTDIR=$(pwd)
ARCHITECTURE=$(echo $1)
WORKDIR=$(echo $2)

echo " "
if [ -z "${ARCHITECTURE}" ] ; then
    ARCHITECTURE=$(pacman -Qi bash | grep "Architecture" | cut -d " " -f 5)
    msg  "Architecture not supplied, defaulting to host's architecture: ${ARCHITECTURE}"
fi

if [ "${ARCHITECTURE}" != "i686" ] && [ "${ARCHITECTURE}" != "x86_64" ] ; then
    ARCHITECTURE=$(pacman -Qi bash | grep "Architecture" | cut -d " " -f 5)
    msg  "Incorrect arquitecture, defaulting to host's architecture: ${ARCHITECTURE}"
fi


if [ -z "${WORKDIR}" ] ; then
    WORKDIR="work-${ARCHITECTURE}"
    msg  "Working dir not supplied, defaulting to ${WORKDIR}/"
fi

if [ ! -e overlay-pkgs.${ARCHITECTURE} ] ; then
    echo " "
    error "the config file overlay-pkgs.${ARCHITECTURE} is missing"
    echo " "
    exit 
fi

# Create TempDir and move into it
echo -e "$_r >$_W Updating overlay packages ... $_n"
mkdir -p ${CURRENTDIR}/${WORKDIR}/overlay-pkgs/opt/manjaro/pkgs &>/dev/null
echo -e -n "$_r >$_W Removing temporary directories ... $_n"
rm -rf temp &>/dev/null
echo -e "$_g done $_n"

_overlaypkgs=$(sed -e 's/\#.*//' -e 's/[ ^I]*$$//' -e '/^$$/ d' overlay-pkgs.${ARCHITECTURE})

# Get pkgs
echo -e -n "$_r >$_W Getting packages ... $_n"
for _p in ${_overlaypkgs[@]} ; do
    _rep=$(echo ${_p} | cut -d: -f1)
    _pkg=$(echo ${_p} | cut -d: -f2)
    rsync -avq --include "${_rep}/" --include "${ARCHITECTURE}/" --include "${_pkg}*" --exclude '*' manjaro.org::manjaro temp
    _repos=("${_repos[@]}" "${_rep}")
done
echo -e "$_g done $_n"

# Remove duplicated repos
IFS='
'
_repos=( $( printf "%s\n" "${_repos[@]}" | awk 'x[$0]++ == 0' ) )

# Remove old stuff
echo -e -n "$_r >$_W Removing old packages ... $_n"
rm -rf ${CURRENTDIR}/${WORKDIR}/overlay-pkgs/opt/manjaro/pkgs/*.pkg* &>/dev/null
echo -e "$_g done $_n"

# Move downloaded packages into overlay
echo -e -n "$_r >$_W Moving new packages into overlay ... $_n"
for _re in ${_repos[@]} ; do
    mv -v ${CURRENTDIR}/temp/${_re}/$ARCHITECTURE/*.pkg.tar.*z ${CURRENTDIR}/${WORKDIR}/overlay-pkgs/opt/manjaro/pkgs/ &>/dev/null
done
echo -e "$_g done $_n"
echo " "

# clean up
echo -e -n "$_r >$_W Cleaning up ... $_n"
rm -rf temp &>/dev/null
echo -e "$_g done $_n"
echo " "

# show packages
echo -e "$_r >$_W List of fetched packages: $_n"
echo " "
ls -1 ${CURRENTDIR}/${WORKDIR}/overlay-pkgs/opt/manjaro/pkgs/

echo " "
echo -e "$_g >$_W All done ! $_n"
echo " "

# Create /etc/nvidia-drv.conf
echo -e -n "$_r >$_W Create /etc/nvidia-drv.conf ... $_n"
mkdir -p ${CURRENTDIR}/${WORKDIR}/overlay-pkgs/etc
NVIDIA_DRV_VER=`ls -1 ${CURRENTDIR}/${WORKDIR}/overlay-pkgs/opt/manjaro/pkgs/ | grep nvidia-2 | cut -d- -f2 | cut -d. -f1`
echo "NVIDIA_DRV_VER=\"${NVIDIA_DRV_VER}\"" > ${CURRENTDIR}/${WORKDIR}/overlay-pkgs/etc/nvidia-drv.conf
echo -e "$_g done $_n"

