#!/bin/bash

datestamp=$(date +%Y%m%d)
script_path=$(cd "$(dirname "$0")" ; pwd -P)
base_path=$(dirname "$script_path")

rm -r $base_path/zdoom

mkdir $base_path/built

echo ---------starting to create the dhtp for the zdoom engine and compatible engines---------
mkdir $base_path/zdoom

echo ---------copying textures---------
cp -r $base_path/textures $base_path/zdoom/hires
cp $base_path/zdoom/hires/doom1/* $base_path/zdoom/hires
rm -r $base_path/zdoom/hires/doom1
echo copying flats
cp -r $base_path/flats/* $base_path/zdoom/hires

echo ---------copying readmes---------
for filename in "$base_path/docs/"*; do
  base_name=$(basename $filename)
  cat "$base_path/README.md" "$filename" "$base_path/docs/OUTRO.txt" > "$base_path/zdoom/README_$base_name"
done
cd $base_path/zdoom

echo ---------ziping pack---------
zip -r zdoom . -i \*.png \*.txt
echo renaming and adding date of compile
mv zdoom.zip ../built/zdoom-dhtp-$datestamp.pk3
cd ..

echo ---------Complete---------
