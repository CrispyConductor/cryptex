include <sharedparams.scad>
include <rotate_extrude.scad>

module InnerShell() {
    // Hollow cylinder
    rotate_extrude()
        translate([isInnerRadius, isBaseThick])
            square([isThick, isInnerHeight]);

    // Base/cap
    cylinder(h=isBaseThick, r=osBaseRadius);
        
    // Side ridges
    sideRidgeProtrusion = isOsClearance + osThick; // how far the ridges protrude from the outer edge of the main cylinder
    module sideRidge() {
        rotate([0, 0, -isProngSpanAngle/2])
            rotate_extrude2(angle=isProngSpanAngle)
                translate([isInnerRadius, 0])
                    square([isOsClearance + osThick + isThick, isInnerHeight]);
    };
    difference() {
        // Ridges
        for (ang = latchAngles)
            rotate([0, 0, ang])
                translate([0, 0, isBaseThick])
                    sideRidge();
        // Detents in ridges
        for (ang = [detentArm1Angle : 360 / numPositions : detentArm1Angle + 360])
            rotate([0, 0, ang])
                translate([isOuterRadius+sideRidgeProtrusion, 0, isBaseThick])
                    cylinder(r=detentDepth, h=1000);
    };
    
        
    // Side prongs
    module prong() {
        // module produces a single prong, at the correct X offset, centered on the X axis, with a bottom Z of 0
        protrusion = isProngProtrusion - sideRidgeProtrusion;
        height = prongHeight;
        angle = isProngSpanAngle;
        rotate([0, 0, -angle/2])
            rotate_extrude2(angle=angle)
                translate([isOuterRadius, 0])
                    polygon([
                        [0, -sideRidgeProtrusion],
                        [sideRidgeProtrusion, 0],
                        [isProngProtrusion, protrusion],
                        [isProngProtrusion, height],
                        [0, height]
                    ]);
    };
    for (ang = latchAngles)
        rotate([0, 0, ang])
            for (z = [isInnerHeight + isBaseThick - prongHeight : -ringSpacing : isBaseThick])
                translate([0, 0, z + isProngOffsetZ])
                    prong();
};

InnerShell();
