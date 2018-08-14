include <polyScrewThread.scad>

$fn=100;

translate([0, -3, 3]) rotate([90, 0, 0]) clamp();
translate([30, -20, 0]) bolt();
translate([50, -20, 0]) joint();

bolt_thread_d = 12;
joint_thread_d = 10;

module bolt(h=30){
	cylinder(10, r=bolt_thread_d*0.75, $fn=6);
	translate([0, 0, 10]) screw_thread(bolt_thread_d, 4, 55, h-10, PI/2, 2);
}

module clamp() {
	corner_r = 3;
	minkowski_delta = 6;
	d = 24 - minkowski_delta;
	inner_w = 60 + minkowski_delta;
	thickness = 7 - minkowski_delta;
	back_h = 80 - minkowski_delta;
	front_h = 25 - minkowski_delta;
	difference() {
		minkowski()	{
			sphere(r=corner_r);
			union() {
				translate([thickness+corner_r,0,0]) cube([inner_w, d, thickness]);
				translate([corner_r,0,0])cube([thickness, d, front_h]);
				translate([inner_w+thickness+corner_r,0,0])cube([thickness, d, back_h]);
				translate([corner_r,0, front_h])
				rotate([0, 90, 0]) cube([0.1, d, 10]);
			}
		}

		translate([inner_w-minkowski_delta/3, d/2, back_h/1.3])
			rotate([0, 90, 0])
				screw_thread(12+0.6, 4, 55, 16, PI/2, 2);
		
		translate([inner_w/2+minkowski_delta, d/2, -minkowski_delta])
			rotate([0, 0, 0])
				screw_thread(joint_thread_d+0.6, 4, 55, 16, PI/2, 2);
	}
}

module joint(ball_d=15, shaft_h=20, shaft_d=10) {
	// height of the cap we cut off h = R - sqrt(R²-r²) where R = ball radius and r = cylinder radius
	cap_height = (ball_d/2) - sqrt((ball_d/2)*(ball_d/2)-(shaft_d/2)*(shaft_d/2));
	translate([0, 0, -cap_height]) {
		difference() {
			translate([0, 0, ball_d/2]) sphere(d=ball_d);
			cylinder(d=shaft_d, h=ball_d);
		}
	}
	cylinder(d=shaft_d, h=ball_d-cap_height*2);
	translate([0, 0, ball_d-cap_height*2]) screw_thread(shaft_d, 4, 55, shaft_h, PI/2, 2);
}
