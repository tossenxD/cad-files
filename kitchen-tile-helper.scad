/* This file contains a base and a shell that, when put together,
   can be used to streamline the process of making angled kitchen tiles
   from clay (i.e. you are supposed to shape the tile with a bit more
   height than the shell, and then run a knife along the shell edges to
   get uniform angle). (Un)comment shell/base after need.
*/

/** PARAMS **/
hb = 28.8; // height of base in mm (i.e. offset from table)
h = 3.2;   // height of tile (bottom to angle)
a = 40;    // angle of tile
l = 170;   // length of tile
w = 85;    // width of tile

/** AUTO-TUNED PARAMS **/
hs = hb + h;      // height of shell
ws = tan(a) * hs; // width of shell

/** SHELL **/
difference(){
 hull(){
  polyhedron(
   points=[[0,0,0],[l+(2*ws),0,0],[l+(2*ws),w+(2*ws),0],[0,w+(2*ws),0],
           [ws,ws,hs],[l+ws,ws,hs],[l+ws,w+ws,hs],[ws,w+ws,hs]],
   faces =[[0,1,2,3],[0,1,5,4],[1,2,6,5],[2,3,7,6],[3,0,4,7],[4,5,6,7]]);
 }
 translate([ws,ws,-1]){cube([l,w,hs+3]);}
}

/** BASE **/
// cube([l-1, w-1, hb]);
