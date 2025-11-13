/* This file contains a desktop speaker stand that serves
   two purposes; (I) get the speaker off the desk (possibly
   onto some foam or other anti-vibrational material), and
   (II) tilt the speaker towards your ear.
*/

/** BODY PARAMS **/
l = 210;   // length (along desk) in mm
w = 160;   // width in mm
a = 15;    // angle in degrees
t = 20;    // thickness in mm
p = true ; // pillars / solid shape
s = 8;     // support frame height in mm (only if p)
f = true ; // with / without front pillar (only if p)

/** REAR PARAMS **/
rl = 20; // length (along tilted surface) in mm
rh = 20; // height in mm

/** AUTO-TUNED BODY PARAMS **/
h = tan(a) * l;                 // height in mm
hl = l - t - t - (cos(a) * rl); // hole length in mm
hw = w - t - t;                 // hole width in mm
ho = t + (cos(a) * rl);         // hole offset in mm

/** AUTO-TUNED REAR PARAMS **/
rw = w;                          // width in mm
aro = rh - (sin(90-a) * (rh*2)); //after-rotation-offset (z axis) in mm

/** MAIN **/
if (p) {
 difference(){
  union(){
   body();
   rear();
  }
  pillars();
 }
} else {
 body();
 rear();
}

/** MODULES **/
module body(){
difference(){
 hull(){
  polyhedron(//0       1       2       3       4       5       6
       points=[[0,0,0],[w,0,0],[w,l,0],[0,l,0],[w,0,0],[w,l,h],[0,l,h]],
       faces=[[0,1,2,3], [0,1,5,6], [2,3,5,6], [0,3,6], [1,2,5]]);
 }
 translate([t, ho, -1]){
     cube([hw, hl, h + 2]);
 }
}
}

module rear(){
difference(){
 translate([0,0,aro]){
  rotate([a, 0, 0]) {
      cube([rw, rl, rh*2]);
  }
 }
 union(){
  translate([-1, - rh, - rh]) {
      cube([rw + 2, rh, rh * 3]);
  }
  translate([-1, - 1, - (rh*2)]) {
      cube([rw + 2, rl*2, rh*2]);
  }
 }
}
}

module pillars(){
union(){
 union(){
  union(){
   union(){ // left structure frame
    translate([-1, ho + (2*(hl/3)), s]){
        cube([t+2, hl/3, h]);
    }
    translate([-1, ho, s]){
        cube([t+2, hl/3, h]);
    }
   }
   union(){ // right structure frame
    translate([hw + t - 1, ho + (2*(hl/3)), s]){
        cube([t+2, hl/3, h]);
    }
    translate([hw + t - 1, ho, s]){
        cube([t+2, hl/3, h]);
    }
   }
  }
  if(f) { // front structure frame
   union(){
    translate([t, ho + hl-1, s]){
        cube([hw/3, t+2, h]);
    }
    translate([t + (2 * (hw/3)), ho + hl-1, s]){
        cube([hw/3, t+2, h]);
    }
   }
  } else {
   translate([t, ho + hl-1, s]){
       cube([hw, t+2, h]);
   }
  }
 }
 union(){ // back structure frame
  translate([t, -1, s]){
      cube([hw/3, ho+2, h]);
  }
  translate([t + (2 * (hw/3)), -1, s]){
      cube([hw/3, ho+2, h]);
  }
 }
}
}

