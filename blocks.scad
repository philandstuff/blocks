use <MCAD/regular_shapes.scad>
linear_extrude(height=40){
    // hole height is 38
    // going for block height of 35
    offset(r=3)pentagon(15);
}
translate([50,0,0]){
    linear_extrude(height=40){
        // hole height is 38
        // going for block height of 35
        offset(r=3)triangle(17);
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