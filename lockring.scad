include <sharedparams.scad>
use <rotate_extrude.scad>
use <common.scad>

module LockRing() {
    difference() {
        union() {
            // Hollow cylinder
            difference() {
                cylinder(r=osBaseRadius, h=lockRingActualHeight);
                cylinder(r=ringInnerRadius, h=lockRingActualHeight);
            };
            
            // Inner detent cylinders
            for (ang = [detentArm1Angle : 360 / numPositions : detentArm1Angle + 360])
                rotate([0, 0, ang])
                    translate([ringInnerRadius, 0, 0])
                        cylinder(r=detentDepth, h=lockRingActualHeight);
            
            // Lock fingers
             for (ang = lockRingFingerAngles)
                rotate([0, 0, ang])
                    LockRingFinger(
                        width=lockRingFingerWidth,
                        innerRadius=osInnerRadius,
                        outerRadius=(ringInnerRadius+osBaseRadius)/2,
                        height=lockRingActualHeight,
                        spanAngle=lockRingSpanAngle
                    );
        };
        
        // Slots for lock prongs
        for (ang = latchAngles)
            rotate([0, 0, -ringSlotSpanAngle/2 + ang])
                rotate_extrude2(angle=ringSlotSpanAngle)
                    square([lockSlotOuterRadius, 1000]);
    };
};

LockRing();
