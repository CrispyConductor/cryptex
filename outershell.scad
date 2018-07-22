include <sharedparams.scad>
include <rotate_extrude.scad>
include <common.scad>

module OuterShell() {
    lockRingSlotHeight = lockRingActualHeight;
    module LockRingSlot() {
        LockRingFinger(
            width=lockRingFingerWidth+lockRingSlotWidthClearance,
            innerRadius=osInnerRadius * 0.9,
            outerRadius=osOuterRadius * 1.1,
            height=lockRingActualHeight,
            spanAngle=-lockRingSpanAngle
        );
    };
    
    difference() {
        union() {
            difference() {
                // Hollow cylinder
                rotate_extrude2()
                    translate([osInnerRadius, osBaseThick])
                        square([osThick, osInnerHeight]);

                // Detents
                for (ang = [detentArm1Angle : 360 / numPositions : detentArm1Angle + 360])
                    rotate([0, 0, ang])
                        translate([osOuterRadius, 0, osBaseThick])
                            cylinder(r=detentDepth, h=1000);
            };
            
            // Add slight chamfer at bottom for strength
            difference() {
                translate([0, 0, osBaseThick])
                    cylinder(r1=ringInnerRadius, r2=osInnerRadius, h=ringInnerRadius-osInnerRadius);
                cylinder(r=osInnerRadius, h=1000);
            };
        };
        
        // Slots
        // angles are mirrored because this is in opposing direction to other parts
        for (ang = latchAngles)
            rotate([0, 0, -osSlotSpanAngle/2 + -ang])
                rotate_extrude2(angle=osSlotSpanAngle)
                    translate([0, osBaseThick])
                        square([1000, 1000]);
        
        // Lock ring slots
        for (ang = lockRingFingerAngles)
            translate([0, 0, osInnerHeight + osBaseThick - lockRingSlotHeight])
                rotate([0, 0, -ang])
                    LockRingSlot();
    };
    
    // Base
    cylinder(h=osBaseThick, r=osBaseRadius);
};

OuterShell();
