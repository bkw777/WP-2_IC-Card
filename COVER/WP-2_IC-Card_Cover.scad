// top cover for WP-2 IC Card

// This scad file generates several different possible parts.
// set part="..." to select which part to output.


// true = export stl with parts oriented for kicad
// false = render stl with parts oriented for printing
render_preview_for_kicad = true;

// Which part to generate?
//part = "sram_128k_top"; // top cover for the old 128K-only SRAM card
part = "sram_top"; // *** - top cover for the SRAM card
//part = "rom_top"; // top cover for the FLASH card
//part = "mram_top"; // top cover for the MRAM card
//part = "breakout_top"; // top cover for the breakout card
//part = "bottom"; // bottom cover - not applicable for 1.2mm PCB. Use with pcb_thickness 0.8 or less and card_thickness 3.2
//part = "slider_2p"; // just the bank switch actuator slider part by itself, 2-position
//part = "slider_3p"; // just the bank switch actuator slider part by itself, 3-position
//part = "slider_4p"; // just the bank switch actuator slider part by itself, 4-position
//part = "wren_slider"; // just the write-enable switch actuator slider part by itself

// Which style of slide switch actuator?
// Use "none" to delete a switch.
// IE for a 128K MRAM or FLASH card with no bank switch installed,
// you can output a cover with no opening or slider.
//
// "slider" = trapped sliding actuator
// "finger" = large concave opening for a finger
// "pen"    = minimal slot for pen
// "under"  = slot in pcb, top is covered
// "none"   = switch not populated, delete from cover

// bank-select switch
bank_switch_style = "slider";

// write-enable switch
wren_switch_style = "under";


///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////


// "pen" switch style slot width
pen_slot_width = 3;

bank_slider_width = 6;
bank_finger_width = 6; // make it wide enough to display the switch position labels

wren_slider_width = 3;
wren_finger_width = 4;

finger_window_chamfer_slope = 0.5; // 1.0 = 45deg

// number of banks (number of slide switch positions)
nbanks =
  bank_switch_style=="none" ? 0 :
  part=="sram_top" ? 4 :
  part=="mram_top" ? 4 :
  part=="rom_top" ? 2 :
  0;

// attach the slider to the main body
// so it prints as one piece
attach_slider = true;
sprue_len = 1;

// preview display option
// show the switch slider in all possible positions
bank_switch_slider_position =
  nbanks<4 ? 2 :
  nbanks==4 ? 3 :
  1;

wren_switch_slider_position = 2;

// steel can over the mram
mram_shield = false;

// card_thickness is the total stack thickness
// of the pcb, printed parts, and adhesives, above and below.
//
// The original cards are 3.2mm, so card_thickness may go up to 3.2.
// But because of the way our connector has to work,
// anything over 3.0mm moves the connector off center vertically,
// (the cover becomes taller than the body of the connector)
// and that causes the pins to bind up.
//
// You could increase this to 3.1,
// and add a layer of packing tape on the bottom.
// End result is 3.2 total, with the connector still centered,
// and the bottom pcb traces protected from scratches and shorting.
//
//card_thickness = 2.8; // 2.8, 2.9, make the top cover thinner
// to leave room to apply a sheet on top like cut vinyl
// to cover over the openings on top. Perhaps laser cut steel
// to provide magnetic shielding for the MRAM?
//
//card_thickness = 3.0; // 3.0 default - use this for 1.2mm PCB thickness and no bottom cover
//card_thickness = 3.1; // *** 3.1, 3.2 make the top slightly thicker to make room for the 0.7 thin_wall_minimum
//
// Lately I'm using the full 3.2 here
// and letting adhesive_thickness make it thinner instead.
// That *technically* makes all the component pockets slightly
// short but in reality it works fine, and allows the model
// to have a thick enough ceiling for SLS printing.
card_thickness = 3.2;

