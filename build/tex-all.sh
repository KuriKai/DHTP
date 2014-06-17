#!/bin/bash
#this file is released into the public domain, do what you will with it, i'm not responsible for what hapens with you using it#

# Doom Hires Texture Pack builder
#build directory base
SDIR="$( cd "$( dirname "$0" )" && pwd )" #Get the scripts directory
cd "$(echo $SDIR)" #cd to the scripts dir
cd ../ #go up one level to where the DHTP base folder is
BDIR=$(pwd) #set the base directory to the current directory
echo $BDIR #print base dir (Example = /media/lvm/Art/DHTP)
if [! -d "$BDIR/built" ] #if the built folder does not exist, create it
then
    mkdir $BDIR/built
else
	echo "built folder already exists"
fi
 
echo ----Starting Doomsday pack----
source $SDIR/tex-deng.sh
echo ----starting Risen3d pack----
source $SDIR/tex-r3d.sh
echo ----starting zdoom pack----
source $SDIR/tex-zd.sh
