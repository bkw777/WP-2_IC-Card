// top cover for WP-2 IC Card

// Which style, RAM or ROM ?
// Same but ROM omits the battery
style = "RAM"; // RAM, ROM

bl = 54;    // main body length
bw = 54;    // main body width
card_thickness = 3.0;
pcb_thickness = 1.2;
bh = card_thickness - pcb_thickness;
cr = 2;     // large corner radius
sr = 0.5;   // small corner radius & fillets

// grips
gl = 17.5;  // grip length
gda = 45;   // grip depth angle - 0-90, bigger = deeper finger grips

// components window (or cavity)
ch = 1.2;   // components height
wl = 9;     // components window length
ww = 38;    // components window width
wy = 18.5;  // front edge to window center Y

// polarity notch
nl = 9.5;   // polarity notch length
nd = 0.8;   // polarity notch depth

// battery clip
bcy = 11.5; // board Y center to batt center
btw = 31.5; // tabs width
btt = 0.8;  // tabs thickness
btd = 6;    // tabs depth
bbw = 21;   // batt body width
boh = 1.2;  // batt opening height
brw = 6;    // batt retainer width
brh = 0.4;  // batt retainer height
bby = -0.5; // Y-offset the octagon

// connector
cnw = 48.6; // connector width
cnl = 8.525; // connector depth
cnp = 3;    // connector pins length
cnpt = 0.8; // pin thickness

// these are used to make clean union/difference
o = 1;      // normal overlap/overhang, easily visible with # or %, for things that won't show in the final shape
xo = 0.002; // small as possible overlap/overhang for things that would show in the final shape

//$fn = 32;
$fa = 6;
$fs = 0.2;

include <handy.scad>;

module grips () {
t = o+bh+o;
 mirror_copy([1,0,0])
  translate([-bw/2+cr,bl/2-cr-gl/2,-o]) {
   hull() {
    mirror_copy([0,1,0]) {
     translate([0,gl/2,0]) {
      rotate([0,0,gda])
       translate([-cr*2,0,0]) {
        cylinder(t,cr,cr);
        rotate([0,0,-90+gda])
         fillet_linear(o=false,l=t,r=cr,a=gda);
       }
      }
    }
   }
   mirror_copy([0,1,0])
    translate([0,gl/2,0])
     rotate([0,0,90+gda])
      fillet_linear(o=false,l=t,r=cr+xo,a=gda);
 }
}

module notch () {
 translate([0,0,-(bh-nd)]) {
  hull() {
   cube([sr+sr,sr,bh]);
    translate([0,nl-sr,0])
     cube([sr,sr,bh]);
    translate([sr,nl-sr,0])
     cylinder(bh,sr,sr);
  }
  translate([sr+sr+sr-xo,sr-xo,0])
   rotate([0,0,180])
    fillet_linear(o=false,l=bh,r=sr,a=90);
  translate([sr,sr+nl-xo,0])
   rotate([0,0,180])
    fillet_linear (o=false,l=bh,r=sr,a=90);
  }
}

module battery () {
  t = o+bh+o;
  c = bbw/2;
  a = c * tan(45/2); // side of triangle to make octagon
  
  // solder tabs
  rounded_cube(w=btw,d=btd,h=btt*2,rh=sr,rv=sr,t=0);
  // main holder body
  translate([0,bby,0])
  hull() {
   translate([a,-c,-o]) cylinder(t,sr,sr,);
   translate([-c,-a,-o]) cylinder(t,sr,sr,);
   translate([-c,c,-o]) cylinder(t,sr,sr,);
   translate([c,c,-o]) cylinder(t,sr,sr,);
   translate([c,-a,-o]) cylinder(t,sr,sr);
   translate([-a,-c,-o]) cylinder(t,sr,sr);
  }
  // opening
  ol = bl/2 - bcy + o;
  translate([0,0,-(bh-boh)])
   hull(){
    translate([-c-sr,0,0])
     cube([sr+bbw+sr,ol,0.1]);
    mirror_copy([1,0,0])
     translate([c,ol/2,bh-sr])
      rotate([90,0,0])
       cylinder(h=ol,r=sr,center=true);
   }
}

module batt_retainer () {
   bri = bcy+bbw/2+sr+bby;
   brl = bl/2-bri;
   ww = brl/2;
   translate([-brw/2,bri+ww,boh+xo])
    rotate([-90,0,-90])
     hull() {
      cube([xo,xo,brw]);
      translate([ww-xo,0,0])
       cube([xo,xo,brw]);
      translate([ww-brh/2,brh/2,0])
       cylinder(h=brw,r=brh/2);
     }
}

module connector () {
 t = o+bh+o;
 translate([-cnw/2,0,-o])
  cube([cnw,cnl,t]);
 mirror_copy([1,0,0])
  translate([-cnw/2+sr/2,cnl-sr/2,-o])
   cylinder(h=t,r=sr);
 translate([0,cnp/2+cnl-cnpt/2,0])
  rounded_cube(w=cnw,d=cnp+sr,h=cnpt*2,rh=sr,rv=sr,t=0);
}

module blank () {
 cx = bw/2 - cr;
 cy = bl/2 - cr;
 hull () {
  mirror_copy([1,0,0])
   mirror_copy([0,1,0])
    translate([cx,cy,0])
     cylinder(bh,cr,cr);
 }
}

module cuts () {
 // finger grips
  grips();
 // polarity notch
 translate([-bw/2-xo,-bl/2-xo,0])
  notch();
 // components
 translate([0,-bl/2+wy,0])
  #rounded_cube(w=ww,d=wl,h=ch*2,rh=sr,rv=sr,t=0);
 // battery
 if (style == "RAM")
  translate([0,bcy,0])
   battery();
 // connector
 translate([0,-bl/2-xo,0])
  connector();
}

module cover () {
 difference(){
  blank();
  cuts();
 }
 if (style == "RAM")
  batt_retainer();
}

// for these, export STEP from KiCAD
// then use FreeCAD to convert STEP to STL
//   part -> create shape from mesh (sew 0.01)
//   part -> create copy -> refine shape
//   file -> export -> STL Mesh
module card () {
 translate([0,0,-pcb_thickness-xo])
  if (style == "ROM")
   import("../PCB/WP-2_IC_Card_ROM.stl");
  else
   import("../PCB/WP-2_IC_Card_RAM.stl");
}

if($preview) {
 // preview: include card, display upright
 %card();
 cover();
} else {
 // render: remove card, flip to best fdm printing orientation
 translate([0,0,bh])
  rotate([180,0,0])
   cover();
}