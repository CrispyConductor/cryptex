/* [Main Parameters] */

// Diameter of inner compartment
compartmentDiameter = 40;

// Height of inner compartment
compartmentHeight = 70;

// Number of rotating rings
numRings = 5;

// Labels on rings, also determines number of positions
positionLabelsStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

// Customizer part
part = "innershell"; // [innershell:Inner Shell, outershell:Outer Shell, ring:Ring, lockring:Lock Ring, endcap:End Cap, ringseparatortool:Ring Separator Tool]

/* [Hidden] */

positionLabels = [ for (i = [0 : len(positionLabelsStr) - 1]) positionLabelsStr[i] ];

