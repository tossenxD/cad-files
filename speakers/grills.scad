/****************/
/** Parameters **/
/****************/
height = 260; // mm
width = 160; // mm
depth = 3; // mm
cutout = 110; // diameter in mm
thickness = 7.5; // mm
hook = 10; // extends beyond height/width on each side in mm
cutout_treble = 50; // diameter in mm
wall_height = 120; // surface in mm
wall_width = 105; // surface in mm
rounding_factor = 100; // cylinder radius for Minowski transformation
smoothness = 1000; // number of faces of curves

/*************/
/** Objects **/
/*************/
$fn = smoothness;

bass_x_offset = 50;
treble_x_offset = 0.5*cutout_treble + 100;
hook_depth = 0.4*depth;
hook_z_offset = -0.3*depth;
cylinder_z_offset = -0.5*depth;
support_offset = 16; // decrease print area requirements

/**/
// bass and treble
difference() {
    union() {
        //backbone
        translate([bass_x_offset,0,0]){cube([height,thickness,depth],true);}
        translate([bass_x_offset,0,hook_z_offset]){cube([height+(2*hook),thickness,hook_depth],true);}

        // lower support
        translate([support_offset,0,0]){cube([thickness,width,depth],true);}
        translate([support_offset,0,hook_z_offset]){cube([thickness,width+(2*hook),hook_depth],true);}

        // upper support
        translate([treble_x_offset-support_offset,0,0]){cube([thickness,width,depth],true);}
        translate([treble_x_offset-support_offset,0,hook_z_offset]){cube([thickness,width+(2*hook),hook_depth],true);}

        // rim around cutouts
        translate([0,0,cylinder_z_offset]){cylinder(depth, d=cutout+2*thickness, true);}
        translate([treble_x_offset,0,cylinder_z_offset]){cylinder(depth, d=cutout_treble+2*thickness, true);}
    }

    // cutouts
    translate([0,0,-depth]){cylinder(depth*2, d=cutout, true);}
    translate([treble_x_offset,0,-depth]){cylinder(depth*2, d=cutout_treble, true);}
}
/**/

/*
// bass
difference() {
    union() {
        cube([height,thickness,depth],true);
        cube([thickness,width,depth],true);
        translate([0,0,cylinder_z_offset]){cylinder(depth, d=cutout+2*thickness, true);}
        translate([0,0,hook_z_offset]){cube([height+(2*hook),thickness,depth*0.4],true);}
        translate([0,0,hook_z_offset]){cube([thickness,width+(2*hook),depth*0.4],true);}
    }
    translate([0,0,-depth]){cylinder(depth*2, d=cutout, true);}
}
/**/

/*
// bass total coverage
difference() {
    // shape
    resize([width, height, depth]) {
        minkowski() {
            hull() {
                union() {
                    cube([wall_height, width, depth], true);
                    cube([height, wall_width, depth], true);
                };
            };
        cylinder(r=rounding_factor,h=depth);
        };
    };
    // cutout
    translate([0,0,-2*depth]){cylinder(depth*4, d=cutout, true);};
}
/**/