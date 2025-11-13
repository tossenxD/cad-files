/*
 * Stand for my amplifier (Fosi Audio V3) to make it rest
 * comfortably on my desk lifted over my monitor stand.
 */

// PARAMETERS

frame_x = 90; // mm
frame_y = 125; // mm
frame_z = 5; // mm
frame_thickness = 15; // mm

indent_offset = 1.5; // mm
indent_diameter = 12; // mm
indent_height = 5; // mm

feet_height = 30; // mm
slide_scale = 1.34; // percentage

// MODEL

y_off = (frame_y - frame_thickness) * 0.5;
x_off = (frame_x - frame_thickness) * 0.5;

difference() {

union() {
    // frame
    difference() {
        cube([frame_x, frame_y, frame_z], true);
        cube([frame_x - (2 * frame_thickness), frame_y - (2 * frame_thickness), frame_z], true);
    }
    
    // feet
    slide_off = (frame_thickness * (slide_scale - 1)) * 0.5;
    hull() {
        translate([x_off, y_off - slide_off, frame_z * 0.5]) {
            cube([frame_thickness, frame_thickness * slide_scale, 0.0001], true);
        }
        translate([x_off, y_off, (feet_height + frame_z) * 0.5]) {
            cube([frame_thickness, frame_thickness, feet_height], true);
        }
    }
    hull() {
        translate([-x_off, y_off - slide_off, frame_z * 0.5]) {
            cube([frame_thickness, frame_thickness * slide_scale, 0.0001], true);
        }
        translate([-x_off, y_off, (feet_height + frame_z) * 0.5]) {
            cube([frame_thickness, frame_thickness, feet_height], true);
        }
    }
    hull() {
        translate([x_off, - (y_off - slide_off), frame_z * 0.5]) {
            cube([frame_thickness, frame_thickness * slide_scale, 0.0001], true);
        }
        translate([x_off, -y_off, (feet_height + frame_z) * 0.5]) {
            cube([frame_thickness, frame_thickness, feet_height], true);
        }
    }
    hull() {
        translate([-x_off, - (y_off - slide_off), frame_z * 0.5]) {
            cube([frame_thickness, frame_thickness * slide_scale, 0.0001], true);
        }
        translate([-x_off, -y_off, (feet_height + frame_z) * 0.5]) {
            cube([frame_thickness, frame_thickness, feet_height], true);
        }
    }
}


// indent
$fn = 75;
union() {
    translate([x_off, y_off, 0]) {
        cylinder(h = indent_height, d = indent_diameter, center = true);
    }
    translate([-x_off, y_off, 0]) {
        cylinder(h = indent_height, d = indent_diameter, center = true);
    }
    translate([x_off, -y_off, 0]) {
        cylinder(h = indent_height, d = indent_diameter, center = true);
    }
    translate([-x_off, -y_off, 0]) {
        cylinder(h = indent_height, d = indent_diameter, center = true);
    }
}

}