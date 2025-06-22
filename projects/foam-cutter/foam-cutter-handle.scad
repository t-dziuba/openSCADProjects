include <../../libs/BOSL/shapes.scad>
include <../../libs/BOSL/constants.scad>


$fn = 8;
bar_width = 29; // the width of flat bar - 29mm - in my case
bar_thickness = 3; // the thickness of flat bar
roundness = 2.5;
tollerance = 0.5;
side_width = 8;
screw_width = 3; //M3

function roundCorners(w, h, r) =
  concat(
    [ [r, 0], [w - r, 0] ],
    [ [w, r], [w, h - r] ],
    [ [w - r, h], [r, h] ],
    [ [0, h - r], [0, r] ]
  );

module topPart() {
  points = [
    [0,0],
    [0,bar_thickness * 2],
    [1.2, (bar_thickness * 2) + 2],
    [bar_width + tollerance + 15, (bar_thickness * 2) + 2],
    [bar_width + tollerance + 16.2, (bar_thickness * 2)],
    [bar_width + tollerance + 16.2, 0],
    [bar_width + tollerance + 15, 0],
    [bar_width + tollerance + 15, bar_thickness],
    [15 + tollerance, bar_thickness],
    [15 + tollerance, 0],
    [0,0]
    // [bar_thickness,bar_width + tollerance],
  ];
  paths = [[0,1,2, 3, 4, 5, 6, 7, 8, 9, 10]];
  //  polygon(points, paths, 0);
  polygon(roundCorners(bar_width + (2 * side_width), 4 * bar_thickness, roundness), paths, 0);
}

module bottomPart() {

}

module flatBarHandle() {
    topPart();
}

flatBarHandle();