// If pcb_thickness is less than 1.2, then generate a bottom cover too.
// If you put 0.8 here to generate a bottom cover,
// then change card_thickness to 3.2 also,
// so that the bottom cover is as thick as possble.
// If using 1.2mm pcb, then leave card_thickness at 3.0 for better centering of the connector in the slot.
// 0.8 or 1.2 are the only really useful values, even though pcbs can be ordered in other thicknesses.
// You can order a 1.0mm pcb, and that could be useful because you could cover the bottom with tape or cut vinyl,
// but it's not useful *here* because a bottom cover generated from here will be too thin to be printed.
//pcb_thickness = 0.6;
//pcb_thickness = 0.8;
pcb_thickness = 1.2; // ***

// How tall is the tallest component? (not counting the battery holder or slide switch)
// If this is any greater than 1.2, then there will be no roof over the components.
// It still protects the components and fills the slot so the card doesn't wobble,
// it's just cosmetically nicer to have a solid top surface.
// The sram and diode are 1.2mm, and the resistors are usually under 1.0,
// The only question is the caps. When sourcing components you have to specifically
// select caps that are 1.2mm or less, most will be a little taller.
components_height = 1.15; // fudge it down from 1.2 just enought to allow printing a 0.7mm roof over the components
//components_height = 1.2; // ***

// If card_thickness - pcb_thickness - components_height 
// comes out less than thin_wall_minimum, then don't
// try to print the roof over the components (too thin).
// Also affects how thin the battery retainer bridge
// is allowed to get. Unlike the components cover, it will
// always print the feature, but won't let the other
// constraints make it any thinner than this.
// Does not affect the bottom cover part. That part is always thin.
// FDM can theoretically print as thin as a single layer. 0.12mm or even less,
// at least for the first layers right on the bed.
// Commercial SLS services usually specify a minimum allowed wall thickness of 0.7mm
// With card_thickness = 3.0,
// minus pcb_thickness = 1.2,
// minus components_height = 1.2,
// there isn't 0.7mm left above the components.
// Set this to 0.7 to generate a model
// that can be printed by SLS or MJF.
// Set this to 0.6 or less to generate a model
// that allows an FDM or SLA printer to print the
// thin sheet over the components.
//thin_wall_minimum = 0.3; // 0.3 FDM printing, mram_top has small bit of 0.3mm thin roof just over the slide switch
//thin_wall_minimum = 0.6; // *** 0.6 FDM printing (home)
thin_wall_minimum = 0.7; // 0.7 commercial SLS/MJF printing

// Shaves the bottom of the top cover
// to make room for adhesive without making the card thicker.
// For liquid glue, use 0.
// For thin adhesive transfer tape, use 0 to 0.2
// amazon.com/dp/B06Y34587N 3M 468MP 5.2mil = 0.13mm
adhesive_thickness = 0.15; // *** good enough for most cases

//// Some useful combinations:

// SLS
// Add a layer of packing tape to cover the bottom of the PCB
// Total card thickness with the tape is 3.2mm
//card_thickness = 3.1;
//pcb_thickness = 1.2;
//thin_wall_minimum = 0.7;

// FANCY 3 LAYER SANDWICH - top cover, pcb, bottom cover
// Order 0.8mm PCB thickness
// print both parts: part="foo_top" and part="bottom"
//card_thickness = 3.2;
//pcb_thickness = 0.8;


///////////////////////////////////////////////////////////////////////////////
// END OF USER CONFIG
///////////////////////////////////////////////////////////////////////////////

// To generate these models, export STEP from KiCAD,
// open STEP in FreeCAD, export STL.
pcb_stl =
 part == "rom_top"        ? "inc/rom.pcb.stl"      :
 part == "sram_128k_top"  ? "inc/sram_128k.pcb.stl"     :
 part == "sram_top"       ? "inc/sram.pcb.stl"     :
 part == "mram_top"       ?
   bank_switch_style == "none" ? "inc/mram-128.pcb.stl" :
   mram_shield ? "inc/mram-shielded.pcb.stl" :
   "inc/mram.pcb.stl"                            :
 part == "breakout_top" ? "inc/breakout.pcb.stl" :
 false ;

