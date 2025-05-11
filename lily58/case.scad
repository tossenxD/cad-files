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
// Parameter overview
////

DPI = 96;

THICKNESS = 3;

SCREW_HEAD_HEIGHT = 1.25;

TOP_COVER_SCREW_HEAD_HEIGHT = 1.5;

////
// Cover
////

/**/
difference() {
    linear_extrude(height=THICKNESS) {
        import("cover/frame.svg", dpi=DPI);
    }
    linear_extrude(height=THICKNESS) {
        import("cover/lower_shank_cutouts.svg", dpi=DPI);
    }
    translate([0, 0, THICKNESS - SCREW_HEAD_HEIGHT]) {
        linear_extrude(height = SCREW_HEAD_HEIGHT) {
            import("cover/lower_head_cutouts.svg", dpi=DPI);
        }
    }
    linear_extrude(height=THICKNESS) {
        import("cover/upper_shank_cutout.svg", dpi=DPI);
    }
    translate([0, 0, THICKNESS - TOP_COVER_SCREW_HEAD_HEIGHT]) {
        linear_extrude(height = TOP_COVER_SCREW_HEAD_HEIGHT) {
            import("cover/upper_head_cutout.svg", dpi=DPI);
        }
    }
}
/**/

////
// Spacer for the cover underneath PCB
////
/*
SCREW_LENGTH = 5;
THREADED_SPACER_HEIGHT = 6;
PCB_THICKNESS = 1.5;
COVER_SPACER_HEIGHT = max(0, (
    (2 * SCREW_LENGTH) + 0.1 - THREADED_SPACER_HEIGHT -
        (THICKNESS - SCREW_HEAD_HEIGHT) - PCB_THICKNESS));

difference()
{
    linear_extrude(height=COVER_SPACER_HEIGHT) {
        import("cover/pcb_spacer_shell.svg", dpi=DPI);
    }
    linear_extrude(height=COVER_SPACER_HEIGHT) {
        import("cover/pcb_spacer_cutout.svg", dpi=DPI);
    }
}
/**/