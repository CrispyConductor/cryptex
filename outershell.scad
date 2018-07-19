include <sharedparams.scad>
include <rotate_extrude.scad>

module OuterShell() {
    difference() {
        // Hollow cylinder
        rotate_extrude2()
            translate([osInnerRadius, osBaseThick])
                square([osThick, osInnerHeight]);
        
        // Slots
        for (ang = latchAngles)
            rotate([0, 0, -osSlotSpanAngle/2 + ang])
                rotate_extrude2(angle=osSlotSpanAngle)
                    translate([0, osBaseThick])
                        square([1000, 1000]);
    };
    
    // Base
    cylinder(h=osBaseThick, r=osBaseRadius);
};

OuterShell();