bw = 54;    // main body width (X)
bl = 54;    // main body length (Y)

max_pcb_thickness = 1.2; // side of connector to side of pins is 1.27, max orderable pcb thickness that doesn't exceed is 1.2
connector_post_thickness = 0.51; // the solder posts on the main connector

// top cover - the full thickness with no adhesive_thickness subtracted
top_thickness = card_thickness/2 + connector_post_thickness/2;

// bottom cover - the full thickness with no adhesive_thickness subtracted
bottom_thickness = card_thickness/2 - connector_post_thickness/2 - pcb_thickness;

cr = 2;     // large corner radius
sr = 0.5;   // small corner radius & fillets

// finger grips
gl = 18;  // grip length
// Whatever degree of arcs you draw in kicad for the S curves in edge.cuts
// just put that number in here too.
grip_depth_angle = 45;  // bigger -> deeper finger grips
gda = // grip_depth_angle limited to 0-90
 grip_depth_angle < 0 ? 0:
 grip_depth_angle > 90 ? 90:
 grip_depth_angle;

// connector - the main front connector
cnw = 48.6;  // connector width
cnl = 8.525; // connector depth
cnp = 3;     // connector post length
cnpt = 0.8;  // post thickness

// polarity notch - front corner by pin 38
nl = 9.5;   // polarity notch length
nd = 0.8;   // polarity notch depth

// components common values
// Components height, factoring thin_wall_minimum and card thickness.
// If it can fit, use requested components_height.
// If it can't fit, use double the top_thickness
// to make a clean hole instead.
ch =
 top_thickness-components_height >= thin_wall_minimum ? components_height :
 top_thickness*2 ;

// for the component pockets,
// fooxs : X size
// fooys : Y size
// fooxp : X position, relative to the board center
// fooyp : Y position, relative to the front edge of the board

// ram or rom main components cavity
rcxs = 40;    // X size
rcys = 10;    // Y size
rcxp = 0;     // X placement, relative to board center
rcyp = 18.5;  // Y placement, relative to board front edge

// bank switch
swxp =         // x position
  part=="sram_top" ? -14 :
  part=="mram_top" ? 11 :
  0;     
swyp =         // y position
  part=="sram_top" ? 13.75 :
  part=="mram_top" ? 14.125 :
  part=="rom_top" ? 10 :
  0;
swa = 0;       // angle

// write-enable switch
wexp = -15; // x position
weyp = 0.525;   // y position
wea = 0;      // angle

// slide switch 
//swys = 3.5;  // switch body pocket Y size (switch body is 2.6)
swys = 2.6;  // switch body Y size
slide_switch_thickness = 1.5; // switch component height
swpl = 1; // switch pins lenghth
swph = 0.5; // switch pins thickness
// slider
sth = 1.5; // switch throw - 1.5mm travel per position, actuator is 1.3mm
stw = sth + sth + sth; // slider top width
sbh = 0.8; // slider base height (thickness)

// figure out the actual slide switch pocket height
// based on top_thickness and thin_wall_minumum
echo("top_thickness",top_thickness);
echo("slide_switch_thickness",slide_switch_thickness);
echo("top_thickness-slide_switch_thickness",top_thickness-slide_switch_thickness);
echo("thin_wall_minimum",thin_wall_minimum);
swh = top_thickness-slide_switch_thickness >= thin_wall_minimum ? slide_switch_thickness : top_thickness*2 ;
echo("swh",swh);

