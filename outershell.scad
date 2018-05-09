include <sharedparams.scad>

module OuterShell() {
    difference() {
        // Main cylinder
        cylinder(h=osInnerHeight+osBaseHeight, r=osOuterRadius);
        // Hole in center
        translate([0, 0, osBaseHeight])
            cylinder(h=osInnerHeight, r=osOuterRadius-osWallThick);
    };
};

OuterShell();
