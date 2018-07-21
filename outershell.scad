include <sharedparams.scad>
include <rotate_extrude.scad>

module OuterShell() {
    difference() {
        // Hollow cylinder
        rotate_extrude2()
            translate([osInnerRadius, osBaseThick])
                square([osThick, osInnerHeight]);
        
        // Slots
        // angles are mirrored because this is in opposing direction to other parts
        for (ang = latchAngles)
            rotate([0, 0, -osSlotSpanAngle/2 + -ang])
                rotate_extrude2(angle=osSlotSpanAngle)
                    translate([0, osBaseThick])
                        square([1000, 1000]);
        
        // Detents
        for (ang = [detentArm1Angle : 360 / numPositions : detentArm1Angle + 360])
            rotate([0, 0, ang])
                translate([osOuterRadius, 0, osBaseThick])
                    cylinder(r=detentDepth, h=1000);
    };
    
    // Base
    cylinder(h=osBaseThick, r=osBaseRadius);
};

OuterShell();
