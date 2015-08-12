#!/bin/bash

datestamp=$(date +%Y%m%d)
script_path=$(cd "$(dirname "$0")" ; pwd -P)
base_path=$(dirname "$script_path")

echo "looking for $base_path/Info"
if [ -f "$base_path/Info" ]; then
	echo "$base_path/Info found, removing old Info file"
  rm "$base_path/Info"
else
	"$base_path/Info not found"
fi

#if the built folder does not exist, create it as this is where the compiled pack is placed
echo "looking for $base_path/built"
if [ ! -d "$base_path/built" ]; then
    mkdir $base_path/built
else
	echo "built folder already exists, doing nothing"
fi

echo "Creating the Info file"
cat > Info << EOF
name: DOOM High-resolution Texture Project

language english (
  version: $datestamp
  summary: This pack replaces doom's textures, with high resolution versions.
  contact: eunbolt@gmail.com
  author: see the README files contained in the pk3
  license: Do not redistribute

  readme: Overview is defined in the metadata.
)

# Require a certain game component:
component: game-jdoom

EOF

#remove the old Doomsday build setup folder if it exists

echo "looking for $base_path/doomsday"
if [ -d "$base_path/doomsday" ]; then
	echo "found, removing the old doomsday build folder"
  rm -r $base_path/doomsday
else
	echo "not found"
fi

echo ---------starting to create the dhtp for the doomsday engine and compatible engines---------
echo "Creating the doomsday folder"
mkdir $base_path/doomsday

echo ---------copying textures---------
cp -r $base_path/textures $base_path/doomsday/textures
cp $base_path/doomsday/textures/doom1/* $base_path/doomsday/textures
rm -r $base_path/doomsday/textures/doom1

echo ---------copying flats---------
cp -r $base_path/flats $base_path/doomsday/flats

echo ---------copying readmes---------
for filename in "$base_path/docs/*"; do
  cat "$base_path/README.md" "$filename" "$base_path/docs/OUTRO.txt" > "$base_path/doomsday/README_$filename"
done

cp $base_path/definitions/dhtp-doom1lights.ded $base_path/doomsday/dhtp-doom1lights.ded
cp $base_path/definitions/dhtp-doom2lights.ded $base_path/doomsday/dhtp-doom2lights.ded
cp $base_path/definitions/dhtp-doom2lights.ded $base_path/doomsday/dhtp-doom2-plutlights.ded
cp $base_path/definitions/dhtp-doom2lights.ded $base_path/doomsday/dhtp-doom2tntlights.ded
cp $base_path/Info $base_path/doomsday/Info
cp -r $base_path/shinemaps/lightmaps $base_path/doomsday
cp $base_path/definitions/dhtp-shinmaps.ded $base_path/doomsday/dhtp-shinmaps.ded
cd $base_path/doomsday

echo ---------zipping pack---------
zip -r doomsday . -i Info \*.png \*.ded \*.txt

echo ---------renaming, adding date of compile, and moving to the built folder---------
mv doomsday.zip ../built/deng-dhtp-$datestamp.pk3

echo ---------Complete---------
