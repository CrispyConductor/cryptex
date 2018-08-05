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
            // Only spans 2/3 of lock ring height to allow screw to get started
            // Then tapered along the next third
            difference() {
                // Cylinders
                for (ang = [detentArm1Angle : 360 / numPositions : detentArm1Angle + 360])
                    rotate([0, 0, ang])
                        translate([ringInnerRadius, 0, 0])
                            cylinder(r=lockRingDetentRadius, h=lockRingActualHeight * (2/3), $fn=20);
                
                // Cone to taper the detents
                translate([0, 0, lockRingActualHeight * (1/3)])
                    cylinder(r1=ringInnerRadius-detentDepth, r2=ringInnerRadius, h=lockRingActualHeight/3);
            };
            
            // Lock fingers
             for (ang = lockRingFingerAngles)
                rotate([0, 0, ang])
                    LockRingFinger(
                        width=lockRingFingerWidth,
                        innerRadius=osInnerRadius,
                        outerRadius=(ringInnerRadius+osBaseRadius)/2,
                        height=lockRingActualHeight,
                        spanAngle=-lockRingSpanAngle
                    );
        };
        
        // Slots for lock prongs
        // Add slightly more clearance because these don't actually need to block the fins
        slotSpanAngle = ringSlotSpanAngle * 1.3;
        for (ang = latchAngles)
            rotate([0, 0, -slotSpanAngle/2 + ang])
                rotate_extrude2(angle=slotSpanAngle)
                    square([lockSlotOuterRadius, 1000]);
        
        // Pin holes that lock with inner shell
        for (ang = lockRingPinAngles)
            rotate([0, 0, ang])
                translate([lockRingPinX, 0, 0])
                    cylinder(r=lockRingPinRadius+lockRingPinClearance, h=1000);
        
        // Top marker dot
        translate([(osBaseRadius+lockSlotOuterRadius)/2, 0, lockRingActualHeight-topMarkerDotDepth])
            cylinder(r=topMarkerDotRadius, h=topMarkerDotDepth);
        
        // Indexing mark
        translate([0, 0, -isBaseThick-lockRingHeight+lockRingActualHeight])
            ShellBaseLineMark(radius=osBaseRadius, height=isBaseThick+lockRingHeight, numPositions=numPositions);
    };
};

LockRing();  // no-customizer
