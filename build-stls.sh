#!/bin/bash

OPENSCAD=openscad-nightly

if [ $# -ne 3 ]; then
	echo "Usage: $0 <Diameter> <Height> <NumRings>"
	exit 1
fi

export DIAMETER=$1
export HEIGHT=$2
export NUMRINGS=$3

function buildPart {
	SCADFILE="${1}.scad"
	STLFILE="cryptex-${NUMRINGS}ring-${DIAMETER}x${HEIGHT}-${1}.stl"
	PNGFILE="cryptex-${NUMRINGS}ring-${DIAMETER}x${HEIGHT}-${1}.png"
#	$OPENSCAD -o "$STLFILE" -D "compartmentDiameter=$DIAMETER" -D "compartmentHeight=$HEIGHT" -D "numRings=$NUMRINGS" "$SCADFILE"
	$OPENSCAD -o "$PNGFILE" -D "compartmentDiameter=$DIAMETER" -D "compartmentHeight=$HEIGHT" -D "numRings=$NUMRINGS" --render --imgsize=600,600 "$SCADFILE"
}

buildPart ring-and-labelring


