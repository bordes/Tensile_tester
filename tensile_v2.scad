use <Beam.scad>;
include <MCAD/motors/stepper.scad>
//include <MCAD/motors/stepper_mount.scad>
include <MCAD/shapes/boxes.scad>
include <MCAD/fasteners/threads.scad>
include <MCAD/hardware/linear_bearing.scad>
include <coupler.scad>

res=16;

module roundedCube( dimensions = [10,10,10], cornerRadius = 1, faces=32 ) {
	hull() cornerCylinders( dimensions = dimensions, cornerRadius = cornerRadius, faces=faces ); 
}

module cornerCylinders( dimensions = [10,10,10], cornerRadius = 1, faces=32 ) {
	translate([ cornerRadius, cornerRadius, 0]) {
		cylinder( r = cornerRadius, $fn = faces, h = dimensions[2] );
		translate([dimensions[0] - cornerRadius * 2, 0, 0]) cylinder( r = cornerRadius, $fn = faces, h = dimensions[2] );
		translate([0, dimensions[1] - cornerRadius * 2, 0]) {
			cylinder( r = cornerRadius, $fn = faces, h = dimensions[2] );
			translate([dimensions[0] - cornerRadius * 2, 0, 0]) cylinder( r = cornerRadius, $fn = faces, h = dimensions[2] );
		}
	}
}


module ball_screw(){
    color("grey")cylinder(d=10,h=15,$fn=res);
    color("red")translate([0,0,15])acme_thread(12, 1, 12, $fn=res);
    color("blue")translate([0,0,27])cylinder(d=12,h=27,$fn=res);
    translate([0,0,12+15+27])acme_thread(16, 5, 185, $fn=res);
    
    color("grey")translate([0,0,239])cylinder(d=10,h=11,$fn=res);
}

module ball_nut(){
    import("/Ball_nut/ball_nut.stl");
}




module BF12(){
    import("/BF12/BF12.stl");
    translate([17,12,6])import("/BF12/bearing_BF12.stl");
}

module BK12(){{
    translate([0,0,0])import("/BK12/BK12-1.stl");
    translate([0,0,22]){
    translate([18,13,-2])import("/BK12/BK12-2.stl");
    translate([22,17,-2])import("/BK12/BK12-3.stl");
    translate([13,8,-27])import("/BK12/BK12-4.stl");
    translate([20.5,15.5,-26])import("/BK12/BK12-5.stl");
    translate([16,11,-10])import("/BK12/bearing_BK12.stl");
    translate([16,11,-18])import("/BK12/bearing_BK12.stl");}}
    
}

module coupler2(){  // to be resized!!!
    import("/coupler/coupler.stl");
}

module coupler_stepper(){
    coupler(hgt = 25,shaftd1 = 5, shaftd2 = 10, slices = 15, springs=5);
}


// Beams

//translate([-50,-10-120,0])beam(h=250,size=20);
//translate([-50,110,0])beam(h=250,size=20);
//
//translate([-50,-10-60,0])beam(h=250,size=20);
//translate([-50,90,0])beam(h=250,size=20);
//
//translate([30,-10-100,0])beam(h=250,size=20);
//translate([30,90,0])beam(h=250,size=20);


//translate([0,0,20])rotate([-90,0,0])beam(h=200,size=20);
//translate([0,0,290])rotate([-90,0,0])beam(h=200,size=20);

//translate([-50,-150,-5])color("grey")roundedCube(dimensions=[100,300,5], cornerRadius= 10);
//


module plate(){
    translate([-50,-190,-5])color("grey")
    difference(){
        roundedCube(dimensions=[380,380,5], cornerRadius= 10);
        translate([100,110,-1])roundedCube(dimensions=[200,160,7], cornerRadius= 10);
    }
}


