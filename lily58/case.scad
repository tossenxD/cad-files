/*
 * This directory contains a Lily58 case, adapted to the Halcyon Lily58 from splitkb.com.
 *
 * The Lily58 is an opensource column-staggered 58-key split keyboard.
 * I wanted a versatile and portable yet sturdy case that is easy to transport,
 * lightweight, hassle-free operation in different usecases (e.g. in public
 * transport, at a desk, from bed), allows for adjustable tenting, has space
 * for sound-dampening material, and remaining firm in all scenario.
 *
 * I believe the best approach to the above criteria is a minimal case with
 * embedded magnets.
 *
 * Hence, I designed my own case from the ground up with this in mind. The design is
 * parameterized such that it is easily adaptable to different design philosophy
 * (e.g. high-profile / low-profile), different hardware components (e.g. screw
 * dimensions), and even completely different keyboards (by replacing the SVG files)!
 *
 * Furthermore, besides robustness during transportation, the embedded magnets provides
 * a solid base creating accessory modules (e.g. tenting legs, palm rests, etc.).
 *
 * This file is divided in clearly marked sections, where only the ones marked
 * "input parameters" are relevant for most users. The reference model `reference.svg`
 * is taken from the original design: https://github.com/kata0510/Lily58
 *
 * Happy printing! :)
 *
 * NOTE: Units are in mm and the design is the right-hand side.
 */


////
// Objects - toggle which case parts to draw!
////

// The main case:
bottom();

// Cover for the micro controller:
//cover();

// Spacers for the cover screws the going underneath the PCB:
//pcb_cover_screw_spacers();

// Palm rest module that tilts and tents the keyboard case (given the length):
//tented_and_tilted_palm_rest(100);

// Legs for tilting and tenting the keyboard case (DEPRECATED by palm rest):
//tenting_legs();


////
// Input parameters - this is where changes to the case specifications are made!
////

THICKNESS = 3;

TOLERANCE = 0.4;

MAGNET_DIAMETER = 7;

MAGNET_HEIGHT = 2;

MAGNET_TOLERANCE = 0.2;

TENT_ANGLE = 35;

TILT_ANGLE = -10;

LOW_PROFILE = false;

HALCYON_MODULE_SCREW = true;


////
// Input parameters (advanced) - mostly measurements of the SVGs and hardware!
////

PLATE_THICKNESS = 1.5;

PCB_THICKNESS = 1.5;

TOP_COVER_PCB_DISTANCE = 6;

PLATE_BOTTOM_DISTANCE = 8;

WALL_HEIGHT_FROM_PLATE = 7.2;

SCREW_HEAD_HEIGHT = 1.25;

SCREW_LENGTH = 5;

SCREW_HEAD_DIAMETER = 4;

SCREW_SHANK_DIAMETER = 2;

MODULE_SCREW_HEAD_HEIGHT = 1.6; // halcyon specific

MODULE_SCREW_SHANK_DIAMETER = 1.5; // halcyon specific

MODULE_SCREW_HEAD_DIAMETER = 3; // halcyon specific

TOP_CONNECTOR_CORNER_OFFSET = 10.5;

SIDE_CONNECTOR_CORNER_OFFSET = 13.5;

TENT_MAGNET_EXTEND = 2;

TENT_LEG_FEET_HEIGHT = 2;

DPI = 96; // SVG encoding

DISTANCE_TO_MAGNET_CLUSTER_MIDDLE = 95.5; // approximated from the SVGs

SIZE_BETWEEN_LEGS_AND_MAGNETS = 18.6; // approximated from the SVGs

DISTANCE_TO_MAGNET_GUIDE = 32.7; // approximated from the SVGs

DISTANCE_FROM_MAGNET_GUIDE_TO_NEGATIVE_TILT_POINT = 44.4; // approximated from the SVGs

DISTANCE_FROM_MAGNET_GUIDE_TO_POSITIVE_TILT_POINT = 33.5; // approximated from the SVGs

LEG_THICKNESS = 10.2; // approximated from the SVGs


////
// Calculated parameters - automatically adjusted based on the input parameters!
////

SCREW_HEAD_OFFSET_RADIUS = (SCREW_HEAD_DIAMETER - SCREW_SHANK_DIAMETER) / 2;

WALL_HEIGHT = PLATE_BOTTOM_DISTANCE + PLATE_THICKNESS + THICKNESS +
    ((LOW_PROFILE) ? 0 : WALL_HEIGHT_FROM_PLATE);

CONNECTOR_CUTOUT_HEIGHT = PLATE_BOTTOM_DISTANCE + PLATE_THICKNESS;

