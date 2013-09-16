#!/bin/bash

# get current path
reldir=`dirname $0`
cd $reldir
DIR=`pwd`

# get OS (linux / Mac OS x)
OUT_TARGET_HOST=`uname -a | grep Darwin`

# Colorize and add text parameters
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
cya=$(tput setaf 6)             #  cyan
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldylw=${txtbld}$(tput setaf 3) #  yellow
bldblu=${txtbld}$(tput setaf 4) #  blue
bldppl=${txtbld}$(tput setaf 5) #  purple
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)             # Reset

THREADS="16"
DEVICE="$1"

# get current version
MAJOR=$(cat $DIR/vendor/pe/config/pe.mk | grep 'PE_VERSION = *' | sed  's/PE_VERSION = //g')
VERSION=$MAJOR

# get time of startup
if [ -z "$OUT_TARGET_HOST" ]
then
   res1=$(date +%s.%N)
else
   res1=$(gdate +%s.%N)
fi

# we don't allow scrollback buffer
echo -e '\0033\0143'
clear

echo -e "${cya}Building Project - Project-Equilibrium${txtrst}";

# PE device dependencies
echo -e ""
echo -e "${bldblu}Looking for dependencies ${txtrst}${cya}"
./vendor/pe/tools/getdependencies.py $DEVICE
echo -e "${txtrst}"

# decide what command to execute
case "$EXTRAS" in
   threads)
       echo -e "${bldblu}Please write desired threads followed by [ENTER] ${txtrst}"
       read threads
       THREADS=$threads;;
   clean)
       echo -e ""
       echo -e "${bldblu}Cleaning intermediates and output files ${txtrst}"
       make clean > /dev/null;;
esac

# download prebuilt files
echo -e ""
echo -e "${bldblu}Downloading prebuilts ${txtrst}"
cd vendor/cm
./get-prebuilts
cd /../..
echo -e ""

# sync with latest sources
echo -e ""
if [ "$SYNC" == "true" ]
then
   echo -e "${bldblu}Fetching latest sources ${txtrst}"
   repo sync -j"$THREADS"
   echo -e ""
fi

rm -f out/target/product/*/obj/KERNEL_OBJ/.version

# setup environment
echo -e "${bldblu}Setting up environment ${txtrst}"
. build/envsetup.sh

# lunch device
echo -e ""
echo -e "${bldblu}Lunching device ${txtrst}"
lunch "pe_$DEVICE-userdebug";

echo -e ""
echo -e "${bldblu}Starting compilation ${txtrst}"

# start compilation
mka bacon
echo -e ""

# squisher
./vendor/pe/tools/squisher

# cleanup unused built
rm -f out/target/product/*/cm-*.*
rm -f out/target/product/*/pe_*-ota-eng.*.zip

# finished? get elapsed time
if [ -z "$OUT_TARGET_HOST" ]
then
   res2=$(date +%s.%N)
else
   res2=$(gdate +%s.%N)
fi

echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"