// battery holder
battery_tunnel_height = 1.6; // CR2012 = 1.2mm, CR2016 = 1.6mm  This is an ideal wish that will not be granted. Instead the code will come as close as other constraints allow. The end result will be a tunnel that is less than the ideal 1.6mm tall, but will be as tall as card_thickness and other constraints allow, and the tunnel roof will simply be thin and flexable enough to pass the battery through anyway.
// do not allow the battery tunnel roof
// to get any thinner than this
battery_tunnel_roof_minimum_thickness = 0.6;
battery_retainer_gap = 0.8; // The battery retainer is a little wedge added to the tunnel roof to let the battery pass in easily and then resist it coming back out. How much opening between the peak of the retainer wedge and the pcb. Even though tunnel_height will be less than 1.6mm you may still want to add even more obstruction in the tunnel to prevent the battery from being knocked out. This adds a little wedge inside the tunnel that passes the battery in easily and resist letting it back out. This gap is maintained regardless how other dimensions like card_thickness or tunnel_height change.
btt = 0.8;   // tabs thickness
bbw = 21;    // batt body width
brw = 6;     // batt retainer width
bewa = 60;   // extractor way angle
bby = -0.75; // Y-offset the octagon relative to the centerline of the tabs & coin cell
// boh = battery opening height,
// as close as possible to the desired
// battery_tunnel_height
// without violating thin_wall_minimum
btroofmin = thin_wall_minimum >= battery_tunnel_roof_minimum_thickness ? thin_wall_minimum : battery_tunnel_roof_minimum_thickness;
boh = battery_tunnel_height <= top_thickness-btroofmin ? battery_tunnel_height : top_thickness-btroofmin;
// Adjusts the retainer wedge as needed to get the desired
// gap regardles what the tunnel height worked out to.
brh = boh-battery_retainer_gap;  // batt retainer height , wedge thickness

// these are used to make clean joins & cuts
o = 0.1;       // normal overlap/overhang, easily visible with # or %, for things that won't show in the final shape
e = 0.002;  // epsilon - extra small overlap/overhang for things that would make visible edges in the final shape

fc = 0.1; // fitment clearance

//$fn = 32;
$fa = 6;
$fs = 0.1;

include <inc/handy.scad>;

////////////////////////////////////////////////////////////////////////////////////
// CUT-SHAPES
////////////////////////////////////////////////////////////////////////////////////

// shave the bottom of top cover
module adhesive () {
 translate([0,0,adhesive_thickness/2-o])
  cube([bw+o,bl+o,o+adhesive_thickness+o],center=true);
}

// rounded_cube with translation:
// Y translated relative to the front edge of the pcb
// X translated relative to the center of the pcb
// H is doubled to make the top half be the desired pocket height relative to the pcb top surface
module component_pocket (w=2,l=4,x=0,y=bl/2,h=ch,z=0) {
 translate([x,-bl/2+y,z])
  rounded_cube(w=w,d=l,h=h*2,rh=sr,rv=sr,t=0);
}

// s-shaped indent
// aside from finger_grips() could also be used to recess the slide switch on the edge of the pcb
module sdent (a=gda,l=gl) {
 t = o+card_thickness+o;
   hull() {
    mirror_copy([0,1,0]) {
     translate([0,l/2,0]) {
      rotate([0,0,a])
       translate([-cr*2,0,0]) {
        cylinder(h=t,r=cr);
        rotate([0,0,-90+a])
         fillet_linear(o=false,l=t,r=cr,a=a);
       }
      }
    }
   }
   mirror_copy([0,1,0])
    translate([0,l/2,0])
     rotate([0,0,90+a])
      fillet_linear(o=false,l=t,r=cr+e,a=a);
}

module finger_grips () {
 t = o+card_thickness+o;
 // the -e below eliminates a floating plane when gda=90
 mirror_copy([1,0,0])
  translate([-bw/2+cr-e,bl/2-cr-gl/2,-o]) {
   sdent();
 }
}

// socket polarity notch at the pin 38 corner
module polarity_notch () {
 translate([-bw/2-e,-bl/2-e,0]) {

  translate([0,0,-(top_thickness-nd)]) {
   hull() {
    cube([sr+sr,sr,top_thickness]);
     translate([0,nl-sr,0])
      cube([sr,sr,top_thickness]);
     translate([sr,nl-sr,0])
      cylinder(top_thickness,sr,sr);
   }
   translate([sr+sr+sr-e,sr-e,0])
    rotate([0,0,180])
     fillet_linear(o=false,l=top_thickness,r=sr,a=90);
   translate([sr,sr+nl-e,0])
    rotate([0,0,180])
     fillet_linear (o=false,l=top_thickness,r=sr,a=90);
   }

 }
}

