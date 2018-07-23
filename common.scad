
// Polygon is centered on origin, with "first" point along X axis
module RegularPolygon(numCorners, outerRadius, faceOnXAxis=false) {
    points = [
        for (pointNum = [0 : numCorners - 1])
            [cos(pointNum / numCorners * 360) * outerRadius, sin(pointNum / numCorners * 360) * outerRadius]
    ];
    if (faceOnXAxis)
        rotate([0, 0, 360/numCorners/2])
            polygon(points);
    else
        polygon(points);
};

// Returns multipler to get inner radius (closest distance to origin) from a regular polygon with outer radius of 1
function regularPolygonInnerRadiusMultiplier(numCorners) =
    let (pt = ([1, 0] + [cos(1 / numCorners * 360), sin(1 / numCorners * 360)]) / 2)
        sqrt(pt[0]*pt[0] + pt[1]*pt[1]);

// width is gap width of slot (Y axis)
module LockRingFinger(width, innerRadius, outerRadius, height, spanAngle) {
    rotate([0, 0, spanAngle/2])
        linear_extrude(height=height, twist=spanAngle, slices=height*10)
            translate([innerRadius, -width/2])
                square([outerRadius - innerRadius, width]);
};

//LockRingFinger(3, 20, 23, 3, 15);