include <sharedparams.scad>
use <rotate_extrude.scad>
use <common.scad>

module Ring() {
    detentArmSpanAngle = detentArmLength / (2 * PI * ringInnerRadius) * 360;
    detentKeySpanAngle = detentDepth * 2 / (2 * PI * ringInnerRadius) * 360;
    
    module DetentArm() {
        // Generates detent arm such that detent cylinder is centered on X axis
        detentArmInnerRadius = ringInnerRadius;
        detentArmOuterRadius = detentArmInnerRadius + detentArmThick;
        // Arm
        difference() {
            rotate([0, 0, -detentArmSpanAngle + detentKeySpanAngle/2])
                rotate_extrude2(angle=detentArmSpanAngle)
                    translate([detentArmInnerRadius, 0])
                        square([detentArmThick, detentArmHeight]);
            // Chamfer the end
            linear_extrude(1000)
                polygon([
                    [detentArmOuterRadius, 0],
                    [0, detentArmOuterRadius],
                    [detentArmOuterRadius, detentArmOuterRadius]
                ]);
        };
        // Detent key (cylinder)
        intersection() {
            translate([detentArmInnerRadius, 0, 0])
                cylinder(r=detentDepth, h=detentArmHeight);
            // Clip off any part that extends beyond the detent arm
            cylinder(r=detentArmOuterRadius, h=detentArmHeight);
        };
    };
    
    module DetentArmCutout() {
        cutoutSpanClearanceLength = 1;
        cutoutDepthClearance = 0.5;
        cutoutHeightClearance = 0.3;
        cutoutSpanClearanceAngle = cutoutSpanClearanceLength / (2 * PI * ringInnerRadius) * 360;
        cutoutSpanAngle = detentArmSpanAngle + cutoutSpanClearanceAngle;
        cutoutDepth = detentArmThick + detentDepth + cutoutDepthClearance;
        cutoutHeight = detentArmHeight + cutoutHeightClearance;
        rotate([0, 0, -detentArmSpanAngle + detentKeySpanAngle/2])
            rotate_extrude2(angle=cutoutSpanAngle)
                polygon([
                    [0, 0],
                    [ringInnerRadius + cutoutDepth, 0],
                    [ringInnerRadius + cutoutDepth, cutoutHeight],
                    [0, cutoutHeight + ringInnerRadius + cutoutDepth]
                ]);
    };
    
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
        
        // Cutouts for detent arms
        rotate([0, 0, detentArm1Angle])
            DetentArmCutout();
        rotate([0, 0, detentArm2Angle])
            mirror([0, 1, 0])
                DetentArmCutout();
    };
    
    // Detent arms
    rotate([0, 0, detentArm1Angle])
        DetentArm();
    rotate([0, 0, detentArm2Angle])
        mirror([0, 1, 0])
            DetentArm();
};

Ring();
