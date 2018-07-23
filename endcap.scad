include <sharedparams.scad>

module EndCap() {
    baseRadius = osBaseRadius;
    baseThick = 1;
    
    // Base
    translate([0, 0, -baseThick])
        cylinder(r=baseRadius, h=baseThick);
    
    // Twisty design thing
    numLobes = 5;
    lobeRadius = baseRadius / 2;
    
    module Thingy2D(initialTwist=0, initialScale=1) {
        scale([initialScale, initialScale, 0])
            rotate([0, 0, -initialTwist])
            for (ang = [0 : 360/numLobes : 359])
                rotate([0, 0, ang])
                    translate([baseRadius-lobeRadius, 0, 0])
                        circle(r=lobeRadius);
    };
    
    extrudeHeight = baseRadius * 0.75;
    twist = 650/numLobes;
    scale = 0.35;
    linear_extrude(extrudeHeight, twist=twist, scale=scale, slices=extrudeHeight/0.1)
        Thingy2D();
    
    // Cone at bottom
    cylinder(r1=baseRadius, r2=0, h=extrudeHeight);
    
    // Short extrusion at top
    translate([0, 0, extrudeHeight])
        linear_extrude(extrudeHeight/4, twist=twist/5, scale=0, slices=extrudeHeight/0.1)
            Thingy2D(twist, scale);
    
    // Sphere at top
    difference() {
        translate([0, 0, extrudeHeight*1.1])
            sphere(r=baseRadius*0.5);
        translate([0, 0, -500])
            cube([1000, 1000, 1000], center=true);
    };
};

EndCap();
