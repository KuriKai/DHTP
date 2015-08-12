#!/bin/bash

datestamp=$(date +%Y%m%d)
script_path=$(cd "$(dirname "$0")" ; pwd -P)
base_path=$(dirname "$script_path")

#remove the old zdoom build setup folder if it exists
if [ -d "$base_path/zdoom" ]; then
	echo "found, removing the old risen3d build folder"
    rm -r $base_path/zdoom
else
	echo "not found"
fi

#if the built folder does not exist, create it as this is where the compiled pack is placed
echo "looking for $base_path/built"
if [ ! -d "$base_path/built" ]; then
    mkdir $base_path/built
else
	echo "built folder already exists, doing nothing"
fi

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
rm -r $base_path/zdoom/hires/doom1
cd $base_path/zdoom

echo ---------ziping pack---------
zip -r zdoom . -i \*.png \*.txt
echo renaming and adding date of compile
mv zdoom.zip ../built/zdoom-dhtp-20$mydate.pk3
cd ..

echo ---------Complete---------
