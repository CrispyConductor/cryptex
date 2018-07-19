
// Polygon is centered on origin, with "first" point along X axis
module RegularPolygon(numCorners, outerRadius) {
    points = [
        for (pointNum = [0 : numCorners - 1])
            [cos(pointNum / numCorners * 360) * outerRadius, sin(pointNum / numCorners * 360) * outerRadius]
    ];
    polygon(points);
};

// Returns multipler to get inner radius (closest distance to origin) from a regular polygon with outer radius of 1
function regularPolygonInnerRadiusMultiplier(numCorners) =
    let (pt = ([1, 0] + [cos(1 / numCorners * 360), sin(1 / numCorners * 360)]) / 2)
        sqrt(pt[0]*pt[0] + pt[1]*pt[1]);
