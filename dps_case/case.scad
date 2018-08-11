$fn=30;
w = 135;
d = 139;
h = 48;
angle = 30;

if(!true) {
	base();
	front();
	walls();
	top();
}
if(true) {
	base();
	front();
	walls();
}
if(!true) {
	top(standalone=true);
}

module base() {
	
	difference(){
		cube([w, d, 3]);
		// cutouts
		translate([w/2-60, 14,-1]) cube([120, 50, 5]);
		translate([w/2-60, 80,-1]) cube([120, 50, 5]);
		translate([w/2-30, 60,-1]) cube([60, 30, 5]);
		
		//mounts
		translate([w/2, 8, 1]) {
			translate([43, 0, 0]) cylinder(r=3.8, h=5, $fn=6);
			translate([-43, 0, 0]) cylinder(r=3.8, h=5, $fn=6);
			translate([43, 64, 0]) cylinder(r=3.8, h=5, $fn=6);
			translate([-43, 64, 0]) cylinder(r=3.8, h=5, $fn=6);
		}
	}
}

module front() {
	difference() {
		cube([w, d, h]);
		//only front
		translate([-2,-4, -2]) cube([w+4, d+2, h+4]);
		// all walls
		//translate([2,2, -2]) cube([w-4, d-4, h+4]);
	
		//display
		translate([w/2-77/2, d+2, h/2-39/2])
			rotate([90, 0, 0])
				cube([77, 39+5, 6]);
		
		// holes
		translate([15,d+2, h/3])rotate([90, 0, 0])cylinder(6, d=7.6);
		translate([w-15,d+2, h/3])rotate([90, 0, 0])cylinder(6, d=7.6);
		translate([w-15,d+2, h/3*2])rotate([90, 0, 0])cylinder(6, d=7.6);
	}
}
module walls() {
	//intersection() {
		//cube([w, d-2, h]);
		//back
	
		translate([0, 3, 0])rotate([90, 0, 0])linear_extrude(3)honeycomb(w, h, 10, 2);
	//}
		//sides
		rotate([90, 0, 90]) linear_extrude(3)honeycomb(d, h, 10, 2);
		translate([w-3, 0, 0])rotate([90, 0, 90]) linear_extrude(3)honeycomb(d, h, 10, 2);
		
	
}


module top(standalone=false) {
	module _corner() {
		cube([9, 3, 3]);
		cube([3, 9, 3]);
	}
	module _top() {
		//linear_extrude(3)honeycomb(w, d, 10, 2);
		cube([w, d, 3]);
		translate([w/2-78/2, d, 0])
			rotate([90, 0, 0])
				cube([78, 6, 2]);
		translate([3, 3, 3]) rotate([0, 0, 0])  _corner();
		translate([w-3, 3, 3]) rotate([0, 0, 90]) _corner();
		translate([w-3, d-3, 3]) rotate([0, 0, 180]) _corner();
		translate([3, d-3, 3]) rotate([0, 0, 270]) _corner();
	}
	if(!standalone) {
		translate([w, 0, h]) rotate([0, 180, 0]) _top();
	} else {
		_top();
	}
}




/**
 * Honeycomb library
 * License: Creative Commons - Attribution
 * Copyright: Gael Lafond 2017
 * URL: https://www.thingiverse.com/thing:2484395
 *
 * Inspired from:
 *   https://www.thingiverse.com/thing:1763704
 */

// a single filled hexagon
module hexagon(l)  {
	circle(d=l, $fn=6);
}

// parametric honeycomb  
module honeycomb(x, y, dia, wall)  {
	// Diagram
	//          ______     ___
	//         /     /\     |
	//        / dia /  \    | smallDia
	//       /     /    \  _|_
	//       \          /   ____ 
	//        \        /   / 
	//     ___ \______/   / 
	// wall |            /
	//     _|_  ______   \
	//         /      \   \
	//        /        \   \
	//                 |---|
	//                   projWall
	//
	smallDia = dia * cos(30);
	projWall = wall * cos(30);

	yStep = smallDia + wall;
	xStep = dia*3/2 + projWall*2;

	difference()  {
		square([x, y]);

		// Note, number of step+1 to ensure the whole surface is covered
		for (yOffset = [0:yStep:y+yStep], xOffset = [0:xStep:x+xStep]) {
			translate([xOffset, yOffset]) {
				hexagon(dia);
			}
			translate([xOffset + dia*3/4 + projWall, yOffset + (smallDia+wall)/2]) {
				hexagon(dia);
			}
		}
	}
}
