/*
 * A simple hasp to hold the lid on my record player inside a shelf.
 */

h=4; // height
s=4; // screw-diameter
o=50; // outer rim radius
i=40; // inner rim radius
n=20; // notch height

$fn=50;

difference()
{
    cylinder(h, r = o, center = true);
    cylinder(h, r = i, center = true);
    translate([-o, 0, -0.5*h]){ cube([o,o,h]); }
    translate([-o, -o, -0.5*h]){ cube([o,o,h]); }
    translate([0, -o, -0.5*h]){ cube([o,o,h]); }
    translate([o-((o-i)*0.5), 0.5*s+2, 0]){ cylinder(h, d = s, center = true); }
    translate([o-((o-i)*0.5), 0.5*s+2, h*0.25]){ cylinder(h*0.5, d1=s, d2=s+2, center=true); }
}
translate([0.5*h, (0.5*(o-i))+i, 0.5*(n-h)]){ notch(); }

module notch()
{
    resize([h, o-i-1, n])
    {
        minkowski()
        {
            cube([1, o-i-h-1, n-h], center = true);
            sphere(d = h);

        }
    }
}