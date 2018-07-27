include <sharedparams.scad>
use <rotate_extrude.scad>
use <common.scad>

module SpacerRing() {
    difference() {
        union() {
            // Hollow cylinder
            difference() {
                cylinder(r=osBaseRadius, h=spacerRingHeight);
                cylinder(r=ringInnerRadius, h=spacerRingHeight);
            };
            
            // Inner detent cylinders
            for (ang = [detentArm1Angle : 360 / numPositions : detentArm1Angle + 360])
                rotate([0, 0, ang])
                    translate([ringInnerRadius, 0, 0])
                        cylinder(r=lockRingDetentRadius, h=spacerRingHeight);
        };
        
        // Slots for lock prongs
        // Add slightly more clearance because these don't actually need to block the fins
        slotSpanAngle = ringSlotSpanAngle * 1.3;
        for (ang = latchAngles)
            rotate([0, 0, -slotSpanAngle/2 + ang])
                rotate_extrude2(angle=slotSpanAngle)
                    square([lockSlotOuterRadius, 1000]);

        // Top marker dot
        translate([(osBaseRadius+lockSlotOuterRadius)/2, 0, spacerRingHeight-topMarkerDotDepth])
            cylinder(r=topMarkerDotRadius, h=topMarkerDotDepth);
    };
};

SpacerRing();  // no-customizer
