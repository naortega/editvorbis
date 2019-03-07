#!/bin/sh
if [ -z ${$PREFIX+x} ];
then
	PREFIX=/usr
fi

install editvorbis.sh $PREFIX/bin/editvorbis
