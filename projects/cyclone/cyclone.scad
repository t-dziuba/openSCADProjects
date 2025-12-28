// Cyclone Dust Collector for Karcher WD3/WD2
// Designed for PVC 110mm pipe with rubber caps

include <../../libs/BOSL/transforms.scad>
include <../../libs/BOSL/shapes.scad>

// Parameters
pvc_outer_diameter = 110;
pvc_inner_diameter = 100;
pvc_wall_thickness = 2;

vacuum_hose_diameter = 35;
dust_hose_diameter = 40;

cyclone_height = 100;
cyclone_top_diameter = 130;
cyclone_bottom_diameter = 110;

inlet_height = 60; // Height where inlet pipe connects
outlet_height = 95; // Height where outlet pipe connects

wall_thickness = 3;

// Main cyclone body
module cyclone_body() {
  difference() {
    // Outer cone
    cylinder(h=cyclone_height, d1=cyclone_bottom_diameter, d2=cyclone_top_diameter, $fn=100);
    
    // Inner cone (hollow)
    translate([0, 0, -1])
    cylinder(h=cyclone_height+2, 
         d1=cyclone_bottom_diameter-wall_thickness*2, 
         d2=cyclone_top_diameter-wall_thickness*2, 
         $fn=100);
    
    // Hole for inlet pipe in the side wall
    translate([cyclone_top_diameter/2, 0, inlet_height]) {
      rotate([0, 90, 0]) {
        rotate([0, 0, -20]) {
          rotate([15, 0, 0]) {
            translate([0, 0, -25])
            cylinder(h=35, d=dust_hose_diameter - wall_thickness*2 - 2, $fn=50);
          }
        }
      }
    }
  }
}

// Inlet pipe connector (tangential entry for cyclone effect)
module inlet_connector() {
  // Position on side of cyclone, tangential for swirl effect
  translate([cyclone_top_diameter/2, 0, inlet_height]) {
    rotate([0, 90, 0]) {
      rotate([0, 0, -20]) { // Angled for tangential entry
        difference() {
          union() {
            // Straight pipe angled slightly downward
            rotate([15, 0, 0]) {
              // Main outer pipe - extends inward to meet cyclone wall
              translate([0, 0, -15])
              cylinder(h=68, d=dust_hose_diameter - 2, $fn=50);
              // Flange at outer end (where hose connects)
              translate([0, 0, 53])
              cylinder(h=3, d=dust_hose_diameter + 4, $fn=50);
              // Groove for clamp
              translate([0, 0, 43])
              cylinder(h=3, d=dust_hose_diameter - 1, $fn=50);
              // Reinforcement fillet where pipe enters cyclone wall
              rotate([-16, 0, 0]) {
                translate([0, 0, -9])
                difference() {
                  cylinder(h=10, d1=dust_hose_diameter + 10, d2=dust_hose_diameter - 2, $fn=50);
                  translate([0, 0, -2])
                  cylinder(h=12, d=dust_hose_diameter - 2 - wall_thickness*2, $fn=50);
                }
              }
            }
          }
          // Inner hole - creates the tube
          rotate([15, 0, 0]) {
            translate([0, 0, -16])
            cylinder(h=78, d=dust_hose_diameter - 2 - wall_thickness*2, $fn=50);
          }
        }
      }
    }
  }
}

// Outlet pipe connector (center top - to vacuum)
module outlet_connector() {
  translate([0, 0, outlet_height]) {
    difference() {
      union() {
        // Main outer pipe (slightly smaller than hose inner diameter for tight fit)
        cylinder(h=70, d=vacuum_hose_diameter - 2, $fn=50);
        // Flange at base to prevent hose from sliding off
        cylinder(h=3, d=vacuum_hose_diameter + 4, $fn=50);
        // Groove for clamp near the end
        translate([0, 0, 60])
        cylinder(h=3, d=vacuum_hose_diameter - 1, $fn=50);
      }
      // Inner hole
      translate([0, 0, -1])
      cylinder(h=72, d=vacuum_hose_diameter - wall_thickness*2 - 4, $fn=50);
    }
  }
}

// Bottom flange for PVC pipe connection
module bottom_flange() {
  difference() {
    union() {
      // Flange
      cylinder(h=5, d=pvc_outer_diameter + 20, $fn=100);
      // Pipe connector
      translate([0, 0, 5])
      cylinder(h=30, d=pvc_outer_diameter + 2, $fn=100);
    }
    // Inner hole for PVC pipe
    translate([0, 0, -1])
    cylinder(h=40, d=pvc_outer_diameter - 1, $fn=100);
  }
}

// Top lid with outlet
module top_lid() {
  difference() {
    union() {
      // Main lid (solid top)
      cylinder(h=5, d=cyclone_top_diameter, $fn=100);
      // Center tube extending down into cyclone (70% of cyclone height)
      translate([0, 0, -70])
      cylinder(h=70, d=vacuum_hose_diameter + wall_thickness*2 + 10, $fn=50);
      // Reinforcement fillet around outlet pipe hole (top side)
      translate([0, 0, 5])
      difference() {
        cylinder(h=6, d1=vacuum_hose_diameter + 10, d2=vacuum_hose_diameter - 2 + 0.2, $fn=50);
        translate([0, 0, -1])
        cylinder(h=8, d=vacuum_hose_diameter - 2 + 0.2, $fn=50);
      }
    }
    // Inner hole of center tube
    translate([0, 0, -71])
    cylinder(h=72, d=vacuum_hose_diameter + wall_thickness*2, $fn=50);
    
    // Hole through the lid for outlet pipe - exact fit to outlet connector
    translate([0, 0, -1])
    cylinder(h=13, d=vacuum_hose_diameter - 2 + 0.2, $fn=50);
  }
}

// Assembly
module cyclone_assembly() {

  // top_lid();

  // Main body
  cyclone_body();
  
  // Inlet (tangential)
  inlet_connector();
  
  // Outlet (top center)
  outlet_connector();
  
  // Bottom connection
  bottom_flange();
}

// Display assembly
cyclone_assembly();
// cyclone_body();

// Uncomment to display top lid separately
translate([0, 0, cyclone_height])
top_lid();

echo("Cyclone Dust Collector - Assembly");
echo(str("PVC Pipe: ", pvc_outer_diameter, "mm"));
echo(str("Vacuum Hose: ", vacuum_hose_diameter, "mm"));
echo(str("Dust Collection Hose: ", dust_hose_diameter, "mm"));
