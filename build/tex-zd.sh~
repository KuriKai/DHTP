#!/bin/bash
#this file is released into the public domain, do what you will with it, i'm not responsible for what hapens with you using it#

#get date
export mydate=`date +%y%m%d`

#build directory base
SDIR="$( cd "$( dirname "$0" )" && pwd )" #Get the scripts directory
cd "$(echo $SDIR)" #cd to the scripts dir
cd ../ #go up one level to where the DHTP base folder is
BDIR=$(pwd) #set the base directory to the current directory
echo $BDIR #print base dir (Example = /media/lvm/Art/DHTP)

#remove the old zdoom build setup folder if it exists
if [ -d "$BDIR/zdoom" ]
then
	echo "found, removing the old risen3d build folder"
    rm -r $BDIR/zdoom
else
	echo "not found"
fi
echo "looking for $BDIR/built"
if [ ! -d "$BDIR/built" ] #if the built folder does not exist, create it as this is where the compiled pack is placed
then
    mkdir $BDIR/built
else
	echo "built folder already exists, doing nothing"
fi
echo ---------starting to create the dhtp for the zdoom engine and compatible engines---------
mkdir $BDIR/zdoom
echo ---------copying textures---------
cp -r $BDIR/textures $BDIR/zdoom/hires
cp $BDIR/zdoom/hires/doom1/* $BDIR/zdoom/hires
rm -r $BDIR/zdoom/hires/doom1
echo copying flats
cp -r $BDIR/flats/* $BDIR/zdoom/hires
echo ---------copying readmes---------
cp $BDIR/README_FLATS.txt $BDIR/zdoom/README_FLATS.txt
cp $BDIR/README_WALLS.txt $BDIR/zdoom/README_WALLS.txt
cp $BDIR/README_WALLS_DOOM1.txt $BDIR/zdoom/README_WALLS_DOOM1.txt
cp $BDIR/README_WALLS_DOOM2.txt $BDIR/zdoom/README_WALLS_DOOM2.txt
cp $BDIR/README_WALLS_PLUTONIA.txt $BDIR/zdoom/README_WALLS_PLUTONIA.txt
cp $BDIR/README_WALLS_TNT.txt $BDIR/zdoom/README_WALLS_TNT.txt
rm -r $BDIR/zdoom/hires/doom1
cd $BDIR/zdoom
echo ---------ziping pack---------
zip -r zdoom . -i \*.png \*.txt
echo renaming and adding date of compile
mv zdoom.zip ../built/zdoom-dhtp-20$mydate.pk3
cd ..
echo ---------Complete---------
