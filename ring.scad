include <sharedparams.scad>
use <rotate_extrude.scad>
use <common.scad>

module Ring() {
    difference() {
        // Main shape of ring
        linear_extrude(ringHeight)
            difference() {
                // Outer polygon
                RegularPolygon(numCorners=numPositions, outerRadius=ringOuterRadius);
                // Center cavity
                circle(r=ringInnerRadius);
            };
        
        // Slots for lock prongs
        slotOuterRadius = osOuterRadius + osProngProtrusion + ringProngEndClearance;
        for (ang = latchAngles)
            rotate([0, 0, -ringSlotSpanAngle/2 + ang])
                rotate_extrude2(angle=ringSlotSpanAngle)
                    square([slotOuterRadius, 1000]);
        
        // Cutout for prong cover
        prongCoverHeight = prongHeight + prongCoverHeightClearance;
        translate([0, 0, ringHeight - prongCoverHeight])
            cylinder(r=ringOuterMinRadius - ringProngCoverThick, h=prongCoverHeight);
    };
};

Ring();
