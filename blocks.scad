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

translate([29.8,-8,0])
{
rule(100,dir=[1,0,0]);
}
translate([50,-14.25,0])
{
rule(100,dir=[0,1,0]);
}

use <MCAD/regular_shapes.scad>
linear_extrude(height=40){
    // hole height is 38
    // going for block height of 35
    offset(r=3)pentagon(15);
}
translate([50,0,0]){
    linear_extrude(height=40){
        // hole model
        // offset(r=5)triangle(16.5);
        offset(r=3.5)triangle(16.5);
    }
}
translate([0,50,0]){
    linear_extrude(height=40){
        resize([40,30])circle(d=1000,$fa=1);
    }
}
translate([60,50,0]){
    intersection(){
        linear_extrude(height=40)
            circle(d=48,$fa=1);
        linear_extrude(height=40)
            translate([-24,0,0])
                square(48);
    }
}