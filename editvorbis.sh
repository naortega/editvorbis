#!/bin/bash

# Copyright (C) 2017 Ortega Froysa, Nicolás <deathsbreed@themusicinnoise.net>
# Author: Ortega Froysa, Nicolás <deathsbreed@themusicinnoise.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# constants
APPNAME="editvorbis"
VERSION="v2.0"

# helper functions
function print_usage {
	echo "Usage: $0 <file>"
	echo "Usage: $0 -h | -v"
}

function print_info {
	echo "$APPNAME $VERSION"
	echo "Script for editing vorbis tags with your favorite editor."
}

# check number of arguments
if [ $# -ne 1 ]; then
	echo "Wrong number of arguments."
	print_usage
	exit 1
fi

# show help information
if [ "$1" == "-h" ]; then
	print_info
	print_usage
	echo "  <file>  File to edit tags."
	echo "  -h      Show this help information."
	echo "  -v      Show script version."
	exit 0
fi

# print version
if [ "$1" == "-v" ]; then
	echo "$APPNAME $VERSION"
	exit 0
fi

# check if vorbiscomment is installed
command -v vorbiscomment > /dev/null
if [ $? == 1 ]; then
	echo "Could not find vorbiscomment command in your PATH. Maybe it's not installed?"
	exit 1
fi

# check if the file exists
if [ ! -f "$1" ]; then
	echo "Regular file $1 does not exist."
	exit 1
fi

TMPDIR="/tmp/editvorbis"
TAGFILE="$TMPDIR/$1.txt"

mkdir -p $TMPDIR
vorbiscomment "$1" > "$TAGFILE"
$EDITOR "$TAGFILE"
vorbiscomment -w -c "$TAGFILE" "$1"
rm -rf $TMPDIR
