/*
 * Assistance to medical research testing placebo
 * effect of the contents of a generalized syringe.
 *
 * The cover can be fitted to a specific syringe
 * according to the following diagram (units in mm):
 *
 *                t1
 *                v
 *               _
 * h1 -> {      | |
 *       {      |=|
 *             / ^ \     } <- h2
 *       {    | d1  |
 *       {    |     |
 *       {    |=====|
 * h3 -> {    |  ^  |
 *       {    | d2  |
 *       {   _|_____|_
 *       {  |_________|  } <- t2
 *          ===========
 *               ^
 *              d3
 */

     // mm
h1 = 20;
h2 = 10;
h3 = 85;

d1 = 10;
d2 = 17;
d3 = 34;

t1 = 2;
t2 = 2;


$fn = 32; // fragments


//------------------------------------//
//--SPECIALIZE-COVER-ABOVE-THIS-LINE--//
//------------------------------------//


let (t3 = (2*t1))
difference()
{

union()
{
    union()
    {
        translate([0, 0, 0])
        {
            cylinder(h3, d=d2+t3);
        };
        translate([0, 0, h3])
        {
            cylinder(h2, d1=d2+t3, d2=d1+t3);
        };
    };
    union()
    {
        resize([d3])
        {
            cylinder(t2, d=d2+t3);
        };
        translate([0, 0, h3+h2])
        {
            cylinder(h1, d=d1+t3);
        };
    };
};

union()
{
    union()
    {
        translate([0, 0, -1])
        {
            cylinder(h3+1.01, d=d2);
        };
        translate([0, 0, h3])
        {
            cylinder(h2, d1=d2, d2=d1);
        };
    };
    translate([0, 0, h3+h2-1])
    {
        cylinder(h1+2, d=d1);
    };
};

};