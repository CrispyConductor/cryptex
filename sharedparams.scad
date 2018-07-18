// Main parameters
compartmentDiameter = 40;
compartmentHeight = 30;
numRings = 2;
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
isProngSpanAngle = 10; // angular width of the lock prongs

// Outer shell
isOsClearance = 0.3; // Clearance on radius
osInnerRadius = isOuterRadius + isOsClearance;
osThick = 1.5;
osOuterRadius = osInnerRadius + osThick;
osInnerHeight = isInnerHeight;
osBaseThick = isBaseThick;
osOuterHeight = osInnerHeight + osBaseThick;
osBaseOverhang = 2;
osBaseRadius = osOuterRadius + osBaseOverhang;

// Rings
ringSpacing = compartmentHeight / numRings;
osRingClearance = 0.3;
osProngProtrusion = 3; // Amount lock prongs protrude from the OD of the outer shell
isProngProtrusion = isOsClearance + osThick + osProngProtrusion; // amount the lock prongs extend from the OD of the inner shell cylinder
prongHeight = osProngProtrusion + 1; // total height of lock prongs, at the OD of the outer shell


// Misc
latchAngles = [ 0, 180+30, 180-30 ];

// System
$fa = 3;
$fs = 0.5;
