// Main parameters
compartmentDiameter = 40;
compartmentHeight = 80;
numRings = 5;
positionLabels = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z"
];

// Inner shell
isInnerRadius = compartmentDiameter / 2;
isThick = 1.5;
isOuterRadius = isInnerRadius + isThick;
isInnerHeight = compartmentHeight;
isBaseThick = 3;
isOuterHeight = isInnerHeight + isBaseThick;

// Outer shell
isOsClearance = 0.3; // Clearance on radius
osInnerRadius = isOuterRadius + isOsClearance;
osThick = 1.5;
osOuterRadius = osInnerRadius + osThick;
osInnerHeight = isInnerHeight;
osBaseThick = isBaseThick;
osOuterHeight = osInnerHeight + osBaseThick;
osBaseRadius = osOuterRadius;

// Rings
ringSpacing = compartmentHeight / numRings;

// Misc
latchAngles = [ 0, 180+30, 180-30 ];

// System
$fa = 3;
$fs = 0.5;
