include <sharedparams.scad>

module InnerShell() {
    translate([0, 0, isBaseThick])
        difference() {
            // Main cylinder
            cylinder(h=isInnerHeight, r=isOuterRadius);
            // Inner cutout
            cylinder(h=isInnerHeight, r=isInnerRadius);
        };
    // Base/cap
    cylinder(h=isBaseThick, r=osBaseRadius);
        
    // Side prongs
    module prong() {
        // module produces a single prong, at the correct X offset, centered on the X axis, with a bottom Z of 0
        protrusion = 8;
        height = protrusion + 2;
        angle = 10;
        rotate([0, 0, -angle/2])
            rotate_extrude(angle=angle)
                translate([isOuterRadius, 0])
                    polygon([
                        [0, 0],
                        [protrusion, protrusion],
                        [protrusion, height],
                        [0, height]
                    ]);
    };
    for (ang = latchAngles)
        rotate([0, 0, ang])
            for (z = [isBaseThick : ringSpacing : isBaseThick + isInnerHeight - ringSpacing])
                translate([0, 0, z])
                    prong();
};

InnerShell();