module battery_holder (ea=0,fw=0,fd=0) {
 t = o+top_thickness+o;
 c = bbw/2;
 a = c * tan(45/2); // side of triangle to make an octagon
 
 btw = fw + bbw + fw;

 // solder tabs and the coin cell are
 // centered on on bcyp
// translate([0,y,0]) {
  
  // solder tabs
  rounded_cube(w=btw,d=fd,h=btt*2,rh=sr,rv=sr,t=0);

  // ...but the rest of the cutout shape is
  // shifted a little by bby
  translate([0,bby,0]) {

   // main holder body - half square half octagon
   translate([0,0,-o])
    hull() {
     translate([-a,-c,0]) cylinder(h=t,r=sr);
     translate([-c,-a,0]) cylinder(h=t,r=sr);
     translate([-c,c,0]) cylinder(h=t,r=sr);
     translate([c,c,0]) cylinder(h=t,r=sr);
     translate([c,-a,0]) cylinder(h=t,r=sr);
     translate([a,-c]) cylinder(h=t,r=sr);
    }

    // battery insertion/removal tunnel
    bw = sr+bbw+sr;
    translate([0,c,0])
     rounded_cube(w=bw,d=bw,h=boh*2,rh=sr,rv=sr,t=0);
    // poker way
    eww = sr+a*2+sr;
    ewl = bl;
    rotate([0,0,ea])
     translate([0,-c-sr,0])
      rotate([bewa,0,0])
       translate([0,eww/2,ewl/2-sr-o])
        rounded_cube(w=eww,d=eww,h=ewl,rh=sr,rv=sr,t=0);

  }
// }
}

// the front 38-pin connector
module connector (top=true) {
 t = o+card_thickness+o;
 translate([0,-bl/2-e,0]) {
  // main body
  translate([-cnw/2,0,-o])
   cube([cnw,cnl,t]);
  // inside corner reliefs
  mirror_copy([1,0,0])
   translate([-cnw/2+sr,cnl,0])
    cylinder(h=t*2,r=sr,center=true);
  // cavity for pins
  if (top)
   translate([0,cnp/2+cnl-cnpt/2,0])
    rounded_cube(w=cnw,d=cnp+sr,h=cnpt*2,rh=sr,rv=sr,t=0);
 }
}

module slide_switch_opening (t="none",n=2,w=2) {
   if (t!="none") {

   stow = stw + sth * (n-1); // slider top opening width
   sbw = sth * n + stow + sth * n; // slider base width
   // switch body len is  throw * nthrows + X
   bc = 0.2; // body clearance (want more than normal fc)
   // X is different for 2-throw vs >2-throw
   bx = 
     n==2 ? 6.7 :
     n==3 ? 9.7 :
     n==4 ? 11.3 :
     12;
   by = swys; // body Y pocket size

   // body
   if (t=="pen") {
    translate([0,pen_slot_width/2,0])
    component_pocket(w=bc+bx+bc,l=bc+by+bc+pen_slot_width,h=swh);
   } else {
    component_pocket(w=bc+bx+bc,l=bc+by+bc,h=swh);
   }

   // pins
   translate([0,-swpl/2,0])
    component_pocket(w=bc+bx+swpl+bc,l=by+swpl+bc,h=swph);

   if (t=="slider") {

    translate([0,w/2+by/2+fc-e,0]) {
     // slider base
     component_pocket(w=fc+sbw+fc,l=fc+w+fc,h=sbh+fc);
     // slider slot
     translate([0,-sr/2,0])
      component_pocket(w=fc+stow+fc,l=fc+w+fc+sr,h=card_thickness);
    }

   } else if (t=="finger") {

    aww = bx+4; // access window width (X)
    r = min(w/2,cr);
    //r = cr;
    
    translate([0,by/4+max(w/2,r),top_thickness/2])
     hull() {
      mirror_copy([0,1,0])
       translate([0,max(w/2,r)-r,0])
        mirror_copy([1,0,0])
         translate([max(aww/2,r)-r,0,0])
          cylinder(h=top_thickness+o,r1=r,r2=r+top_thickness/finger_window_chamfer_slope,center=true);
     }
   } else if (t=="under") {
    cw = 1.5+sr+fc; // cavity width around actuator
    pw = cw + by/2;
    translate([0,pw/2,0])
     component_pocket(w=bx,l=pw,h=1.2);
   }

   }
}

