use <MCAD/regular_shapes.scad>
linear_extrude(height=40){
    // hole height is 38
    // going for block height of 35
    pentagon(19);
}
translate([50,0,0]){
    linear_extrude(height=40){
        // hole height is 38
        // going for block height of 35
        triangle(23);
    }
}
translate([0,50,0]){
    linear_extrude(height=40){
        resize([40,30])circle(d=1000,$fa=1);
    }
}
