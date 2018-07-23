include <sharedparams.scad>
use <rotate_extrude.scad>
use <common.scad>

module LabelRing() {
    
    difference() {
        // Outer polygon
        linear_extrude(labelRingHeight)
            RegularPolygon(numCorners=numPositions, outerRadius=labelRingOuterRadius, faceOnXAxis=true);
        
        // Buffer cutouts
        for (z = [0, labelRingHeight-labelRingInnerBufferHeight])
            translate([0, 0, z])
                linear_extrude(labelRingInnerBufferHeight)
                    RegularPolygon(numCorners=numPositions, outerRadius=labelRingInnerBufferRadius, faceOnXAxis=true);
        
        // Bottom buffer taper (for easier printing)
        bufferTaperHeight = (labelRingHeight - 2*labelRingInnerBufferHeight - labelRingContactHeight) / 2;
        bufferTaperScale = labelRingInnerMinRadius / labelRingInnerBufferRadius;
        translate([0, 0, labelRingInnerBufferHeight])
            linear_extrude(bufferTaperHeight, scale=bufferTaperScale)
                RegularPolygon(numCorners=numPositions, outerRadius=labelRingInnerBufferRadius, faceOnXAxis=true);
        
        // Top buffer taper (just for symmetry)
        topBufferTaperMinRadius = ringOuterMinRadius + labelRingRingClearanceMax;
        topBufferTaperScale = labelRingInnerBufferRadius / topBufferTaperMinRadius;
        translate([0, 0, labelRingInnerBufferHeight + bufferTaperHeight + labelRingContactHeight])
            linear_extrude(bufferTaperHeight, scale=topBufferTaperScale)
                RegularPolygon(numCorners=numPositions, outerRadius=topBufferTaperMinRadius, faceOnXAxis=true);
        
        // Internal (contact) taper from min clearance (at bottom) to max clearance
        contactScale = topBufferTaperMinRadius / labelRingInnerMinRadius;
        translate([0, 0, labelRingInnerBufferHeight + bufferTaperHeight])
            linear_extrude(labelRingContactHeight, scale=contactScale)
                RegularPolygon(numCorners=numPositions, outerRadius=labelRingInnerMinRadius, faceOnXAxis=true);
                
        // Labels
        reverseOrder = true;
        labelSize = 2 * PI * labelRingOuterMinRadius / numPositions / 2;
        for (labelNum = [0 : numPositions - 1])
            rotate([0, 0, (reverseOrder ? 1 : -1) * labelNum * 360/numPositions])
                translate([labelRingOuterMinRadius, 0, labelRingHeight/2])
                    rotate([reverseOrder ? 180 : 0, 0, 0])
                        rotate([0, 90, 0])
                            linear_extrude(labelDepth*2, center=true)
                                text(text=positionLabels[labelNum], size=labelSize, halign="center", valign="center");
        
        // Top marker dot
        translate([(labelRingOuterMinRadius+labelRingInnerBufferMinRadius)/2, 0, labelRingHeight-topMarkerDotDepth])
            cylinder(r=topMarkerDotRadius, h=topMarkerDotDepth);
    };
    
    // Key spheres
    for (ang = [0 : 360/numPositions : 360])
        rotate([0, 0, ang])
            translate([ringOuterMinRadius + labelRingRingClearanceMax, 0, labelRingHeight/2])
                sphere(r=labelRingKeySphereRadius);
};

LabelRing();
