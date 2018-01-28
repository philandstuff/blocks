module rule(s,dir=[1,0,0],c1=[1,0.5,0.5],c2=[0,0,1]) {
    l = floor(s);
    r_to(dir)
    scale(1/l)
    for(i=[0:l-1]) {
       colour(i,c1,c2) %
       if(i==0)
         translate([l,0,0]) rotate([0,-90,0]) tip(l);
       else if(i==l-1) // the last tip may longer than 1
         translate([i*l,0,0]) rotate([0,90,0]) tip(l*(1+s-l));
       else if(!i%10 && i!=0) translate([i*l,0,0])
         translate([l-l/4,0,-l/8]) linear_extrude(height=l/4)
            rotate(90) text(str(i),halign="center",size=l/2);
       else
         translate([(i+0.5)*l,0,0]) cube([l,l/2,l/2],center=true);
    }
    module tip(s)
        linear_extrude(height=s, scale=0.01) square(l/2,center=true);
    module colour(i,c1,c2)
        if(i%2) color(c2) children();
        else    color(c1) children();
    module r_to(d) // rotate_from_to
       if(norm(d)<1e-16) rotate([0,-90,0]) children();
       else mirror(d/norm(d)+[1,0,0]) mirror([1,0,0]) children();
}

translate([29,38,0])
{
rule(100,dir=[1,0,0]);
}
translate([55,34,0])
{
rule(100,dir=[0,1,0]);
}

module rounded_semicircle(radius,offset_radius) {
    hull() {
        intersection(){
            circle(r=radius,$fa=1);
            translate([-radius,radius*offset_radius/(radius-offset_radius),0])
                square(2*radius);
        }
        rotate(-asin(offset_radius/(radius-offset_radius)))
        translate([offset_radius-radius,0,0])
            circle(r=offset_radius);
        rotate(asin(offset_radius/(radius-offset_radius)))
        translate([radius-offset_radius,0,0])
            circle(r=offset_radius);
    }
}

use <MCAD/regular_shapes.scad>

// pentagon
difference() {
    linear_extrude(height=40){
        // hole model
        // offset(r=5)pentagon(15);
        offset(r=3.5)pentagon(15);
    }
    linear_extrude(height=38){
        // hole model
        // offset(r=5)pentagon(15);
        offset(r=1.5)pentagon(15);
    }
}

// triangle
translate([50,0,0]){
    difference() {
        linear_extrude(height=40){
            // hole model
            // offset(r=5)triangle(16.5);
            offset(r=3.5)triangle(16.5);
        }
        linear_extrude(height=38){
            // hole model
            // offset(r=5)triangle(16.5);
            offset(r=1.5)triangle(16.5);
        }
    }
}

// ellipse
translate([0,50,0]){
    difference() {
        linear_extrude(height=40){
            resize([40,30])circle(d=1000,$fa=1);
        }
        linear_extrude(height=38){
            resize([36,26])circle(d=1000,$fa=1);
        }
    }
}

// semicircle
translate([55,35,0]){
    difference() {
        linear_extrude(height=40) {
            // hole model
            // rounded_semicircle(26.5,5);
            rounded_semicircle(25,3.5);
        }
        translate([0,2,0])
        linear_extrude(height=38) {
            // hole model
            // rounded_semicircle(26.5,5);
            rounded_semicircle(21,1.5);
        }
    }
}
