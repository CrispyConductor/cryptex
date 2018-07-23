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
    
    module LockProngSlots(angles) {
        for (ang = angles)
            rotate([0, 0, -ringSlotSpanAngle/2 + ang])
                rotate_extrude2(angle=ringSlotSpanAngle)
                    square([lockSlotOuterRadius, 1000]);
    };
    
    module ProngCoverCutout(zOffset=0) {
        prongCoverHeight = prongHeight - isProngOffsetZ + prongCoverHeightClearance;
        prongCoverInnerRadius = ringOuterMinRadius - ringProngCoverThick;
        translate([0, 0, ringHeight - prongCoverHeight + zOffset])
            difference() {
                cylinder(r=prongCoverInnerRadius, h=prongCoverHeight);
                // wedge shape
                rotate_extrude()
                    polygon([
                        [ringInnerRadius, 0],
                        [prongCoverInnerRadius, 0],
                        [prongCoverInnerRadius, prongCoverInnerRadius - ringInnerRadius]
                    ]);
            };
    };
    
    difference() {
        // Main shape of ring
        linear_extrude(ringHeight)
            difference() {
                // Outer polygon, rotated such that a face is centered on the X axis
                RegularPolygon(numCorners=numPositions, outerRadius=ringOuterRadius, faceOnXAxis=true);
                // Center cavity
                circle(r=ringInnerRadius);
            };
        
        // Slots for lock prongs
        LockProngSlots(latchAngles);
        
        // Cutout for prong cover
        ProngCoverCutout();
        
        // False lock slots
        intersection() {
            // Slots
            LockProngSlots(falseLockSlotAngles);
            // Thin-walled cone
            difference() {
                ProngCoverCutout(-falseLockSlotDepth);
                ProngCoverCutout();
            };
        };
        
        // Cutouts for detent arms
        rotate([0, 0, detentArm1Angle])
            DetentArmCutout();
        rotate([0, 0, detentArm2Angle])
            mirror([0, 1, 0])
                DetentArmCutout();
        
        // Spherical sockets for label ring to snap into
        for (ang = [0 : 360/numPositions : 360])
            rotate([0, 0, ang])
                translate([ringOuterMinRadius, 0, ringHeight/2])
                    sphere(r=labelRingKeySphereRadius);
        
        // Circle to label primary position
        circThickness = 0.4;
        circDepth = 0.5;
        circRadius = 2 * PI * ringOuterMinRadius / numPositions / 2 * 0.85;
        translate([ringOuterMinRadius, 0, ringHeight/2])
            rotate([0, 90])
                difference() {
                    cylinder(r=circRadius, h=circDepth*2, center=true);
                    cylinder(r=circRadius-circThickness, h=circDepth*2, center=true);
                };
        
        // Top marker dot
        translate([ringOuterMinRadius-ringProngCoverThick/2, 0, ringHeight-topMarkerDotDepth])
            cylinder(r=topMarkerDotRadius, h=topMarkerDotDepth);
    };
    
    // Detent arms
    rotate([0, 0, detentArm1Angle])
        DetentArm();
    rotate([0, 0, detentArm2Angle])
        mirror([0, 1, 0])
            DetentArm();
};

Ring();