COVER_SPACER_HEIGHT = max(0, (2 * SCREW_LENGTH) + TOLERANCE - TOP_COVER_PCB_DISTANCE
                             - (THICKNESS - SCREW_HEAD_HEIGHT) - PCB_THICKNESS);

MAGNET_OFFSET_RADIUS = (MAGNET_DIAMETER - 1) / 2;

MAGNET_CUTOUT_Z = (THICKNESS - MAGNET_HEIGHT - MAGNET_TOLERANCE) / 2;

COVER_SCREW_Z = THICKNESS - SCREW_HEAD_HEIGHT;

MODULE_SCREW_HEAD_OFFSET_RADIUS =
    (MODULE_SCREW_HEAD_DIAMETER - MODULE_SCREW_SHANK_DIAMETER) / 2;

COVER_MODULE_SCREW_Z = THICKNESS - MODULE_SCREW_HEAD_HEIGHT;

TENT_MAGNET_OFFSET_RADIUS = MAGNET_OFFSET_RADIUS + TENT_MAGNET_EXTEND;

TENT_LEGS_TRANSLATION_DISTANCE = SIZE_BETWEEN_LEGS_AND_MAGNETS + TENT_MAGNET_OFFSET_RADIUS;

LEG_THICKNESS_FROM_MIDDLE_AFTER_TENT = (LEG_THICKNESS * 0.5) * cos(TENT_ANGLE);

TENT_HEIGHT_UPPER = ((DISTANCE_TO_MAGNET_CLUSTER_MIDDLE + THICKNESS + TOLERANCE +
                      TENT_LEGS_TRANSLATION_DISTANCE - (LEG_THICKNESS * 0.5))
                      * sin(TENT_ANGLE));

TENT_HEIGHT_LOWER = ((DISTANCE_TO_MAGNET_GUIDE + THICKNESS + TOLERANCE - (LEG_THICKNESS * 0.5)
                     ) * sin(TENT_ANGLE));

TENT_LEGS_ANGLE = (180 - 90 - TENT_ANGLE) - 90; // = -TENT_ANGLE

TENT_LEGS_SUPPORT_HEIGHT = max(min(TENT_HEIGHT_LOWER * 0.5, THICKNESS * 3), THICKNESS);

DISTANCE_FROM_MAGNET_GUIDE_TO_CLUSTER_MIDDLE =
                    DISTANCE_TO_MAGNET_CLUSTER_MIDDLE - DISTANCE_TO_MAGNET_GUIDE;

DISTANCE_FROM_MAGNET_GUIDE_TO_UPPER_LEGS_MIDDLE =
        DISTANCE_FROM_MAGNET_GUIDE_TO_CLUSTER_MIDDLE + TENT_LEGS_TRANSLATION_DISTANCE;

DISTANCE_FROM_MAGNET_GUIDE_TO_TILT_POINT =
    TILT_ANGLE <= 0 ?
    DISTANCE_FROM_MAGNET_GUIDE_TO_NEGATIVE_TILT_POINT  + THICKNESS + TOLERANCE :
    -DISTANCE_FROM_MAGNET_GUIDE_TO_POSITIVE_TILT_POINT - THICKNESS - TOLERANCE;


////
// Common modules - used in the other main modules!
////

module magnet_cutouts() {
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
        if (HALCYON_MODULE_SCREW) {
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
        translate([TOP_CONNECTOR_CORNER_OFFSET, THICKNESS, THICKNESS-TOLERANCE]) {
            linear_extrude(height = CONNECTOR_CUTOUT_HEIGHT) {
                offset(delta = TOLERANCE) {
                    import("bottom/connector_cutout.svg", dpi = DPI);
                }
            }
        }
        translate([-THICKNESS, -SIDE_CONNECTOR_CORNER_OFFSET, THICKNESS-TOLERANCE]) {
            linear_extrude(height = CONNECTOR_CUTOUT_HEIGHT) {
                offset(delta = TOLERANCE) {
                    import("bottom/connector_cutout.svg", dpi = DPI);
                }
            }
        }
        magnet_cutouts();
    }
}


////
// Tenting Legs - magnetic leg module that tents the bottom case!
////

module tenting_legs() {
    //----------------------------------------------------------

