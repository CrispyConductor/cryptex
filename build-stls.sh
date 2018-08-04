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
	echo "${1} ..."
	SCADFILE="${1}.scad"
	STLFILE="cryptex-${NUMRINGS}ring-${DIAMETER}x${HEIGHT}-${2}.stl"
	PNGFILE="cryptex-${NUMRINGS}ring-${DIAMETER}x${HEIGHT}-${2}.png"
	echo "    Building $SCADFILE -> $STLFILE"
	$OPENSCAD -o "$STLFILE" -D "compartmentDiameter=$DIAMETER" -D "compartmentHeight=$HEIGHT" -D "numRings=$NUMRINGS" "$SCADFILE"
	echo "    Building $SCADFILE -> $PNGFILE"
	$OPENSCAD -o "$PNGFILE" -D "compartmentDiameter=$DIAMETER" -D "compartmentHeight=$HEIGHT" -D "numRings=$NUMRINGS" --render --imgsize=600,600 "$SCADFILE"
}

buildPart innershell innershell
buildPart outershell outershell
buildPart ring inner_ring_only
buildPart labelring outer_ring_only
buildPart ring-and-labelring ring
buildPart lockring lockring
buildPart endcap endcap
buildPart ringseparatortool ringseparatortool

