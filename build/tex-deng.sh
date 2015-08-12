#!/bin/bash

datestamp=$(date +%Y%m%d)
script_path=$(cd "$(dirname "$0")" ; pwd -P)
base_path=$(dirname "$script_path")

rm -r $base_path/doomsday

mkdir $base_path/built

echo ---------starting to create the dhtp for the doomsday engine and compatible engines---------
mkdir $base_path/doomsday

echo ---------create info file---------
read -d '' info << EOF
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
echo "$info" > "$base_path/doomsday/info"

echo ---------copying textures---------
cp -r $base_path/textures $base_path/doomsday/textures
cp $base_path/doomsday/textures/doom1/* $base_path/doomsday/textures
rm -r $base_path/doomsday/textures/doom1

echo ---------copying flats---------
cp -r $base_path/flats $base_path/doomsday/flats

echo ---------copying readmes---------
for filename in "$base_path/docs/"*; do
  base_name=$(basename $filename)
  cat "$base_path/README.md" "$filename" "$base_path/credits.txt" > "$base_path/doomsday/README_$base_name"
done

echo ---------copying *.ded files---------
cp $base_path/definitions/dhtp-doom1lights.ded $base_path/doomsday/dhtp-doom1lights.ded
cp $base_path/definitions/dhtp-doom2lights.ded $base_path/doomsday/dhtp-doom2lights.ded
cp $base_path/definitions/dhtp-doom2lights.ded $base_path/doomsday/dhtp-doom2-plutlights.ded
cp $base_path/definitions/dhtp-doom2lights.ded $base_path/doomsday/dhtp-doom2tntlights.ded
cp -r $base_path/shinemaps/lightmaps $base_path/doomsday
cp $base_path/definitions/dhtp-shinmaps.ded $base_path/doomsday/dhtp-shinmaps.ded

echo ---------zipping pack---------
pushd $base_path/doomsday
zip -r $base_path/built/deng-dhtp-$datestamp.pk3 . -i Info \*.png \*.ded \*.txt
popd

echo ---------Complete---------
