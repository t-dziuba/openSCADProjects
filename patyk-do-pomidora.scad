translate([0,0,0]) {
    union() {
        cube([8, 290, 8], false);
        translate([0,15,0]) {
            union() {
                cube([28, 8, 8], false);
                 translate([20,-6,0]) {
                    cube([8, 6, 8], false);
                 }
            }
        }
    }
}