    module UpperLegs() {
        // Draw legs
        rotate([0, TENT_LEGS_ANGLE, 0]) {
            linear_extrude(height = TENT_HEIGHT_UPPER + 100) {
                import("legs/tent_legs.svg", dpi = DPI, center = true);
            }
            linear_extrude(height = TENT_LEGS_SUPPORT_HEIGHT) {
                hull() {
                    import("legs/tent_legs.svg", dpi = DPI, center = true);
                }
            }
        }
        // Angle between legs and bottom
        hull() {
            rotate([0, TENT_LEGS_ANGLE, 0]) {
                linear_extrude(height = TENT_LEGS_SUPPORT_HEIGHT) {
                    hull() {
                        import("legs/tent_legs.svg", dpi = DPI, center = true);
                    }
                }
            }
            linear_extrude(height = THICKNESS) {
                hull() {
                    import("legs/tent_legs.svg", dpi = DPI, center = true);
                }
            }
        }

    };

    //----------------------------------------------------------

    module UpperMagnetPlate() {
        linear_extrude(height = THICKNESS) {
            offset(r = TENT_MAGNET_OFFSET_RADIUS) {
                hull() {
                    import("bottom/magnet_cutouts.svg", dpi = DPI, center = true);
                }
            }
        }
    };

    //----------------------------------------------------------

    module UpperMagnetCutouts() {
        translate([0, 0, MAGNET_CUTOUT_Z]) {
            linear_extrude(height = MAGNET_HEIGHT + MAGNET_TOLERANCE) {
                offset(r = MAGNET_OFFSET_RADIUS) {
                    import("bottom/magnet_cutouts.svg", dpi = DPI, center = true);
                }
            }
        }
    };

    //----------------------------------------------------------

    module Upper() {
        difference() {
            union() {
                translate([TENT_LEGS_TRANSLATION_DISTANCE, 0, 0]) {
                    UpperLegs();
                }
                if (SIZE_BETWEEN_LEGS_AND_MAGNETS > 10)
                {
                    translate([SIZE_BETWEEN_LEGS_AND_MAGNETS * 0.3, 0, 0]) {
                        UpperMagnetPlate();
                    }
                }
                UpperMagnetPlate();
            }
            UpperMagnetCutouts();
            translate([-500, -500, -1000]) {
                cube([1000, 1000, 1000]);
            }
        }
    };

    //----------------------------------------------------------

    module LowerLegs() {
        // Draw legs
        rotate([0, TENT_LEGS_ANGLE, 0]) {
            linear_extrude(height = TENT_HEIGHT_LOWER + 100) {
                import("legs/tent_legs_lower.svg", dpi = DPI, center = true);
            }
            linear_extrude(height = TENT_LEGS_SUPPORT_HEIGHT) {
                hull() {
                    import("legs/tent_legs_lower.svg", dpi = DPI, center = true);
                }
            }
        }
        // Angle between legs and bottom
        hull() {
            rotate([0, TENT_LEGS_ANGLE, 0]) {
                linear_extrude(height = TENT_LEGS_SUPPORT_HEIGHT) {
                    hull() {
                        import("legs/tent_legs_lower.svg", dpi = DPI, center = true);
                    }
                }
            }
            linear_extrude(height = THICKNESS) {
                hull() {
                    import("legs/tent_legs_lower.svg", dpi = DPI, center = true);
                }
            }
        }

    };

    //----------------------------------------------------------

    module LowerMagnetPlate() {
        linear_extrude(height = THICKNESS) {
            offset(r = TENT_MAGNET_OFFSET_RADIUS) {
                hull() {
                    import("bottom/magnet_guide_cutout.svg", dpi = DPI, center = true);
                }
            }
        }
    };

    //----------------------------------------------------------

    module LowerMagnetCutout() {
        translate([0, 0, MAGNET_CUTOUT_Z]) {
            linear_extrude(height = MAGNET_HEIGHT + MAGNET_TOLERANCE) {
                offset(r = MAGNET_OFFSET_RADIUS) {
                    import("bottom/magnet_guide_cutout.svg", dpi = DPI, center = true);
                }
            }
        }
    };

    //----------------------------------------------------------

    module Lower() {
        difference() {
            union() {
                LowerLegs();
                LowerMagnetPlate();
            }
            LowerMagnetCutout();
            translate([-500, -500, -1000]) {
                cube([1000, 1000, 1000]);
            }
        }
    };

    //----------------------------------------------------------

    module Middle() {
        MIDDLE_HEIGHT = TENT_LEGS_SUPPORT_HEIGHT * 0.7;
        MIDDLE_LENGTH = DISTANCE_FROM_MAGNET_GUIDE_TO_UPPER_LEGS_MIDDLE - MIDDLE_HEIGHT;
        difference(){
            resize([0, 0, MIDDLE_HEIGHT]) {
                hull() {
                    LowerMagnetPlate();
                    translate([MIDDLE_LENGTH, 0, 0]) {
                        LowerMagnetPlate();
                    };
                };
            };
            LowerMagnetCutout();
        }
    }

