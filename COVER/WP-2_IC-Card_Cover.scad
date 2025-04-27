// top cover for WP-2 IC Card

// This scad file generates several different possible parts.
// set part="..." to select which part to output.

// Render stl with parts oriented for printing vs preview.
// Not using $preview because we want to actually render
// stl with parts in the preview placements for kicad 3d viewer.
PRINT = true;

// Which part to generate?
//part = "SRAM_128K"; // top cover for the old 128K-only SRAM card
part = "SRAM"; // *** - top cover for the SRAM card
//part = "ROM"; // top cover for the FLASH card
//part = "MRAM"; // top cover for the MRAM card
//part = "breakout"; // top cover for the breakout card
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


// attach the slider to the main body
// so it prints as one piece
attach_slider = true;
sprue_len = 1;


// preview display option
// override default and show the switch slider in arbitary switch position #
// value is switch position number, ie 4 position switch values are 1, 2, 3, 4
//
//bank_switch_slider_position = 1;
//wren_switch_slider_position = 1;


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
// Set this to 0.7 to generate a model that can be printed by SLS or MJF.
// Set this to 0.6 or less if you want to try covering all components
// including extra thin parts over tall components like the slide swtch.
//thin_wall_minimum = 0.3; // 0.3 FDM printing, slide switch only has 0.3mm above it.
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

// FANCY 3 LAYER SANDWICH - top cover, thin pcb, bottom cover
// Order 0.8mm PCB thickness
// print both parts: part="foo_top" and part="bottom"
//card_thickness = 3.2;
//pcb_thickness = 0.8;


///////////////////////////////////////////////////////////////////////////////
// END OF USER CONFIG
///////////////////////////////////////////////////////////////////////////////

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

// slide switch 
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
// do not allow the battery tunnel roof to get any thinner than this
battery_tunnel_roof_minimum_thickness = 0.6;
// The battery retainer is a little wedge added to the tunnel roof
// to let the battery pass in easily and then resist it coming back out.
// How much opening between the peak of the retainer wedge and the pcb?
// Even though tunnel_height will be less than 1.6mm
// you may still want to add even more obstruction in the tunnel
// to prevent the battery from being knocked out.
// This adds a little wedge inside the tunnel that passes the battery in easily
// and resist letting it back out.
// This gap is maintained regardless how other dimensions like
// card_thickness or tunnel_height change.
battery_retainer_gap = 0.6;
btt = 0.8;   // tabs thickness
bbw = 21;    // batt body width
brw = 6;     // batt retainer width

// derived values
// boh = battery opening height,
// as close as possible to the desired battery_tunnel_height
// without violating thin_wall_minimum
btroofmin = thin_wall_minimum >= battery_tunnel_roof_minimum_thickness ? thin_wall_minimum : battery_tunnel_roof_minimum_thickness;
boh = battery_tunnel_height <= top_thickness-btroofmin ? battery_tunnel_height : top_thickness-btroofmin;
// Adjusts the retainer wedge as needed to get the desired
// gap regardles what the tunnel height worked out to.
brh = boh-battery_retainer_gap;  // batt retainer height , wedge thickness


// Work around the pure functional language limits.
// Use ternary syntax to conditionally set some values here,
// because the functions that use them later must be called UNconditionally.
// These still get combined with yet other conditional and calculated
// values not known until later. The switch slider makes it a little complicated
// because there are 3 states and 2 locations, not simply $preview vs !$preview,
// and the locations aren't known until various user run-time options are evaluated
// later.
// * normal preview:      main body upright, slider in preview location
// * render for kicad:    everything (except pcb) like preview even though !$preview
// * render for printing: main body flipped over, slider NOT flipped, slider moved
//   to a derived spot relative to the front connector, slider attached by sprues
// * ... or maybe there is no slider this time because the user is generating
//   for a board with those parts not populated...
prt = (PRINT && !$preview);       // $preview isn't enough, sometimes we want to full render & export in the preview orientations
ptz = (prt) ? top_thickness : 0 ; // print translate z
pry = (prt) ? 180 : 0 ;           // print rotate y


