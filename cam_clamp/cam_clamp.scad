include <polyScrewThread.scad>

$fn=100;

ball_d=15;
shaft_h = 30;
shaft_d = 10;

joint();

module joint() {
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
