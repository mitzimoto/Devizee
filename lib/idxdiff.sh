#!/bin/bash

# ------------------------------
# Author: Eric Mitz
# Date: 6-18-2012
# Description: Find added, removed and modified lines in idx files

function die() {
	echo $*
	exit 1
}

HEADER="PROP_TYPE|LIST_NO|LIST_AGENT|LIST_OFFICE|STATUS|LIST_PRICE|STREET_NO|STREET_NAME|\
        UNIT_NO|TOWN_NUM|AREA|ZIP_CODE|LENDER_OWNED|PHOTO_COUNT|PHOTO_DATE|PHOTO_MASK|SF_TYPE|\
        STYLE|LOT_SIZE|ACRE|SQUARE_FEET|GARAGE_SPACES|GARAGE_PARKING|BASEMENT|NO_ROOMS|NO_BEDROOMS|\
        NO_FULL_BATHS|NO_HALF_BATHS|MASTER_BATH|LIV_LEVEL|LIV_DIMEN|DIN_LEVEL|DIN_DIMEN|FAM_LEVEL|\
        FAM_DIMEN|KIT_LEVEL|KIT_DIMEN|MBR_LEVEL|MBR_DIMEN|BED2_LEVEL|BED2_DIMEN|BED3_LEVEL|BED3_DIMEN|\
        BED4_LEVEL|BED4_DIMEN|BED5_LEVEL|BED5_DIMEN|BTH1_LEVEL|BTH1_DIMEN|BTH2_LEVEL|BTH2_DIMEN|\
        BTH3_LEVEL|BTH3_DIMEN|LAUNDRY_LEVEL|LAUNDRY_DIMEN|OTH1_ROOM_NAME|OTH1_LEVEL|OTH1_DIMEN|\
        OTH2_ROOM_NAME|OTH2_LEVEL|OTH2_DIMEN|OTH3_ROOM_NAME|OTH3_LEVEL|OTH3_DIMEN|OTH4_ROOM_NAME|\
        OTH4_LEVEL|OTH4_DIMEN|OTH5_ROOM_NAME|OTH5_LEVEL|OTH5_DIMEN|OTH6_ROOM_NAME|OTH6_LEVEL|OTH6_DIMEN"

#The order should be "idx.txt" "idx.old.txt"
[ -n "$1" ] && [ -n "$2" ] || die "You must specify two files!"
[ -f "$1" ] && [ -f "$2" ] || die "File not found!"

# This is where we're going to put the generated files.
# The assumption is being made that file1 and file2 are in the same directory
basedir=`dirname $1`

# ------------------------------
# generate a list of removed lines
comm -13 "$1" "$2" > "$basedir/removed"

# ------------------------------
# generate a list of addedlines
echo $HEADER > "$basedir/added"
comm -23 "$1" "$2" >> "$basedir/added"