// these are used to make clean joins & cuts
o = 0.1;    // normal overlap/overhang, easily visible with # or %, for things that won't show in the final shape
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

module battery_holder (eaz=0,eax=45,fw=0,fd=0,yo=0) {
 t = top_thickness*3;
 c = bbw/2;
 a = c * tan(45/2); // side of triangle to make an octagon
 
 btw = fw + bbw + fw;

  // solder tabs and the coin cell are centered on on bcyp ...
  // solder tabs
  rounded_cube(w=btw,d=fd,h=btt*2,rh=sr,rv=sr,t=0);

  // ... but the rest of the cutout shape is shifted a little by yo
  translate([0,yo,0]) {

   // main holder body - half square half octagon
    hull() {
     translate([-a,-c,0]) cylinder(h=t,r=sr,center=true);
     translate([-c,-a,0]) cylinder(h=t,r=sr,center=true);
     translate([-c,c,0])  cylinder(h=t,r=sr,center=true);
     translate([c,c,0])   cylinder(h=t,r=sr,center=true);
     translate([c,-a,0])  cylinder(h=t,r=sr,center=true);
     translate([a,-c,0])  cylinder(h=t,r=sr,center=true);
    }

    // battery insertion/removal tunnel
    bw = sr+bbw+sr;
    translate([0,c,0])
     rounded_cube(w=bw,d=bw,h=boh*2,rh=sr,rv=sr,t=0);
    // poker way
    eww = sr+a*2+sr;
    ewl = bl*2;
    rotate([0,0,eaz])
    translate([0,-c,0])
      rotate([eax,0,0])
       translate([0,eww/2,0])
        rounded_cube(w=eww,d=eww,h=ewl,rh=sr,rv=sr,t=0);

  }

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
module batt_retainer (yo=0) {
 r=0.3;

 translate([0,yo+bbw/2+sr+r,0])
  rotate([90,0,90])
   hull() {
    translate([0,r+battery_retainer_gap,0])
     cylinder(h=brw,r=r,center=true);
   
    translate([0,top_thickness-r-e,0])
     cylinder(h=brw,r=r,center=true);

    translate([4,top_thickness-r-e,0])
     cylinder(h=brw,r=r,center=true);
   }

}

module slider_sprues (l=1,w=2) {
     if (attach_slider) {
      r = 0.4;
      mirror_copy([1,0,0])
        translate([r+sth/2+0.1,l+w/2+o,r])
          rotate([90,0,0])
            cylinder(r=r,h=o+l+o);
    }
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

module PCB (pcb_stl) {
 if (pcb_stl)
  translate([0,0,-max_pcb_thickness-e])
   import(pcb_stl);
}

//  ####    ROM    #############################################################
module rom_top () {

 // main components
 mcx = 0;
 mcy = -8.5;
 mcw = 40;
 mcl = 10;

 // bank switch
 bsp = is_undef(bank_switch_slider_position) ? 2 : bank_switch_slider_position ;
 nbanks = bank_switch_style=="none" ? 0 : 2;
 swxp = 0;         // x
 swyp = 10;        // y

 // write enable switch
 wsp = is_undef(wren_switch_slider_position) ? 2 : wren_switch_slider_position ;
 wexp = -15;       // x
 weyp = 0.5;       // y

 %PCB("inc/ROM.pcb.stl");

