#!/bin/bash

datestamp=$(date +%Y%m%d)
script_path=$(cd "$(dirname "$0")" ; pwd -P)
base_path=$(dirname "$script_path")

rm -r $base_path/risen3d

mkdir $base_path/built

echo ---------starting to create the dhtp for risen3d and compatible engines---------
mkdir $base_path/risen3d
mkdir $base_path/risen3d/data

echo ---------copying textures---------
cp -r $base_path/textures $base_path/risen3d/data/textures
cp -r $base_path/flats $base_path/risen3d/data/textures/flats
cd $base_path/risen3d/data/textures/flats

echo ---------renaming and moving the flats---------
for i in $(ls); do mv $i ../flat-$i; done
cd $base_path/risen3d/data/textures
rm -r flats
cd $base_path/risen3d/data/textures/doom2
for i in $(ls); do mv $i ../$i; done
cd $base_path/risen3d/data/textures
rm -r doom2
cd $base_path

echo ---------copying readmes---------
for filename in "$base_path/docs/"*; do
  base_name=$(basename $filename)
  cat "$base_path/README.md" "$filename" "$base_path/docs/OUTRO.txt" > "$base_path/risen3d/README_$base_name"
done
cd $base_path/risen3d

echo ---------ziping pack---------
zip -r risen3d . -i \*.png \*.txt

echo ---------renaming, adding date of compile, and moving to the built folder---------
mv risen3d.zip ../built/r3d-dhtp-$datestamp.zip
cd ..

echo ---------Complete---------
