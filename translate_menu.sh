#!/bin/bash
# trans -brief en:es $1

func () {
	val=$(echo $1 | dmenu -p "->" | trans -brief es:en)
	if [ "$val" != "" ]; then
		echo "$val" | xclip
		func "$val"
	fi
}
func ""
