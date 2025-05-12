/*
 * This directory contains a Lily58 case, adapted to
 * the Halcyon Lily58 from splitkb.com.
 *
 * The Lily58 is an opensource column-staggered 58-key split keyboard.
 * I wanted a versatile and portable yet sturdy case that is easy to transport,
 * lightweight, hassle-free operation in different usecases (e.g. in public
 * transport, at a desk, from bed), allows for adjustable tenting, has space
 * for sound-dampening material, and remaining firm in all scenario.
 *
 * I believe the best approach to the above criteria is embedded magnets.
 *
 * Hence, I designed my own case from the ground up with this in mind.
 *
 * Reference model (`reference.svg`) is taken from the original design:
 * https://github.com/kata0510/Lily58
 *
 * NOTE: Units are in mm and the design is the right-hand side.
 */

//// 
// Input parameters
////

DPI = 96;

THICKNESS = 3;

TOP_COVER_PCB_OFFSET = 6;

PLATE_BOTTOM_OFFSET = 8;

PLATE_THICKNESS = 1.5;

PCB_THICKNESS = 1.5;

SCREW_HEAD_HEIGHT = 1.25;

SCREW_LENGTH = 5;

SCREW_HEAD_DIAMETER = 4;

SCREW_SHANK_DIAMETER = 2;

MODULE_SCREW_HEAD_HEIGHT = 1.6;

MODULE_SCREW_SHANK_DIAMETER = 1.5;

MODULE_SCREW_HEAD_DIAMETER = 3;

MAGNET_DIAMETER = 7;

MAGNET_HEIGHT = 2;


////
// Calculated parameters
////

SCREW_HEAD_OFFSET_RADIUS =
    (SCREW_HEAD_DIAMETER - SCREW_SHANK_DIAMETER) / 2;
    
MODULE_SCREW_HEAD_OFFSET_RADIUS =
    (MODULE_SCREW_HEAD_DIAMETER - MODULE_SCREW_SHANK_DIAMETER) / 2;

WALL_HEIGHT = PLATE_BOTTOM_OFFSET + PLATE_THICKNESS;

COVER_SPACER_HEIGHT = max(0, (
    (2 * SCREW_LENGTH) + 0.1 - TOP_COVER_PCB_OFFSET -
        (THICKNESS - SCREW_HEAD_HEIGHT) - PCB_THICKNESS));
        
MAGNET_OFFSET_RADIUS = (MAGNET_DIAMETER - 1) / 2;

////
// Cover
////

/*
difference() {
    linear_extrude(height = THICKNESS) {
        import("cover/frame.svg", dpi = DPI);
    }
    linear_extrude(height = THICKNESS) {
        import("cover/screw_cutouts.svg", dpi = DPI);
    }
    translate([0, 0, THICKNESS - SCREW_HEAD_HEIGHT]) {
        linear_extrude(height = SCREW_HEAD_HEIGHT) {
            offset(r = SCREW_HEAD_OFFSET_RADIUS) {
                import("cover/screw_cutouts.svg", dpi = DPI);
            }
        }
    }
    linear_extrude(height = THICKNESS) {
        import("cover/module_screw_cutout.svg", dpi = DPI);
    }
    translate([0, 0, THICKNESS - MODULE_SCREW_HEAD_HEIGHT]) {
        linear_extrude(height = MODULE_SCREW_HEAD_HEIGHT) {
            offset(r = MODULE_SCREW_HEAD_OFFSET_RADIUS) {
                import("cover/module_screw_cutout.svg", dpi = DPI);
            }
        }
    }
}
/**/

////
// Spacer for the cover underneath PCB
////

/*
difference()
{
    linear_extrude(height = COVER_SPACER_HEIGHT) {
        offset(r = SCREW_HEAD_OFFSET_RADIUS) {
            import("cover/screw_cutouts.svg", dpi = DPI);
        }
    }
    linear_extrude(height = COVER_SPACER_HEIGHT) {
        import("cover/screw_cutouts.svg", dpi = DPI);
    }
}
/**/

////
// Bottom
////

difference() {
linear_extrude(height = THICKNESS) {
    offset(r = MAGNET_OFFSET_RADIUS + 2)
        import("bottom/magnet_cutouts.svg", dpi = DPI);
}
translate([0, 0, (THICKNESS - MAGNET_HEIGHT - 0.2) / 2]) {
linear_extrude(height = MAGNET_HEIGHT + 0.2) {
    offset(r = MAGNET_OFFSET_RADIUS)
        import("bottom/magnet_cutouts.svg", dpi = DPI);
}
}
}

/*
difference() {
    union() {
        linear_extrude(height = THICKNESS) {
            offset(delta = THICKNESS + 0.1) {
                import("bottom/frame.svg", dpi = DPI);
            }
        }
        difference() {
            linear_extrude(height = WALL_HEIGHT) {
                offset(delta = THICKNESS + 0.1) {
                    import("bottom/frame.svg", dpi = DPI);
                }
            }
            linear_extrude(height = WALL_HEIGHT) {
                offset(delta = 0.1) {
                    import("bottom/frame.svg", dpi = DPI);
                }
            }
        }
    }
    linear_extrude(height = THICKNESS) {
        import("bottom/screw_cutouts.svg", dpi = DPI);
    }
    linear_extrude(height = SCREW_HEAD_HEIGHT) {
        offset(r = SCREW_HEAD_OFFSET_RADIUS) {
            import("bottom/screw_cutouts.svg", dpi = DPI);
        }
    }
}
/**/