#!/bin/bash

function OutputFile {
	cat "$1" | grep -Ev '^use ?<' | grep -Ev '^include ?<' | grep -Ev 'no-customizer'
}

OutputFile 'mainparams.scad'
OutputFile 'common.scad'
OutputFile 'rotate_extrude.scad'
OutputFile 'sharedparams.scad'
OutputFile 'innershell.scad'
OutputFile 'outershell.scad'
OutputFile 'ring.scad'
OutputFile 'lockring.scad'
OutputFile 'labelring.scad'
OutputFile 'endcap.scad'
OutputFile 'ringseparatortool.scad'
OutputFile 'customizer-print-part.scad'