    //----------------------------------------------------------

    // TODO the tilt is awfully complicated - currently off by +2mm height for tent 40 and tilt -10
    // Follow up on TODO; this module was dropped in favor of the palm rest module.
    difference() {
        rotate([TILT_ANGLE, 0, 0]) {
            translate([0,
                       -DISTANCE_FROM_MAGNET_GUIDE_TO_TILT_POINT,
                       TENT_HEIGHT_LOWER - TENT_LEG_FEET_HEIGHT]) {
                rotate([0, 180 - TENT_LEGS_ANGLE, 0]) {
                translate([LEG_THICKNESS - LEG_THICKNESS_FROM_MIDDLE_AFTER_TENT, 0, 0]) {
                    translate([DISTANCE_FROM_MAGNET_GUIDE_TO_CLUSTER_MIDDLE, 0, 0]) { Upper(); };
                    Lower();
                    Middle();
                }
                }
            }
        }
        translate([-500, -500, -1000]) {
            cube([1000, 1000, 1000]);
        }
    }

    //----------------------------------------------------------
}


////
// Palm rest -- flexible, overengineered, and hard to print!
////

module tented_and_tilted_palm_rest(REST_LENGTH)
{
    //----------------------------------------------------------

    REST_SLOPE = 15; // mm
    REST_WIDTH = 57; // mm
    REST_HEIGHT = 10.250; // mm
    REST_OFFSET = THICKNESS + TOLERANCE;
    DISTANCE_TO_Y = 86 + REST_WIDTH + REST_OFFSET + THICKNESS - TOLERANCE; // mm
    DISTANCE_TO_X = 270 + 84 - (171 + REST_HEIGHT) + THICKNESS - TOLERANCE; // mm
    TENT_ANGLE_PALM = TENT_ANGLE * 1; // deg
    BOTTOM_HEIGHT = WALL_HEIGHT + TOLERANCE + THICKNESS; // mm

    //----------------------------------------------------------

    module tilt(T = TILT_ANGLE) {
        translate([0, DISTANCE_TO_X, 0])
        {
            rotate([T, 0, 0])
            {
                translate([0, -DISTANCE_TO_X, 0])
                {
                    children();
                }
            }
        }
    }

    //----------------------------------------------------------

    module tent(T) {
        translate([DISTANCE_TO_Y, 0, 0])
        {
            rotate([0, T, 0])
            {
                translate([-DISTANCE_TO_Y, 0, 0])
                {
                    children();
                }
            }
        }
    }

    //----------------------------------------------------------

    module solid_bottom() {
        linear_extrude(height = BOTTOM_HEIGHT) {
            offset(delta = THICKNESS + TOLERANCE) {
                import("bottom/frame.svg", dpi = DPI, center = false);
            }
        }
    }

    //----------------------------------------------------------

    module rest() {
        difference() {
            hull() {
                linear_extrude(height = BOTTOM_HEIGHT) {
                    offset(delta = THICKNESS)
                    {
                        import("bottom/frame.svg", dpi = DPI, center = false);
                    }
                }
                linear_extrude(height = BOTTOM_HEIGHT - REST_SLOPE) {
                    offset(r = REST_OFFSET) {
                        translate([0, -REST_LENGTH, 0]) {
                            import("rest/bot.svg", dpi = DPI, center = false);
                        }
                    }
                }
            }
            translate([0, 0, THICKNESS]) {
                solid_bottom();
            }
        }
    }

    //----------------------------------------------------------

    module rest_ledge() {
        LEDGE_OFFSET = 0.5;
        REST_LEDGE_OFFSET_DIFF = REST_OFFSET - LEDGE_OFFSET;
        MAGIC = 2.35;
        LEDGE_HEIGHT = BOTTOM_HEIGHT - (0.6 * REST_SLOPE);
        LEDGE_WIDTH = REST_WIDTH * 0.75;

        module extrude_ledge(name, H, O) {
            linear_extrude(height = H) {
                offset(r = O) {
                    import(name, dpi = DPI, center = false);
                }
            }
        }

