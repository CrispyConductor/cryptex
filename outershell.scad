include <sharedparams.scad>
include <rotate_extrude.scad>
include <common.scad>

module OuterShell() {
    lockRingSlotHeight = lockRingHeight;
    module LockRingSlot() {
        LockRingFinger(
            width=lockRingFingerWidth+lockRingSlotWidthClearance,
            innerRadius=osInnerRadius * 0.9,
            outerRadius=osOuterRadius * 1.1,
            height=lockRingSlotHeight,
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
            
            // Add chamfer at bottom (fits into chamfered prong cover on ring)
            difference() {
                translate([0, 0, osBaseThick])
                    cylinder(r1=osOuterRadius+osProngProtrusion, r2=osInnerRadius, h=osOuterRadius+osProngProtrusion-osInnerRadius);
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
    difference() {
        // Base cylinder
        cylinder(h=osBaseThick, r=osBaseRadius);
        
        // Circle around base for symmetry with lock ring separation point
        circHeight = 0.3;
        circDepth = 0.3;
        translate([0, 0, isBaseThick-circHeight/2])
            difference() {
                cylinder(r=osBaseRadius, h=circHeight);
                cylinder(r=osBaseRadius-circDepth, h=circHeight);
            };
            
        // Indexing mark
        ShellBaseLineMark(radius=osBaseRadius, height=osBaseThick, numPositions=numPositions);
    };
};

OuterShell();
