/*
 * This directory contains a Lily58 case, adapted to the Halcyon Lily58 from splitkb.com.
 *
 * The Lily58 is an opensource column-staggered 58-key split keyboard.
 * I wanted a versatile and portable yet sturdy case that is easy to transport,
 * lightweight, hassle-free operation in different usecases (e.g. in public
 * transport, at a desk, from bed), allows for adjustable tenting, has space
 * for sound-dampening material, and remaining firm in all scenario.
 *
 * I believe the best approach to the above criteria is minimalism and embedding magnets.
 *
 * Hence, I designed my own case from the ground up with this in mind. The design is
 * parameterized such that it is easily adaptable to different design philosophy
 * (e.g. high-profile / low-profile), different hardware components (e.g. screw
 * dimensions), and even completely different keyboards (by replacing the SVG files)!
 *
 * Furthermore, besides robustness during transportation, the embedded magnets provides
 * a solid base creating accessory modules (e.g. tenting legs).
 *
 * This file is divided in clearly marked sections, where only the first two are
 * be relevant for most users. The reference model (`reference.svg`) is taken from
 * the original design: https://github.com/kata0510/Lily58
 *
 * Happy printing! :)
 *
 * NOTE: Units are in mm and the design is the right-hand side.
 */


////
// Objects - toggle which case parts to draw!
////

bottom();
//tenting_legs();
//cover();
//pcb_cover_screw_spacers();


////
// Input parameters - this is where changes to the case specifications are made!
////

THICKNESS = 3;

TOLERANCE = 0.3;

TOP_COVER_PCB_DISTANCE = 6;

PLATE_BOTTOM_DISTANCE = 8;

PLATE_THICKNESS = 1.5;

PCB_THICKNESS = 1.5;

WALL_HEIGHT_FROM_PLATE = 7.2; // 0 for low profile

SCREW_HEAD_HEIGHT = 1.25;

SCREW_LENGTH = 5;

SCREW_HEAD_DIAMETER = 4;

SCREW_SHANK_DIAMETER = 2;

MODULE_SCREW_HEAD_HEIGHT = 1.6; // halcyon specific

MODULE_SCREW_SHANK_DIAMETER = 1.5; // halcyon specific

MODULE_SCREW_HEAD_DIAMETER = 3; // halcyon specific

MAGNET_DIAMETER = 7;

MAGNET_HEIGHT = 2;

MAGNET_TOLERANCE = 0.2;

TOP_CONNECTOR_CORNER_OFFSET = 10.5;

SIDE_CONNECTOR_CORNER_OFFSET = 13.5;

TENT_MAGNET_EXTEND = 2;

TENT_ANGLE = 30;

TENT_LEG_FEET_HEIGHT = 1.75;

DPI = 96; // SVG encoding

LENGTH_TO_TENT_LEG_MIDDLE = 95.5; // approximated from the SVGs

SIZE_BETWEEN_LEGS_AND_MAGNETS = 8.6; // approximated from the SVGs


////
// Calculated parameters - automatically adjusted based on the input parameters!
////

SCREW_HEAD_OFFSET_RADIUS = (SCREW_HEAD_DIAMETER - SCREW_SHANK_DIAMETER) / 2;

MODULE_SCREW_HEAD_OFFSET_RADIUS =
    (MODULE_SCREW_HEAD_DIAMETER - MODULE_SCREW_SHANK_DIAMETER) / 2;

WALL_HEIGHT = PLATE_BOTTOM_DISTANCE + PLATE_THICKNESS + THICKNESS + WALL_HEIGHT_FROM_PLATE;

CONNECTOR_CUTOUT_HEIGHT = PLATE_BOTTOM_DISTANCE + PLATE_THICKNESS;

COVER_SPACER_HEIGHT = max(0, (2 * SCREW_LENGTH) + TOLERANCE - TOP_COVER_PCB_DISTANCE
                             - (THICKNESS - SCREW_HEAD_HEIGHT) - PCB_THICKNESS);

MAGNET_OFFSET_RADIUS = (MAGNET_DIAMETER - 1) / 2;

MAGNET_CUTOUT_Z = (THICKNESS - MAGNET_HEIGHT - MAGNET_TOLERANCE) / 2;

COVER_SCREW_Z = THICKNESS - SCREW_HEAD_HEIGHT;

COVER_MODULE_SCREW_Z = THICKNESS - MODULE_SCREW_HEAD_HEIGHT;

TENT_MAGNET_OFFSET_RADIUS = MAGNET_OFFSET_RADIUS + TENT_MAGNET_EXTEND;

TENT_LEGS_TRANSLATION_DISTANCE = SIZE_BETWEEN_LEGS_AND_MAGNETS + TENT_MAGNET_OFFSET_RADIUS;

TENT_HEIGHT = ((LENGTH_TO_TENT_LEG_MIDDLE + THICKNESS + TENT_LEGS_TRANSLATION_DISTANCE)
               * sin(TENT_ANGLE)) - TENT_LEG_FEET_HEIGHT;

TENT_LEGS_ANGLE = (180 - 90 - TENT_ANGLE) - 90; // = -TENT_ANGLE