module z_axis(){
    color("black")translate([-30,286,-25])rotate([90,0,0])BF12();
    color("black")translate([30,60,-25])rotate([90,0,180])BK12();
//    translate([-19,44,19])rotate([180,0,0])coupler();
    translate([0,44,0])rotate([0,90,-90])coupler_stepper();
    translate([0,12,0])rotate([90,0,0])motor(model=Nema17);
    color("lightgrey")translate([0,31,0])rotate([-90,0,0])ball_screw();
    translate([-23,170,20])rotate([180,0,0])ball_nut();
}


module guide_holder(){
    difference(){
        union(){
            cube([60,35,20]);
            translate([13,23,0])cube([34,20,20]);
        }
        translate([30,25,5])cylinder(d=10, h=50, $fn=res);
        translate([-2,0,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([62,0,5])rotate([0,0,-45])cube([5,50,50],center=true);
        translate([62,35,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([-2,35,5])rotate([0,0,-45])cube([5,50,50],center=true);
        translate([43,47,5])rotate([0,0,45])cube([5,25,50],center=true);
        translate([17,47,5])rotate([0,0,-45])cube([5,25,50],center=true);
        translate([8,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
        translate([52,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
    }
}


module guide_holder_left(){
    difference(){
        union(){
            cube([60,35,20]);
            translate([30,23,0])cube([30,20,20]);
        }
        translate([45,25,5])cylinder(d=10, h=50, $fn=res);
        translate([-2,0,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([62,0,5])rotate([0,0,-45])cube([5,50,50],center=true);
        translate([70,35,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([-2,35,5])rotate([0,0,-45])cube([5,50,50],center=true);
//        translate([43,47,5])rotate([0,0,45])cube([5,25,50],center=true);
        translate([32,47,5])rotate([0,0,-45])cube([5,25,50],center=true);
        translate([8,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
        translate([26,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
    }
}

module guide_holder_right(){
    difference(){
        union(){
            cube([60,35,20]);
            translate([30,23,0])cube([30,20,20]);
        }
        translate([45,25,-35])cylinder(d=10, h=50, $fn=res);
        translate([-2,0,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([62,0,5])rotate([0,0,-45])cube([5,50,50],center=true);
        translate([70,35,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([-2,35,5])rotate([0,0,-45])cube([5,50,50],center=true);
//        translate([43,47,5])rotate([0,0,45])cube([5,25,50],center=true);
        translate([32,47,5])rotate([0,0,-45])cube([5,25,50],center=true);
        translate([8,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
        translate([26,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
    }
}

module guide_holder_vertical(){
    difference(){
        union(){
            cube([60,35,20]);
            translate([30,23,0])cube([30,20,20]);
        }
        translate([35,25,10])rotate([0,90,0])cylinder(d=10, h=50, $fn=res);
        translate([-2,0,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([62,0,5])rotate([0,0,-45])cube([5,50,50],center=true);
        translate([70,35,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([-2,35,5])rotate([0,0,-45])cube([5,50,50],center=true);
//        translate([43,47,5])rotate([0,0,45])cube([5,25,50],center=true);
        translate([32,47,5])rotate([0,0,-45])cube([5,25,50],center=true);
        translate([8,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
        translate([26,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
    }
}

module guide_holder_vertical_sw(){
    difference(){
        union(){
            cube([60,35,20]);
            translate([30,23,0])cube([30,20,20]);
        }
        translate([35,25,10])rotate([0,90,0])cylinder(d=10, h=50, $fn=res);
        translate([-2,0,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([62,0,5])rotate([0,0,-45])cube([5,50,50],center=true);
        translate([70,35,5])rotate([0,0,45])cube([5,50,50],center=true);
        translate([-2,35,5])rotate([0,0,-45])cube([5,50,50],center=true);
//        translate([43,47,5])rotate([0,0,45])cube([5,25,50],center=true);
        translate([32,47,5])rotate([0,0,-45])cube([5,25,50],center=true);
        translate([8,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
        translate([26,36,10])rotate([90,0,0])union(){
            cylinder(d=4,h=70,$fn=res);
            cylinder(d=6,h=7,$fn=res);
        }
    }
}

module full_guide(){
    color("black")translate([0,-60,0])rotate([90,0,90])guide_holder();
    color("black")translate([221,-0,0])rotate([90,0,-90])guide_holder(); 
    color("silver")translate([5,-30,25])rotate([0,90,0])cylinder(d=10,h=210);
}


module full_guide_left(){
    color("black")translate([0,-60,0])rotate([90,0,90])guide_holder_left();
    color("black")translate([221-20,-60,0])rotate([90,0,90])guide_holder_right(); 
    color("silver")translate([5,-15,25])rotate([0,90,0])cylinder(d=10,h=210);
}


module full_guide_vertical(){
    color("black")translate([-40,0,0])rotate([90,0,00])guide_holder_vertical();
    color("black")translate([221+40,-20,0])rotate([90,0,180])guide_holder_right(); 
    color("silver")translate([5,-10,25])rotate([0,90,0])cylinder(d=10,h=210);
}


module full_guide_right(){
    color("black")translate([20,-0,0])rotate([90,0,-90])guide_holder_right();
    color("black")translate([221,-0,0])rotate([90,0,-90])guide_holder_left(); 
    color("silver")translate([5,-45,25])rotate([0,90,0])cylinder(d=10,h=210);
}

module load_cell(){
    difference(){
        cube([63.5,50.8,12.7]);
        translate([-5,50.8/2,12.7/2])rotate([0,90,0])cylinder(d=8,h=70,$fn=res);
        translate([10,-5,-1])rotate([0,0,0])cube([12,40,20]);
        translate([16,35,-1])rotate([0,0,0])cylinder(d=12,h=20,$fn=res);
        translate([63.5-22,50.8-35,-1])rotate([0,0,0])cube([12,40,20]);
        translate([63.5-16,50.8-35,-1])rotate([0,0,0])cylinder(d=12,h=20,$fn=res);
    }
    translate([63.5/2,0,12.7/2])rotate([90,0,0])cylinder(d1=8,d=5,h=6,$fn=res);
}


module horizontal_tray(){
    difference(){
        union(){
            cube([42,360,40]);
            translate([0,0,20])rotate([0,90,0])cylinder(d=40,h=42, $fn=res);
            translate([0,360,20])rotate([0,90,0])cylinder(d=40,h=42, $fn=res);
        }
        translate([45,180,20])rotate([0,-90,0])cylinder(d=9,h=50);
        translate([8,180,20])rotate([0,-90,0])cylinder(d=30,h=9);
        translate([0,30,0]){
    translate([0,-30,20])rotate([0,90,0])cylinder(d=35,h=3,$fn=res);
    translate([0,-30,20])rotate([0,90,0])cylinder(d=12,h=50,$fn=res);
    linearBearing(pos=[3,-30,20], angle=[0,90,0], model="LM10UU",
		material=Steel, sideMaterial=BlackPaint);
    }
    translate([0,390,0]){
    translate([0,-30,20])rotate([0,90,0])cylinder(d=35,h=3,$fn=res);
    translate([0,-30,20])rotate([0,90,0])cylinder(d=12,h=50,$fn=res);
    linearBearing(pos=[3,-30,20], angle=[0,90,0], model="LM10UU",
		material=Steel, sideMaterial=BlackPaint);
    }
    
    translate([43,40,0])rotate([0,0,90])ball_nut();
    translate([43,270,0])rotate([0,0,90])ball_nut();
    }
        
    translate([42,180-50.8/2,(40-12.7)/2])color("LightBlue")load_cell();
}


//Final rendering
translate([-15,-115,25])rotate([0,0,-90])z_axis();
translate([-15,115,25])rotate([0,0,-90])z_axis();
translate([50,-150,0])full_guide_vertical();
translate([50,170,0])full_guide_vertical();
plate();

translate([112,-180,5])horizontal_tray();


//full_guide_right();
//full_guide_vertical();

//translate([0,60,0])full_guide_left();
//guide_holder_left();
//translate([80,0,0])guide_holder_right();