////////////////////////////////////////////////////////////////////////////////////
// ADD-SHAPES
////////////////////////////////////////////////////////////////////////////////////

// the basic full card shape before any cuts
module blank (l=bl,w=bw,t=card_thickness) {
 translate([0,-(bl/2-l/2),0])
  hull () {
   mirror_copy([1,0,0])
    mirror_copy([0,1,0])
     translate([w/2-cr,l/2-cr,0])
      cylinder(h=t,r=cr);
 }
}

// wedge/bump added to the battery tunnel roof
// to let the battery in but not back out
module batt_retainer () {
 r=0.3;

 translate([0,bbw/2+0.05,0])
  rotate([90,0,90])
   hull() {
    translate([0,r+battery_retainer_gap,0])
     cylinder(h=brw,r=r,center=true);
   
    translate([0,top_thickness-r-e,0])
     cylinder(h=brw,r=r,center=true);

    translate([4,top_thickness-r-e,0])
     cylinder(h=brw,r=r,center=true);
     
    
   }

/*
   bri = bbw/2+sr+bby;
   brl = bl/2-bri;
   ww = brl/2;
   translate([-brw/2,bri+ww,boh+e])
    rotate([-90,0,-90])
     hull() {
      cube([e,e,brw]);
      translate([ww-e,0,0])
       cube([e,e,brw]);
      translate([ww-brh/2,brh/2,0])
       cylinder(h=brw,r=brh/2);
     }
*/
}

// top cover basic shape common to all cards
module top_common () {
 difference() {

  // add the basic full card shape
  blank(t=top_thickness);

  // cut-outs common to all cards
  group() {

   // front connector
   connector("top");

   // socket polarity notch at the pin 38 corner
   polarity_notch();

   // finger-pull dimples on the exposed half of the card
   finger_grips();
   
   // shave the bottom by the thickness of the adhesive
   adhesive();

  }
 }
}

////////////////////////////////////////////////////////////////////////////////
// COMPLETE OBJECTS
////////////////////////////////////////////////////////////////////////////////

module PCB () {
 if (pcb_stl)
  translate([0,0,-max_pcb_thickness-e])
   import(pcb_stl);
}

module rom_top () {
 difference(){
  top_common();
  group() {
   // main components
   component_pocket(w=rcxs,l=rcys,x=rcxp,y=rcyp);
   ww = 
     wren_switch_style == "finger" ? wren_finger_width :
     wren_switch_style == "slider" ? wren_slider_width :
     0;
   // wren switch
   translate([wexp,weyp,0])
    rotate([0,0,wea])
     slide_switch_opening(t=wren_switch_style,n=2,w=ww);
     // bank switch
   if (nbanks>1) {
   bw = 
     bank_switch_style == "finger" ? bank_finger_width :
     bank_switch_style == "slider" ? bank_slider_width :
     0;
   translate([swxp,swyp,0])
    slide_switch_opening(t=bank_switch_style,n=nbanks,w=bw);
   }
  }
 }
}

module sram_128k_top () {
 batx = 0;     // batt x
 baty = 11.5;  // batt y
 bea = 45;     // batt ejector angle
 bfw = 6;      // batt foot (solder tab) width
 bfd = 6;      // batt foot depth
 
