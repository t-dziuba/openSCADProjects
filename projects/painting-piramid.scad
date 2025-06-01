// piramid to be used to handle bigger elements edges during painting


module piramid() {
  $fn=4;
  difference() {
    cylinder(55,40,0.1, false);

    translate([0,0,2]) {
      cylinder(51,36, 0, false);
    }
  }
}

module holes() {
  $fn=89;
  union() {
    rotate([45, 90, 0]) {
      translate([-18,0,-30]) {
        cylinder(75, 12, 12, false);
      }
    }

    rotate([-45, 90, 0]) {
      translate([-18,0,-30]) {
        cylinder(75, 12, 12, false);
      }
    }
  }
}

difference() {
    piramid();
    holes();
}
