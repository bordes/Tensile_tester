module beam(h=10,size=10)
{

	scale([size/10,size/10,1])linear_extrude(file = "BeamOutline.dxf", 
  height = h, center = false);
	 
		
}

beam(h=10,size=20); 
translate([15,0,0]) beam(h=30); 
translate([30,0,0]) beam(h=40); 
cube([10,10,10]);