 difference() {
  top_common();
  group() {
   component_pocket(w=rcxs,l=rcys,x=rcxp,y=rcyp);
   translate([batx,baty,0])
    battery_holder(ea=bea,fw=bfw,fd=bfd);
  }
 }
translate([batx,baty,0])
 batt_retainer();
}

module sram_top () {
 batx = 9;
 baty = 11;
 bea = 0;     // batt ejector angle
 bfw = 2;      // batt foot (solder tab) width
 bfd = 7;      // batt foot depth

 difference() {
  top_common();
  group() {
   component_pocket(w=rcxs,l=rcys,x=rcxp,y=rcyp);

   translate([batx,baty,0])
    battery_holder(ea=bea,fw=bfw,fd=bfd);

   // bank switch
   if (nbanks>1) {
   bw = 
     bank_switch_style == "finger" ? bank_finger_width :
     bank_switch_style == "slider" ? bank_slider_width :
     0;
   translate([swxp,swyp,0])
    slide_switch_opening(t=bank_switch_style,n=nbanks,w=bw);
   // bank switch components
   translate([swxp,swyp-7,0])
    component_pocket(w=10,l=3.5);
   }
  }
 }
 translate([batx,baty,0])
  batt_retainer();
}

module mram_top () {
 difference() {
  top_common();

  // cut-outs
  group() {

   // ldo, 4245s, 2g32, caps, resistors
   component_pocket(w=45,l=13,x=0,y=22);

   // MRAM
   if (mram_shield) {
     // ic (shield)
     translate([-10,-bl/2+41.6,0])
       rounded_cube(w=17.6,d=23,h=card_thickness*2+sr*2,rh=1.8,rv=sr,t=0);
     // caps
     component_pocket(w=23,l=3.5,x=-10,y=41.6);
     // 20x20 square shield
     //component_pocket(w=20+fc*2,l=20+fc*2,x=-10,y=41.6,h=3);
   } else {
     // ic
     component_pocket(w=13,l=20,x=-10,y=41.6);
     // caps
     component_pocket(w=18.6,l=4,x=-10,y=41.6);
   }

  // bank-select slide switch
  translate([swxp,swyp,0])
   slide_switch_opening(t=bank_switch_style,n=nbanks,w=bank_slider_width);
   
  }
 }
}

module breakout_top () {
 difference() {
  blank(l=bl-gl,t=top_thickness);
  group() {
   connector();
   polarity_notch();
   adhesive();
  }
 }
}

module bottom () {
 // like the top except
 // no polarity notch on the pin 38 corner
 // no cavities for soldered components
 difference() {
  blank(t=bottom_thickness-adhesive_thickness);
  group() {
   connector(top=false);
   finger_grips();
  }
 }
}

module switch_slider (n=2,w=2) {
 $fs = 0.05;
 stow = stw + sth * (n-1); // slider top opening width
 sbw = sth * n + stow + sth * n; // slider base width
 bw = sbw - sth * (n-1); // base width
 abh = top_thickness; // actuator block height
 difference () {
  union () {
   // actuator block
   translate([0,0,abh/2])
    rounded_cube(w=stw,d=w,h=abh,rh=sr-fc,rv=0.01,t=0);
   // base
   rounded_cube(w=bw,d=w,h=sbh*2,rh=sr-fc,rv=sr-fc,t=0);
  }
  union () {
  // cut actuator slot
  translate([0,0,abh/2+sbh+e])
   cube([sth,w+o,abh],center=true);
  // cut flat bottom
  translate([0,0,-(sbh+o)/2])
   cube([e+bw+e,e+w+e,sbh+o],center=true);
  }
 }
}

module slider_sprues (l=1,w=2) {
     if (attach_slider) {
      r = 0.4;
      mirror_copy([1,0,0])
        translate([r+sth/2+0.1,sprue_len+w/2+o,r])
          rotate([90,0,0])
            cylinder(r=r,h=o+l+o);
    }
}

/////////////////////////////////////////////////////////
// OUTPUT
/////////////////////////////////////////////////////////

