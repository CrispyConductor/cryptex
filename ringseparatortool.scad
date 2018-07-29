include <sharedparams.scad>
use <rotate_extrude.scad>
use <common.scad>

module RingSeparatorTool() {
    
    module LabelRingSupport() {
        
        outerRingGuideHeight = 1;
        outerRingGuideClearance = 0.3;
        outerRingGuideThick = 2;
        
        difference() {
            // Outer polygon
            linear_extrude(ringHeight + outerRingGuideHeight)
                RegularPolygon(numCorners=numPositions, outerRadius=labelRingOuterRadius+outerRingGuideClearance+outerRingGuideThick, faceOnXAxis=true);
            
            // Cutout for label ring
            translate([0, 0, ringHeight])
                linear_extrude(1000)
                    RegularPolygon(numCorners=numPositions, outerRadius=labelRingOuterRadius+outerRingGuideClearance, faceOnXAxis=true);
            
            // Inner cutout for ring
            linear_extrude(1000)
                    RegularPolygon(numCorners=numPositions, outerRadius=labelRingInnerBufferRadius, faceOnXAxis=true);
        };
        
    };
    
    module RingPusher() {
        
        clearance = 0.5;
        outerRadius = ringOuterMinRadius - ringProngCoverThick - clearance;
        baseHeight = ringHeight + prongCoverHeight + 1;
        chamferSize = outerRadius - ringInnerRadius;
        
        cylinder(r=outerRadius, h=baseHeight);
        translate([0, 0, baseHeight])
            cylinder(r1=outerRadius, r2=outerRadius-chamferSize, h=chamferSize);
        
    };
    
    LabelRingSupport();
    RingPusher();
    
};

RingSeparatorTool(); // no-customizer