 // main body is conditionally flipped for printing
 translate([0,0,ptz]) rotate([0,pry,0]) {
 
 difference(){
  top_common();
  group() {
   // main components
   translate([mcx,mcy,0])
    component_pocket(w=mcw,l=mcl);
   ww = 
     wren_switch_style == "finger" ? wren_finger_width :
     wren_switch_style == "slider" ? wren_slider_width :
     0;
   // wren switch
   translate([wexp,weyp,0])
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

 // the switch slider is NOT flipped or elevated regardless of print vs preview,
 // but is moved to a different x,y

 bs = (bank_switch_style == "slider" && nbanks>1);
 ws = (wren_switch_style == "slider");
 yo = (bs && ws) ? 10 : 0 ; // y offset if printing and we have both
 
 // bank switch
 if (bs) {

  tx = prt ? -yo : swxp + sth*(nbanks-1)/2-sth*(bsp-1) ;
  ty = prt ? -bl/2-bank_slider_width/2+cnl-sprue_len : swyp + bank_slider_width/2+swys/2+fc ;

  translate([tx,ty,0]) {  
   switch_slider(n=nbanks,w=bank_slider_width);
   if (prt) slider_sprues(w=bank_slider_width);
  }
 }

 // write switch
 if (ws) {

  tx = prt ? yo : wexp + sth*(nbanks-1)/2-sth*(wsp-1) ;
  ty = prt ? -bl/2-wren_slider_width/2+cnl-sprue_len : weyp + wren_slider_width/2+swys/2+fc ;

  translate([tx,ty,0]) {  
   switch_slider(n=2,w=wren_slider_width);
   if (prt) slider_sprues(w=wren_slider_width);
  }
 }


}


// ####    SRAM_128K    ########################################################
module sram_128k_top () {

 // main components
 mcx = 0;      // X placement
 mcy = -8.5;   // Y placement
 mcw = 40;     // X size
 mcl = 10;     // Y size

 batx = 0;     // batt x
 baty = 11.5;  // batt y
 bfw = 6;      // batt foot (solder tab) width
 bfd = 7;      // batt foot depth
 byo = -0.5;   // Y-offset the main octagon cutout around the batt
 beaz = 45;    // batt ejector angle z (which octogon face)
 beax = 60;    // batt ejector angle x (ramp slope)


 %PCB("inc/SRAM_128K.pcb.stl");

 // main body is conditionally flipped for printing
 translate([0,0,ptz]) rotate([0,pry,0]) {

  difference() {
   top_common();
   group() {
    translate([mcx,mcy,0])
    component_pocket(w=mcw,l=mcl);
    translate([batx,baty,0])
     battery_holder(eaz=beaz,eax=beax,fw=bfw,fd=bfd,yo=byo);
   }
  }

 translate([batx,baty,0])
  batt_retainer(yo=byo);

 }

}

// ####    SRAM    #############################################################
module sram_top () {

 // main components
 mcx = 0;
 mcy = -8.5;
 mcw = 40;
 mcl = 10;

 // batt
 batx = 9;
 baty = 11;
 bfw = 2;      // batt foot (solder tab) width
 bfd = 7;      // batt foot depth
 byo = -0.4;   // Y-offset the main octagon cutout around the batt
 beaz = 0;     // batt ejector angle z (which octogon face)
 beax = 45;    // batt ejector angle x (ramp slope)

 
 // bank switch
 bsp = is_undef(bank_switch_slider_position) ? 3 : bank_switch_slider_position ;
 nbanks = bank_switch_style=="none" ? 0 : 4;
 swxp = -14;    // x
 swyp = 13.75;  // y

 // bank switch related components
 bank_parts_y_rel = -7.0;  // y relative to switch
 bank_parts_w = 9;
 bank_parts_l = 3.5;

 %PCB("inc/SRAM.pcb.stl");

 // main body is conditionally flipped for printing
 translate([0,0,ptz]) rotate([0,pry,0]) {

 difference() {
  top_common();
  group() {
  translate([mcx,mcy,0])
   component_pocket(w=mcw,l=mcl);

   translate([batx,baty,0])
    battery_holder(eaz=beaz,eax=beax,fw=bfw,fd=bfd,yo=byo);

   // bank switch
   if (nbanks>1) {
   bw = 
     bank_switch_style == "finger" ? bank_finger_width :
     bank_switch_style == "slider" ? bank_slider_width :
     0;
   translate([swxp,swyp,0])
    slide_switch_opening(t=bank_switch_style,n=nbanks,w=bw);
   // bank switch components
   translate([swxp,swyp+bank_parts_y_rel])
    component_pocket(w=bank_parts_w,l=bank_parts_l);
   }
  }
 }

 // add the little wedge to the battery tunnel
 translate([batx,baty,0])
  batt_retainer(yo=byo);
 }

 // the switch slider is NOT flipped or elevated regardless of print vs preview,
 // but is moved to a different x,y

 if (bank_switch_style == "slider") {

  tx = prt ? 0 : swxp + sth*(nbanks-1)/2-sth*(bsp-1) ;
  ty = prt ? -bl/2-bank_slider_width/2+cnl-sprue_len : swyp + bank_slider_width/2+swys/2+fc ;

  translate([tx,ty,0]) {  
   switch_slider(n=nbanks,w=bank_slider_width);
   if (prt) slider_sprues(w=bank_slider_width);
  }
 }

}

// ####    MRAM    #############################################################
module mram_top () {

 // main components
 mcx = 0;
 mcy = -5;
 mcw = 45;
 mcl = 13;

 // mram ic
 icx = -10; // x
 icy = 14;  // y
 icw = 13;  // width
 icl = 20;  // len
 cw = 18.6; // caps width
 cl = 4;    // caps len

 // bank switch
 bsp = is_undef(bank_switch_slider_position) ? 3 : bank_switch_slider_position ;
 nbanks = bank_switch_style=="none" ? 0 : 4;
 swxp = 11;    // x
 swyp = 13;    // y
 
 %PCB("inc/MRAM.pcb.stl");

 // main body is conditionally flipped for printing
 translate([0,0,ptz]) rotate([0,pry,0]) {
 
 difference() {
  top_common();

  // cut-outs
  group() {

   // main components cavity
   translate ([mcx,mcy,0])
    component_pocket(w=mcw,l=mcl);

   translate([icx,icy,0]) {
    // ic
    component_pocket(w=icw,l=icl);
    // caps
    component_pocket(w=cw,l=cl);
   }

   // bank-select slide switch
   translate([swxp,swyp,0])
    slide_switch_opening(t=bank_switch_style,n=nbanks,w=bank_slider_width);
   
  }
 }

 }

 // the switch slider is NOT flipped or elevated regardless of print vs preview,
 // but is moved to a different x,y
 if (bank_switch_style == "slider") {

  tx = prt ? 0 : swxp + sth*(nbanks-1)/2-sth*(bsp-1) ;
  ty = prt ? -bl/2-bank_slider_width/2+cnl-sprue_len : swyp + bank_slider_width/2+swys/2+fc ;

  translate([tx,ty,0]) {  
   switch_slider(n=nbanks,w=bank_slider_width);
   if (prt) slider_sprues(w=bank_slider_width);
  }
 }

}

// ####    BREAKOUT    ########################################################
module breakout_top () {

%PCB("inc/breakout.pcb.stl");

 // main body is conditionally flipped for printing
 translate([0,0,ptz]) rotate([0,pry,0]) {

  difference() {
   blank(l=bl-gl,t=top_thickness);
   group() {
    connector();
    polarity_notch();
    adhesive();
   }
  }

 }
}

// ####    BOTTOM    ##########################################################
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

/////////////////////////////////////////////////////////
// OUTPUT
/////////////////////////////////////////////////////////

 if (part == "ROM")        rom_top();
 if (part == "SRAM_128K")  sram_128k_top();
 if (part == "SRAM")       sram_top();
 if (part == "MRAM")       mram_top();
 if (part == "breakout")   breakout_top();

 if (part == "bottom") bottom();
 else if (pcb_thickness < max_pcb_thickness)
  translate([0,0,-bottom_thickness-pcb_thickness])
   bottom();

 if (part == "slider_2p")   switch_slider(n=2,w=bank_slider_width);
 if (part == "slider_3p")   switch_slider(n=3,w=bank_slider_width);
 if (part == "slider_4p")   switch_slider(n=4,w=bank_slider_width);
 if (part == "wren_slider") switch_slider(n=2,w=wren_slider_width);