        hull() {
            translate([REST_LEDGE_OFFSET_DIFF + MAGIC, -REST_HEIGHT, BOTTOM_HEIGHT - 1]) {
                extrude_ledge("rest/botledge.svg", 1, LEDGE_OFFSET);
            }
            translate([REST_LEDGE_OFFSET_DIFF, -REST_HEIGHT, 0]) {
                extrude_ledge("rest/botledge.svg", 1, LEDGE_OFFSET);
            }
            translate([REST_LEDGE_OFFSET_DIFF, -REST_LENGTH-REST_LEDGE_OFFSET_DIFF, 0]) {
                extrude_ledge("rest/botledge.svg", LEDGE_HEIGHT, LEDGE_OFFSET);
            }
            translate([0, -REST_LENGTH, 0]) {
                extrude_ledge("rest/botledge.svg", THICKNESS, REST_OFFSET);
            }
            translate([LEDGE_WIDTH, -REST_LENGTH, 0]) {
                extrude_ledge("rest/botleg.svg", THICKNESS, REST_OFFSET);
            }
        }
    }

    //----------------------------------------------------------

    module rest_palm() {
        union()
        {
            difference() {
                rest();
                solid_bottom();
            }
            rest_ledge();
        }
    }

    //----------------------------------------------------------

    module rest_bottom() {
        difference() {
            rest();
            rest_palm();
        }
    }

    //----------------------------------------------------------

    module adjusted_rest_palm() {
        difference()
        {
            tent(TENT_ANGLE_PALM) { tilt(){ rest_palm(); } }
            tent(TENT_ANGLE)
            {
                tilt()
                {
                    translate([0, 0, THICKNESS]) {
                        solid_bottom();
                    }
                }
            }
        }
    }

    //----------------------------------------------------------

    module adjusted_rest_bottom() {
        tent(TENT_ANGLE)
        {
            tilt()
            {
                difference()
                {
                    tilt(-TILT_ANGLE)
                    {
                        difference()
                        {
                            hull() {
                                tilt(TILT_ANGLE){ rest_bottom(); }
                                rest_bottom();
                            }
                            tilt() { rest_palm(); }
                            rest_palm();
                        }
                    }
                    translate([0, 0, MAGNET_CUTOUT_Z])
                    {
                        magnet_cutouts();
                    }
                    translate([0, 0, MAGNET_CUTOUT_Z*2])
                    {
                        magnet_cutouts();
                    }
                }
            }
        }
    }

    //----------------------------------------------------------

    module adjusted_legs() {
        MAGIC = 0.2;

        module extrude_leg(name) {
            linear_extrude(height = THICKNESS) {
                offset(r = REST_OFFSET) {
                    import(name, dpi = DPI, center = false);
                }
            }
        }

        module adjust_leg_in(T) {
            hull() {
                tent(T) { tilt() { children(); } }
                translate([0, 0, MAGIC]) { children(); }
            }
        }

        module adjust_leg_out(T, scale = 1) {
            hull() {
                tent(T) { tilt() { children(); } }
                translate([scale*LEG_THICKNESS, 0, MAGIC]) { children(); }
            }
        }

        adjust_leg_in(TENT_ANGLE_PALM) {
            translate([0, -REST_LENGTH, 0]) { extrude_leg("rest/botleg.svg"); }
        }

        adjust_leg_out(TENT_ANGLE_PALM, 3.5) {
            translate([REST_WIDTH - LEG_THICKNESS, -REST_LENGTH, 0]) {
                extrude_leg("rest/botleg.svg");
            }
        }

        adjust_leg_out(TENT_ANGLE, 1) { extrude_leg("rest/leg0.svg"); }
        adjust_leg_out(TENT_ANGLE, 2) { extrude_leg("rest/leg1.svg"); }

        adjust_leg_in(TENT_ANGLE) { extrude_leg("rest/leg2.svg"); }
        adjust_leg_in(TENT_ANGLE) { extrude_leg("rest/leg3.svg"); }
    }

    //----------------------------------------------------------

    module rest_support() {
        difference()
        {
            hull()
            {
                tent(TENT_ANGLE_PALM)
                {
                    tilt()
                    {
                        linear_extrude(height = THICKNESS) {
                            offset(r = REST_OFFSET) {
                                translate([0, - REST_LENGTH, 0]) {
                                    import("rest/bot.svg", dpi = DPI, center = false);
                                }
                            }
                        }
                    }
                }
                adjusted_rest_bottom();
            }
            tent(TENT_ANGLE) { tilt() { solid_bottom(); } }
        }
    }

    //----------------------------------------------------------

    adjusted_rest_palm();
    adjusted_rest_bottom();
    adjusted_legs();
    rest_support();

    // Enable to inspect case on top of the rest.
    if (false)
    {
        tent(TENT_ANGLE) { tilt() { translate([0, 0, THICKNESS]) { bottom(); } } }
    }

    //----------------------------------------------------------
}
