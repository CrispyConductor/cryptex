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
//positionLabels = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" ];
numPositions = len(positionLabels);

// Lock ring
lockRingHeight = 4;
lockRingHeightClearance = 0.2; // clearance for rings to rotate against each other, in addition to ring height clearance
lockRingActualHeight = lockRingHeight - lockRingHeightClearance;
lockRingFingerAngles = [60, 180, 300];
lockRingFingerWidth = 3;
lockRingSlotWidthClearance = 0.6;
lockRingDetentOsProtrusion = 0.3; // amount lock ring detents protrude into the outer shell

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
osBaseThick = isBaseThick + lockRingHeight;
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
prongCoverHeightClearance = 0.6; // amount shells will open before prongs engage on rings
lockSlotOuterRadius = osOuterRadius + osProngProtrusion + ringProngEndClearance; // outer radius of slots for lock prongs

// Detents
detentDepth = 0.85;  // radius of detent cylindrical depressions
detentArm1Angle = 90; // Angle of the part of the arm that actually contacts the detent
detentArm2Angle = (numPositions % 2 == 0) ? detentArm1Angle + 180 : detentArm1Angle + 180 - (360 / numPositions / 2); 
detentArmHeight = 3;
detentArmThick = 1.5;
detentArmLength = 15;

// Label rings
labelRingRingClearanceMax = 0.6; // clearance tapers to allow for easier press fit
labelRingRingClearanceMin = 0.4;
labelRingMinThick = 2;
labelRingHeight = ringHeight;
labelRingInnerHeight = labelRingHeight * 0.8; // thickness/height tapers to prevent label rings from slipping vertically
labelRingInnerMinRadius = ringOuterMinRadius + labelRingRingClearanceMin;
labelRingInnerRadius = labelRingInnerMinRadius / regularPolygonInnerRadiusMultiplier(numPositions);
labelRingInnerBufferMinRadius = max(labelRingInnerMinRadius, ringOuterRadius + osRingClearance + labelRingRingClearanceMax); // inner radius on the top and bottom of label ring to prevent engaging adjacent rings if they slide
labelRingInnerBufferRadius = labelRingInnerBufferMinRadius / regularPolygonInnerRadiusMultiplier(numPositions);
labelRingInnerBufferHeight = labelRingHeight / 6;
labelRingContactHeight = labelRingHeight / 3; // amount of label ring in contact with ring (tapering from clearanceMax to clearanceMin)
labelRingOuterMinRadius = max(labelRingInnerMinRadius, labelRingInnerBufferMinRadius) + labelRingMinThick;
labelRingOuterRadius = labelRingOuterMinRadius / regularPolygonInnerRadiusMultiplier(numPositions);
labelRingKeySphereRadius = labelRingRingClearanceMax + 0.1;
labelDepth = 0.5;

osBaseRadius = labelRingOuterMinRadius;
//lockRingDetentRadius = lockRingDetentOsProtrusion + osRingClearance;
lockRingDetentRadius = detentDepth;

lockRingPinAngles = lockRingFingerAngles;
lockRingPinRadius = (osBaseRadius - ringInnerRadius) / 4;
lockRingPinX = (osBaseRadius + ringInnerRadius) / 2;
lockRingPinClearance = 0.25;
lockRingPinHeight = lockRingActualHeight * 0.9;

topMarkerDotRadius = 0.5;
topMarkerDotDepth = 0.4;

// Misc
latchAngles = [ 0, 180+30, 180-40 ];

// System
$fa = 2;
$fs = 0.25;
