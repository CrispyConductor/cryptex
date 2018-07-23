include <sharedparams.scad>
use <rotate_extrude.scad>
use <common.scad>

module LabelRing() {
    // the label ring is basically a donut-shaped regular polygon, but with a few tapers on the inner hole
    // first, a significant taper is put on the top and bottom to make sure the label rings don't slide and interlock with adjacent rings
    // second, the clearance between the label ring and ring is slightly tapered to allow for an easier press fit
    
    // the major taper is sized such that 
    
    difference() {
        // Outer polygon
        linear_extrude(labelRingHeight)
            RegularPolygon(numCorners=numPositions, outerRadius=labelRingOuterRadius, faceOnXAxis=true);
        
        
    };
};

LabelRing();
