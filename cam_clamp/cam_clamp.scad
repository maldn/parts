include <polyScrewThread.scad>

$fn=10;

//joint();
rotate([90, 0, 0]) {
	clamp();
}
module clamp() {
	corner_r = 3;
	minkowski_delta = 6;
	d = 30 - minkowski_delta;
	inner_w = 50;
	thickness = 10 - minkowski_delta;
	back_h = 120 - minkowski_delta;
	front_h = 80 - minkowski_delta;
	
	minkowski() {
		sphere(r=corner_r);
		union() {
			translate([corner_r*2,0,0])cube([inner_w, d, thickness]);
			translate([corner_r,0,0])cube([thickness, d, front_h]);
			translate([inner_w+thickness,0,0])cube([thickness, d, back_h]);
		}
	}
}

module joint(ball_d=15, shaft_h=30, shaft_d=10) {
	// height of the cap we cut off h = R - sqrt(R²-r²) where R = ball radius and r = cylinder radius
	cap_height = (ball_d/2) - sqrt((ball_d/2)*(ball_d/2)-(shaft_d/2)*(shaft_d/2));
	translate([0, 0, -cap_height]) {
		difference() {
			translate([0, 0, ball_d/2]) sphere(d=ball_d);
			cylinder(d=shaft_d, h=ball_d);
		}
	}
	cylinder(d=shaft_d, h=shaft_h);
}