TENT_LEGS_SUPPORT_HEIGHT = max(TENT_HEIGHT * 0.175, THICKNESS * 3);


////
// Cover - covers up the micro controller!
////

module cover() {
    difference() {
        linear_extrude(height = THICKNESS) {
            import("cover/frame.svg", dpi = DPI);
        }
        linear_extrude(height = THICKNESS) {
            import("cover/screw_cutouts.svg", dpi = DPI);
        }
        translate([0, 0, COVER_SCREW_Z]) {
            linear_extrude(height = SCREW_HEAD_HEIGHT) {
                offset(r = SCREW_HEAD_OFFSET_RADIUS) {
                    import("cover/screw_cutouts.svg", dpi = DPI);
                }
            }
        }
        linear_extrude(height = THICKNESS) {
            import("cover/module_screw_cutout.svg", dpi = DPI);
        }
        translate([0, 0, COVER_MODULE_SCREW_Z]) {
            linear_extrude(height = MODULE_SCREW_HEAD_HEIGHT) {
                offset(r = MODULE_SCREW_HEAD_OFFSET_RADIUS) {
                    import("cover/module_screw_cutout.svg", dpi = DPI);
                }
            }
        }
    }
}


////
// PCB Cover Screw Spacers - extends the spacers between PCB & cover underneath the PCB!
////

module pcb_cover_screw_spacers() {
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
}


////
// Bottom - the main case!
////

module bottom() {
    difference() {
        union() {
            linear_extrude(height = THICKNESS) {
                offset(delta = THICKNESS + TOLERANCE) {
                    import("bottom/frame.svg", dpi = DPI);
                }
            }
            difference() {
                linear_extrude(height = WALL_HEIGHT + TOLERANCE) {
                    offset(delta = THICKNESS + TOLERANCE) {
                        import("bottom/frame.svg", dpi = DPI);
                    }
                }
                linear_extrude(height = WALL_HEIGHT + TOLERANCE) {
                    offset(delta = TOLERANCE) {
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
        translate([TOP_CONNECTOR_CORNER_OFFSET, THICKNESS, THICKNESS]) {
            linear_extrude(height = CONNECTOR_CUTOUT_HEIGHT) {
                offset(delta = TOLERANCE) {
                    import("bottom/connector_cutout.svg", dpi = DPI);
                }
            }
        }
        translate([- THICKNESS, - SIDE_CONNECTOR_CORNER_OFFSET, THICKNESS]) {
            linear_extrude(height = CONNECTOR_CUTOUT_HEIGHT) {
                offset(delta = TOLERANCE) {
                    import("bottom/connector_cutout.svg", dpi = DPI);
                }
            }
        }
        translate([0, 0, MAGNET_CUTOUT_Z]) {
            linear_extrude(height = MAGNET_HEIGHT + MAGNET_TOLERANCE) {
                offset(r = MAGNET_OFFSET_RADIUS) {
                    import("bottom/magnet_cutouts.svg", dpi = DPI);
                }
            }
        }
        translate([0, 0, MAGNET_CUTOUT_Z]) {
            linear_extrude(height = MAGNET_HEIGHT + MAGNET_TOLERANCE) {
                offset(r = MAGNET_OFFSET_RADIUS) {
                    import("bottom/magnet_guide_cutout.svg", dpi = DPI);
                }
            }
        }
    }
}


////
// Tenting Legs - magnetic leg module that tents the bottom case!
////

module tenting_legs() {
    difference() {
        union() {
            translate([TENT_LEGS_TRANSLATION_DISTANCE, 0, 0]) {
                rotate([0, TENT_LEGS_ANGLE, 0]) {
                    linear_extrude(height = TENT_HEIGHT) {
                        import("bottom/tent_legs.svg", dpi = DPI, center = true);
                    }
                    linear_extrude(height = TENT_LEGS_SUPPORT_HEIGHT) {
                        hull() {
                            import("bottom/tent_legs.svg", dpi = DPI, center = true);
                        }
                    }
                }
                hull() {
                    rotate([0, TENT_LEGS_ANGLE, 0]) {
                        linear_extrude(height = TENT_LEGS_SUPPORT_HEIGHT) {
                            hull() {
                                import("bottom/tent_legs.svg", dpi = DPI, center = true);
                            }
                        }
                    }
                    linear_extrude(height = THICKNESS) {
                        hull() {
                            import("bottom/tent_legs.svg", dpi = DPI, center = true);
                        }
                    }
                }
            }
            linear_extrude(height = THICKNESS) {
                offset(r = TENT_MAGNET_OFFSET_RADIUS) {
                    hull() {
                        import("bottom/magnet_cutouts.svg", dpi = DPI, center = true);
                    }
                }
            }
        }
        translate([0, 0, MAGNET_CUTOUT_Z]) {
            linear_extrude(height = MAGNET_HEIGHT + MAGNET_TOLERANCE) {
                offset(r = MAGNET_OFFSET_RADIUS) {
                    import("bottom/magnet_cutouts.svg", dpi = DPI, center = true);
                }
            }
        }
        translate([-500, -500, -1000]) {
            cube([1000, 1000, 1000]);
        }
    }
}