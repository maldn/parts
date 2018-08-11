$fn = 40;
plate_width = 26;
thickness = 5;
clamp_length = 40;
hook_length = 15;


rotate([0, 90, 0]){
    
    
cube([plate_width+(thickness*2), thickness, thickness*2]);
//cube([plate_width*2+thickness, thickness,thickness]);

translate([0, thickness, 0]) cube([thickness, clamp_length, thickness*2]);
    
translate([plate_width+thickness, thickness, 0]) cube([thickness, clamp_length, thickness*2]);
 

translate([(plate_width+thickness), 0, 0]) cube([plate_width+(thickness*2), thickness,thickness*2]);

translate([(plate_width+thickness)*2, 0, 0]) cube([thickness, clamp_length, thickness*2]);
//hook
translate([(plate_width*2+thickness*2-hook_length), clamp_length-thickness, 0]) cube([hook_length, thickness, thickness*2]);

}