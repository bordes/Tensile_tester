// ********** CHANGE THESE PARAMETERS TO ADAPT DIMENSIONS ********** //

// TOTAL HEIGHT
//TOTAL_HEIGHT = 40;
//
//// SHAFT DIAMETERS
//SHAFT_DIAM1 = 5;
//SHAFT_DIAM2 = 8;
//
//// SHAFT_FLAT_DIAMS
//FLAT_DIAM1 = 4.45;
//FLAT_DIAM2 = 8;
//
//// SET SCREW DIAMS
//SET_SCREW_DIAM1 = 3.5;
//SET_SCREW_DIAM2 = 3.5;
//
//// NUT HOLE DIAMETER
//NUT_DIAM1 = 6.5;
//NUT_DIAM2 = 6.5;
//
//// NUT HOLE THICKNESS
//NUT_THICK1 = 2.5;
//NUT_THICK2 = 2.5;
//
//// NUMBER OF SPRINGS
//SPRINGS = 12;
//
//// SPRINGS RESOLUTION
//SLICES = 22; //[6:36]

// ********** DON'T CHANGE BELOW UNLESS YOU KNOW WHAT TO DO ********** //

module sq_spring(N, in_R,out_R,height,rot) {
	width=out_R-in_R;
	linear_extrude(height = height, center = false, convexity = 50, twist = rot, slices = SLICES)
		polygon(
			points=[[in_R,0],
				[out_R,0],
				[out_R*cos(180/N),out_R*sin(180/N)],
				[in_R*cos(180/N),in_R*sin(180/N)]],
			paths=[[0,1,2,3]]
		);
}

module hole_h(od, hdist, screwd, flatoff, nutd, nuth) {
	or = od/2;	// outer radius
	screwr = screwd / 2;
	nutr = nutd/2;	// nut hole radius
	rotate([0,90,0]) {
		translate ([-hdist,0,(or+flatoff)/2]) cylinder(r=screwr,h=or*1.2,center=true,$fn=12);
		translate([-hdist,0,(or+flatoff)/2]) cylinder(r=nutr,h=nuth,center=true,$fn=6);
		translate([0,0,(or+flatoff)/2]) cube(size=[2*hdist,nutd*cos(30),nuth],center=true);
	}
}


module coupler_end(od, id, flatd, hgt, screwd, nutd, nuth) {
	orad = od/2;	// outer radius
	ir = id/2;	// inner radius
	flatoffset = flatd-ir;	// flat face distance from center
	hdist = nutd * 0.67;
	difference() {
		union() {
			difference() {
				cylinder (r=orad,h=hgt,center=false);
				translate ([0,0,-0.1]) cylinder(r=ir,h=hgt+0.2,center=false,$fn=12);
			}
			translate([flatoffset,-ir,0]) cube(size=[ir,id,hgt], center=false);
		}
		hole_h(od, hdist, screwd, flatoffset, nutd, nuth);
	}
}


module coupler(hgt,
	shaftd1, flatd1=-1, screwd1=3.5, nutd1=6.5, nuth1=2.5,
	shaftd2=-1, flatd2=-1, screwd2=3.5, nutd2=6.5, nuth2=2.5,
	springs=12
) {
	flatd1  = (flatd1 < 0)? shaftd1 : flatd1;
	flatd2  = (flatd2 < 0)? flatd1 : flatd2;
	shaftd2 = (shaftd2 < 0)? shaftd1 : shaftd2;
	od = max(flatd1,flatd2) + (max(nuth1,nuth2) * 2) * 3;
    basehgt = max(nutd1,nutd2)*1.5;
	springir = max(shaftd1,shaftd2) / 2;
	springh = hgt-2*basehgt;
	orad = od / 2;
	if (shaftd1 < shaftd2) {
		coupler_end(od,shaftd1,flatd1,basehgt,screwd1,nutd1,nuth1);
		translate([0,0,hgt]) rotate([0,180,0]) coupler_end(od,shaftd2,flatd2,basehgt,screwd2,nutd2,nuth2);
	} else {
		translate([0,0,hgt]) rotate([0,180,0]) coupler_end(od,shaftd1,flatd1,basehgt,screwd1,nutd1,nuth1);
		coupler_end(od,shaftd2,flatd2,basehgt,screwd2,nutd2,nuth2);
	}
	for (i=[1:springs]){
		rotate([0,0,360*i/springs]) translate ([0,0,basehgt]) sq_spring(springs, springir,orad,springh,120);
	}
}

//coupler(
//	hgt     = TOTAL_HEIGHT,
//    springs = SPRINGS,
//	shaftd1 = SHAFT_DIAM1,
//	flatd1  = FLAT_DIAM1,
//	screwd1 = SET_SCREW_DIAM1,
//	nutd1   = NUT_DIAM1,
//	nuth1   = NUT_THICK1,
//	shaftd2 = SHAFT_DIAM2,
//	flatd2  = FLAT_DIAM2,
//	screwd2 = SET_SCREW_DIAM2,
//	nutd2   = NUT_DIAM2,
//	nuth2   = NUT_THICK2
//);
