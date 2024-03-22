/** BODY PARAMS **/
l = 210;        // length in mm
w = 160;        // width in mm
a = 15;         // angle in degrees
h = tan(a) * l; // height in mm
t = 25;         // thickness in mm

/** REAR PARAMS **/
rw = w;  // width in mm
rl = 25; // length in mm
rh = h/2; // height in mm


/** BODY **/
difference(){
 hull(){
  polyhedron(//0       1       2       3       4       5       6
       points=[[0,0,0],[w,0,0],[w,l,0],[0,l,0],[w,0,0],[w,l,h],[0,l,h]],
       faces=[[0,1,2,3], [0,1,5,6], [2,3,5,6], [0,3,6], [1,2,5]]);
 }
 translate([t, t + (cos(a) * rl), -1]){
     cube([w - t - t, l - t - t - (cos(a) * rl), h + 2]);
 }
}

/** REAR **/
resize([0,0,rh]){
 difference(){
  rotate([a, 0, 0]) {
      cube([rw, rl, rh]);
  }
  translate([-1, -rh, -1]) {
      cube([rw + 2, rh, rh * 2 + 2]);
  }
 }
}