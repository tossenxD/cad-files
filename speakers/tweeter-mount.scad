/* This file contains a tweeter speaker mount for cylindical
   tweeters, where the tweeter is glued to mount and the
   mount is either glued or screwed to the speaker.
*/

/** PARAMS **/
id = 39; // inner diameter in mm
od = 44; // outer diameter in mm
sd = 4;  // screw diameter in mm (set to -1 if glued)

/** MOUNT **/
difference(){
    union(){
        translate([0, 0, -6]){
            difference(){
                cylinder(h = 10, d = od+3, center = true);
                cylinder(h = 20, d = od+1, center = true);
            };
        };
        difference(){
            union(){
                cylinder(h = 3, d = od+13, center = true);
                cube([od+40, od, 3], center = true);
            };
            cylinder(h = 4, d = id+1, center = true);
        };
    };
    union(){
        translate([(od / 2) + 10, 0, -1]){
            cylinder(h = 6, d = sd+1, center = true);
        }
        translate([-(od / 2) - 10, 0, -1]){
            cylinder(h = 6, d = sd+1, center = true);
        }
    }
}