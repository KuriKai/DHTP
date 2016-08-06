#!/bin/bash

datestamp=$(date +%Y%m%d)
script_path=$(cd "$(dirname "$0")" ; pwd -P)
base_path=$(dirname "$script_path")

rm -r $base_path/zdoom

mkdir $base_path/built

echo ---------starting to create the dhtp for the zdoom engine and compatible engines---------
mkdir -p $base_path/zdoom/doom/hires
mkdir -p $base_path/zdoom/doom2/hires
mkdir -p $base_path/zdoom/doom2.plutonia/hires
mkdir -p $base_path/zdoom/doom2.tnt/hires

echo ---------copying textures---------
cp -r $base_path/textures $base_path/zdoom/textures
mv $base_path/zdoom/textures/doom1/* $base_path/zdoom/doom/hires
mv $base_path/zdoom/textures/doom2/* $base_path/zdoom/doom2/hires
mv $base_path/zdoom/textures/doom2-plut/* $base_path/zdoom/doom2.plutonia/hires
mv $base_path/zdoom/textures/doom2-tnt/* $base_path/zdoom/doom2.tnt/hires
rmdir $base_path/zdoom/textures/doom*
mv $base_path/zdoom/textures/* $base_path/zdoom/doom/hires
echo ---------copying flats---------
cp -r $base_path/flats/* $base_path/zdoom/doom/hires

pushd $base_path/zdoom/doom
zip -r $base_path/zdoom/zdoom-dhtp-$datestamp-doom.pk3 . -i \*.png
popd
pushd $base_path/zdoom/doom2
zip -r $base_path/zdoom/zdoom-dhtp-$datestamp-doom2.pk3 . -i \*.png
popd
pushd $base_path/zdoom/doom2.plutonia
zip -r $base_path/zdoom/zdoom-dhtp-$datestamp-doom2.plutonia.pk3 . -i \*.png
popd
pushd $base_path/zdoom/doom2.tnt
zip -r $base_path/zdoom/zdoom-dhtp-$datestamp-doom2.tnt.pk3 . -i \*.png
popd


echo ---------copying readmes---------
for filename in "$base_path/docs/"*; do
  base_name=$(basename $filename)
  cat "$base_path/README.md" "$filename" "$base_path/credits.txt" > "$base_path/zdoom/README_$base_name"
done

echo ---------ziping pack---------
pushd $base_path/zdoom
zip -r $base_path/built/zdoom-dhtp-$datestamp.zip . -i \*.pk3 \*.txt
popd

echo ---------Complete---------
