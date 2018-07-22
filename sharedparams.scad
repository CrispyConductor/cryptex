use <common.scad>

// Main parameters
compartmentDiameter = 40;
compartmentHeight = 30;
numRings = 2;
positionLabels = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z"
];
numPositions = len(positionLabels);

// Lock ring
lockRingHeight = 3;
lockRingHeightClearance = 0; // clearance for rings to rotate against each other, in addition to ring height clearance
lockRingActualHeight = lockRingHeight - lockRingHeightClearance;
lockRingFingerAngles = [60, 180, 300];
lockRingFingerWidth = 3;
lockRingSlotWidthClearance = 0.6;

// Inner shell
isInnerRadius = compartmentDiameter / 2;
isThick = 2;
isOuterRadius = isInnerRadius + isThick;
isInnerHeight = compartmentHeight;
isBaseThick = 3;
isOuterHeight = isInnerHeight + isBaseThick;
isProngSpanAngle = 10; // angular width of the lock prongs
isProngOffsetZ = -1; // vertical clearance between each ring and the prongs below it in locked position

// Outer shell
isOsClearance = 0.3; // Clearance on radius
osInnerRadius = isOuterRadius + isOsClearance;
osThick = 2;
osOuterRadius = osInnerRadius + osThick;
osInnerHeight = isInnerHeight;
osBaseThick = isBaseThick;
osOuterHeight = osInnerHeight + osBaseThick;
osSlotClearance = 0.3; // Clearance on each side of the fins to the outer shell slots
osSlotSpanAngle = isProngSpanAngle + 360 * osSlotClearance / (2 * PI * osInnerRadius) * 2;

lockRingSpanAngle = lockRingHeight / (2 * PI * osOuterRadius) * 360;

// Rings
ringSpacing = (isInnerHeight - lockRingHeight) / numRings;
osRingClearance = 0.3;
osProngProtrusion = 3; // Amount lock prongs protrude from the OD of the outer shell
isProngProtrusion = isOsClearance + osThick + osProngProtrusion; // amount the lock prongs extend from the OD of the inner shell cylinder
prongHeight = osProngProtrusion + 1; // total height of lock prongs, at the OD of the outer shell
ringInnerRadius = osOuterRadius + osRingClearance;
ringProngEndClearance = 0.3; // Clearance between the end of the prongs and the ring
ringProngCoverThick = 2;
ringMinThick = osProngProtrusion + ringProngCoverThick + ringProngEndClearance;
ringOuterMinRadius = ringInnerRadius + ringMinThick;
ringOuterRadius = ringOuterMinRadius / regularPolygonInnerRadiusMultiplier(numPositions);
ringHeightClearance = 0.2;
ringHeight = ringSpacing - ringHeightClearance;
ringSlotClearance = 0.5;
ringSlotSpanAngle = isProngSpanAngle + 360 * ringSlotClearance / (2 * PI * ringInnerRadius) * 2;
prongCoverHeightClearance = 1;
lockSlotOuterRadius = osOuterRadius + osProngProtrusion + ringProngEndClearance; // outer radius of slots for lock prongs

// Detents
detentDepth = 0.85;  // radius of detent cylindrical depressions
detentArm1Angle = 90; // Angle of the part of the arm that actually contacts the detent
detentArm2Angle = (numPositions % 2 == 0) ? detentArm1Angle + 180 : detentArm1Angle + 180 - (360 / numPositions / 2); 
detentArmHeight = 3;
detentArmThick = 1.5;
detentArmLength = 15;

osBaseRadius = ringOuterMinRadius;

// Misc
latchAngles = [ 0, 180+30, 180-40 ];

// System
$fa = 2;
$fs = 0.25;
