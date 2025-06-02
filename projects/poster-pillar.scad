/*
    Poster Pillar (Litfaßsäule) in 1/35 scale
    Real dimensions: 160x160x340 cm
    Scale: 1/35
    Reference: https://www.komserwis.pl/files/komserwis/products/technical/Wenecja-advertising-column-009508-s.jpg
*/
include <../libs/BOSL/transforms.scad>
include <../libs/BOSL/constants.scad>
use <../libs/BOSL/shapes.scad>
use <../libs/BOSL/beziers.scad>

$fn=96; // smoothness

// Scale factor
scale_factor = 1/35;

// Real dimensions in mm
pillar_diameter = 1600;
pillar_height = 3400;

// Scaled dimensions
d = pillar_diameter * scale_factor;
h = pillar_height * scale_factor;

// Approximate proportions from schema
base_height = 200 * scale_factor;
body_height = 2700 * scale_factor;
cap_height = 500 * scale_factor;

base_d = d * 1.15; // base is wider
cap_d = d * 1.25;  // cap is widest
cap_ring_h = cap_height*0.25; // height of the ring part of the cap
top_ball_r = cap_d / 12;

module pillar() {
  translate([0,0,base_height]){
    difference() {
      cylinder(h=body_height, d=d);
      cylinder(h=body_height, d=d - 2);
    }
  }
}

module base() {
  cylinder(h=base_height, d=base_d - 3.2);
  torus(r=(base_d / 2) - 2, r2=3);

  up(5.2){
    torus(r=(base_d / 2) - 4, r2=2.8);
  }

  up(0.25){
    cyl(l=2.5, d=base_d + 3, fillet=0.75);
  }

  down(3) {
    cylinder(h=3, d=base_d + 3);
  }
}

module cap() {
  top = base_height + body_height;
  cap_ring_fillet = floor(cap_ring_h / 2);

  up(top) {
    union() {
      // Cap ring
      cyl(l=cap_ring_h, d=cap_d, fillet=cap_ring_fillet);
      dome();
    }
  }
}

module dome() {
  semisphere_r = cap_d - 3;
  semisphere_h = semisphere_r * 0.75; // height of the dome

  difference() {
    union() {
      difference() {
        down(semisphere_h / 4) {
          sphere(semisphere_r / 2);
        }

        down(semisphere_h - 2) {
          cylinder(h=semisphere_h, d=semisphere_r);
        }
      }

      // top ball
      up(cap_ring_h + (semisphere_h / 4) + top_ball_r) {
        sphere(r=top_ball_r);
      }
    }
  }
}

module poster_pillar() {
  base();

  pillar();

  cap();
}

poster_pillar();
