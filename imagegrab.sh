#!/bin/bash
# for artist name: https://www.wikiart.org/en/artist_name
# for movment: https://www.wikiart.org/en/paintings-by-style/movement_here?select=featured#!%23filterName:featured,viewType:masonry

cache_dir="/home/$USER/.cache/artgrabber"
REGEX='https://uploads\d\.wikiart\.org/\d*?/?images/(?!pixel-icons)[\w|-]+/\w+[-\w|\d?]+?\.jpg'
if [ ! -d $cache_dir ]; then
	mkdir "$cache_dir"
	echo "cache directory created at /home/$user/.cache"

fi

if [ ! -f "$cache_dir/home.urls" ]; then
	curl -s "https://www.wikiart.org/" | grep -Po $REGEX > "$cache_dir/home.urls"
	echo "cache file created at $cache_dir"
fi

SEL="$(shuf "$cache_dir/home.urls" | head -1)"

OUT_NAME="${SEL##*/}" #name of the output file

echo "Downloading $OUT_NAME ..."
wget --quiet $SEL && sxiv -b "$OUT_NAME" && rm "$OUT_NAME"
echo "Removing $OUT_NAME ..."
