#!/bin/bash
# for artist name: https://www.wikiart.org/en/artist_name
# for movement: https://www.wikiart.org/en/paintings-by-style/movement_here?select=featured#!%23filterName:featured,viewType:masonry

image_dir="/home/$USER/" # folder for save images
cache_dir="/home/$USER/.cache/artgrabber"

REGEX='https://uploads\d\.wikiart\.org/\d*?/?images/(?!pixel-icons)[\w|-]+/\w+[-\w|\d?]+?\.jpg'
DEL=1

if [ ! -d $cache_dir ]; then
	mkdir "$cache_dir"
	echo "cache directory created at /home/$user/.cache"

fi

if [ $# -gt 0 ]; then
	case $1 in
		-u) # update the cache with the urls.
			rm "$cache_dir/home.urls" 2> /dev/null;;
		-s) # don't delete image, save it.
			DEL=0

	esac
fi

if [ ! -f "$cache_dir/home.urls" ]; then
	curl -s "https://www.wikiart.org/" | grep -Po $REGEX > "$cache_dir/home.urls"
	echo "cache file created at $cache_dir"
fi

SEL="$(shuf "$cache_dir/home.urls" | head -1)"

OUT_NAME="${SEL##*/}" #name of the output file

echo "Downloading $OUT_NAME ..."
wget --quiet --directory-prefix="$image_dir" $SEL && sxiv -b "$image_dir/$OUT_NAME"

[ $DEL -eq 1 ] && (echo "Removing $image_dir/$OUT_NAME ..." && rm "$image_dir/$OUT_NAME")
