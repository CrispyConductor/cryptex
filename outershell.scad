include <sharedparams.scad>

module OuterShell() {
    difference() {
        // Main cylinder
        cylinder(h=osInnerHeight+osBaseThick, r=osOuterRadius);
        // Hole in center
        translate([0, 0, osBaseThick])
            cylinder(h=osInnerHeight, r=osOuterRadius-osThick);
        // Slots
        
    };
    
    // Base
    cylinder(h=osBaseThick, r=osBaseRadius);
};

OuterShell();
