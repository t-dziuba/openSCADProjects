use <MCAD/regular_shapes.scad>
use <MCAD/nuts_and_bolts.scad>
use <MCAD/screw.scad>
use <BOSL/shapes.scad>
use <obiscad/bcube.scad>
use <obiscad/bevel.scad>
use <BOLTS/bolts.scad>
include <MCAD/units.scad>
include <BOSL/constants.scad>

module handle() {
    union() {
        translate([32.5*mm, 27*mm, 10*mm]) {
            bcube([75*mm, 55*mm, 5*mm], 8*mm, 10*mm);
        }
        translate([61.5*mm, 27*mm, -30*mm]) {
            bcube([17*mm, 55*mm, 85*mm], 8*mm, 10*mm);
        }

        translate([75*mm, 27*mm,-72*mm]) {
            bcube([175*mm, 55*mm, 9*mm], 8*mm, 10*mm);
        }
    }

}

module nutHoleInHandle() {
    difference() {
        handle();
        translate([75*mm, 27*mm,-72*mm]) {
            nutHole(8);
        }
    }
}

// handle();

nutHoleInHandle();

ball_groove(100, 300, 10);
