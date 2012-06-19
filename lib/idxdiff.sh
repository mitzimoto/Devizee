#!/bin/bash

# ------------------------------
# Author: Eric Mitz
# Date: 6-18-2012
# Description: Find added, removed and modified lines in idx files

function die() {
	echo $*
	exit 1
}

#The order should be "idx.txt" "idx.old.txt"
[ -n "$1" ] && [ -n "$2" ] || die "You must specify two files!"
[ -f "$1" ] && [ -f "$2" ] || die "File not found!"

# This is where we're going to put the generated files.
# The assumption is being made that file1 and file2 are in the same directory
basedir=`dirname $1`

# ------------------------------
# generate the list of removed lines

join -v 2 -j 2 -t'|' "$1" "$2" > "$basedir/removed"

# ------------------------------
# generate the list of added lines

join -v 1 -j 2 -t'|' "$1" "$2" > "$basedir/added"

# ------------------------------
# generate a list of modified lines

comm -13 "$1" "$2" > "$basedir/modified.temp"

# ------------------------------
# purge the added lines from the modified file 

join -v 2 -1 1 -2 2 -t'|' "$basedir/removed" "$basedir/modified.temp" > "$basedir/modified"
rm "$basedir/modified.temp"