if($preview || render_preview_for_kicad) {
/////////////////////////////////////////////////////////
// PREVIEW MODE
// * include the PCB
// * orient the parts as they would be used

//wsyo = wren_slider_width/2+swys/2; // slider Y offset
//bsyo = bank_slider_width/2+swys/2; // slider Y offset

 if (part == "rom_top") {
  rom_top();
  if (wren_switch_style == "slider")
   translate([wexp,weyp,0])
    rotate([0,0,wea])
     translate([sth/2-sth*(wren_switch_slider_position-1),wren_slider_width/2+swys/2+fc,0])
      switch_slider(n=2,w=wren_slider_width);
  if (bank_switch_style == "slider")
   translate([swxp,swyp,0])
    rotate([0,0,swa]) 
     translate([sth*(nbanks-1)/2-sth*(bank_switch_slider_position-1),bank_slider_width/2+swys/2+fc,0])
      switch_slider(n=nbanks,w=bank_slider_width);
  }
 if (part == "sram_128k_top") sram_128k_top();
 if (part == "sram_top") {
  sram_top();
  if (bank_switch_style == "slider")
   translate([swxp,swyp,0])
    rotate([0,0,swa]) 
     translate([sth*(nbanks-1)/2-sth*(bank_switch_slider_position-1),bank_slider_width/2+swys/2+fc,0])
      switch_slider(n=nbanks,w=bank_slider_width);
 }
 if (part == "mram_top") {
  mram_top();
  if (bank_switch_style == "slider")
   translate([swxp,swyp,0])
    rotate([0,0,swa]) 
     translate([sth*(nbanks-1)/2-sth*(bank_switch_slider_position-1),bank_slider_width/2+swys/2+fc,0])
      switch_slider(n=nbanks,w=bank_slider_width);
 }
 if (part == "breakout_top") breakout_top();

 if (part == "bottom") bottom();
 else if (pcb_thickness < max_pcb_thickness)
  translate([0,0,-bottom_thickness-pcb_thickness])
   bottom();

 if (part == "slider_2p") switch_slider(n=2,w=bank_slider_width);
 else if (part == "slider_3p") switch_slider(n=3,w=bank_slider_width);
 else if (part == "slider_4p") switch_slider(n=4,w=bank_slider_width);
 else if (part == "wren_slider") switch_slider(n=2,w=wren_slider_width);
 else %PCB();

} else {
/////////////////////////////////////////////////////////
// RENDER MODE
// * don't include the PCB
// * orient the parts for printing

 if (part == "bottom") bottom();
 else if (part == "slider_2p") switch_slider(n=2,w=bank_slider_width);
 else if (part == "slider_3p") switch_slider(n=3,w=bank_slider_width);
 else if (part == "slider_4p") switch_slider(n=4,w=bank_slider_width);
 else if (part == "wren_slider") switch_slider(n=2,w=wren_slider_width);
 else {
  // if any of the top covers, flip over for FDM printing
  translate([0,0,top_thickness])
   rotate([0,180,0]) {
    if (part == "rom_top") rom_top();
    if (part == "sram_128k_top") sram_128k_top();
    if (part == "sram_top") sram_top();
    if (part == "mram_top") mram_top();
    if (part == "breakout_top") breakout_top();
   }

  // don't flip the slider over

  // if there are 2 sliders, move them off center 
  x = nbanks>1 && bank_switch_style == "slider" && part == "rom_top" && wren_switch_style == "slider" ? 10 : 0 ;

    if ( nbanks>1 && bank_switch_style == "slider") {
    translate([-x,-bl/2+cnl-sprue_len-bank_slider_width/2,0]) {
     switch_slider(n=nbanks,w=bank_slider_width);
     slider_sprues(l=sprue_len,w=bank_slider_width);
     }
  }
  if (part == "rom_top" && wren_switch_style == "slider") {
    translate([x,-bl/2+cnl-sprue_len-wren_slider_width/2,0]) {
     switch_slider(n=2,w=wren_slider_width);
     slider_sprues(l=sprue_len,w=wren_slider_width);
    }
  }

 }

}
