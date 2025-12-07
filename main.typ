#import "@preview/clean-cnam-template:1.3.0": *

#set text(lang: "en")

#show: clean-cnam-template.with(
  title: "Machine design my gpa",
  author: "Yuvraj Cheema, Samuel Sjoden, Connor Floyd, Taichi Kamei,
  Ari Cholakian, Bram Banik, Austin Bai",
  class: "MECH 325",
  subtitle: "StarTracker",
  main-color: "#C4122E",
  default-font: "Hiragino Sans",
  code-font: "Jetbrains Mono Nerd Font",
  outline-code: outline(
    title: "Table of Contents",
    depth: 2,
    indent: auto,
  ),
)

= INTRODUCTION

= PURPOSE

= DETAILED ANALYSIS

== RPM Considerations

Clear imaging with startrackers requires very precise movement of the camera to counteract the rotation of the earth. Incorrect rotation speed or wobble from
backlash can both cause the final image to be smeared and blurry. Before considering any major components' designs, we analyzed the constraints
posed by this high degree of precision. 

We decided on using the *Nikon Z50 II* camera and it's associated *NIKKOR Z 600mm* lens, as they are both high-quality but still within the price range
expected for hobby astrophotography. With this camera setup, we determined that the camera must rotate at a rate of 0.000694 rpm. This is a simple
calculation:
$
text("n")_text("camera") = frac(1 text("revolution"),text("day")) = frac(1 text("rev"), 86400 text("s"))*frac(60 text("s"), 1 text("min")) = 0.000694 text("rpm")
$
To maintain a stable image during exposure, we chose a maximum allowed variation of 3 pixels at the camera sensor when rotating. This means
that the camera is allowed to vary by $\pm$3 pixels during operation. This number is on the low end of mid-level off-the-market star trackers.
Using our 600mm lens, this means our maximum allowed variation is 4.357 arcseconds, or 0.00121\u{00B0}, at the sensor.
If we propagate this backwards through our 1600:1 reduction gear train, we get 1.92\u{00B0} of variation allowed at the driving motor.
This is larger than most standard consumer-available stepper motors on the market, which range from 0.9\u{00B0} to 1.8\u{00B0}.

== Worm Gear Selection

== Shaft Design 

=== Shaft 1

=== Shaft 2

=== Shaft 3 Overview

== Bushing Selection and Design Rationale

=== Overview
To suppport both ends of the two shafts in the reduction stage, two sets of Dry-Running Nylon Sleeve bushings were chosen for their minimal wear properties, low cost, and light weight.

==== Key Selection Requirements
- The bushings must have minimal wear to maintain the accuracy of the speed of the rotation 
- The bushings must have minimal maintenance and lubrication requirements for the convience of the hobbiysts
- Minimize length to keep overall reduction stage small

Bushings were selected instead of bearings because of the small loads required, keeping costs low and occupying minimal space. In particular,
dry bushings were selected to minimize maintenance on the StarTracker and eliminating lubrication requirements
to make construction convienient for hobbiysts.

To support the axial load of the worm gear, a flanged bushing is used. The low speed of the shafts allow the 
shoulder of the shafts to directly transfer axial load into the bushing flange with minimal wear. Nylon is perfect for this
because of its low friction and minimal wearing properties.

Price was also another important consideration, which the Nylon bushings meet, with a unit price of \$4.59.

In total this is why Dry-Running Nylon Sleeve bushings were selected.

== Bearing Selection and Design Rationale

=== Overview
To support the shaft on which the worm gear and camera are mounted, we will use an angular contact ball bearing and a deep groove ball bearing. 

==== Key Selection Requirements
- The bearings must be able to withstand the shaft thrust
- Minimize cost so project remains accessible to hobbyists

Bearings were selected for this shaft to ensure a smooth, frictionless rotation of the camera shaft to help with clear imaging. 
While bushings could work for this application due to the low rpm, minimal friction and smooth rotation are worth this increased
cost. 

To support the axial thrust from the camera's weight down on the shaft, we used a combination of an angular contact bearing at the 
end near the camera, and a stabilizing deep grove bearing opposite the camera to maintain axial alignment. Bearing calculations
allowed us to determine that *R10ZZ 5/8" Deep Groove Ball Bearing* and *3201-2RS Angular Contact Bearing* are ideal for this
application. Both of these bearings can be purchased for arund \$14 each on BearingsCanada.com and Temu.com, respectively.

= RESULTS & FINAL DEssSIGN

= CONLUSIONS & RECOMENDATIONS

= APPENDIX A

== Shaft 3 Calculations

#align(center,image("bram-images-420340594432/shaft_anal.png", width: 70%))
_Note: the angle of 49\u{00B0} is dependent on the location of the star tracker. In Vancouver, the latitude angle
is 49\u{00B0} so that's what we use._
#align(center,image("bram-images-420340594432/shaft_outline.png"))
$
Sigma F_z= A_z+B_z+C_z -F sin(phi)= 0 \
Sigma F_y= A_y+B_y+C_y - F cos(phi) =0 \
Sigma F_x= A_x+B_x+C_x = 0 \
Sigma M_(A,text("vertical")) = B_z (17.397)+C_z (54.5)-F sin(phi)(86.624) = 0 \
Sigma M_(A,text("horizontal")) = B_x (17.397)+C_x (54.5) = 0
$
_Distances for moment calculations are in mm._

From worm gear calculations, we know:
$
B_x, B_y, B_z
  &=3.28 text("lbf"), 3.019 text("lbf"), 1.61 text("lbf") \
  &= 14.5 text("N"), 13.42 text("N"), 7.16 text("N")
$
  Using these values, we get reaction forces of:

$
A_x = -9.87 text("N") wide A_z = -7.99 text("N") \
C_x = -4.63 text("N") wide C_y = 25.72 text("N") wide C_z = 44.7 text("N") 
$

We now verify that Aluminum 2014-O is suitable for this application.

Aluminum 2014-O has the following characteristics:
$
S_u = 27 wide S_y = 14 wide V_text("str") = 18 wide S_n' = 13
$
To find all the parameters, we consulted the following tables and got these results:
$
  &k_a = 0.8 && text("from Table x.x") \ 
  &k_b = 0.924 && text("from equation") 0.879 d^(-0.107) \ 
  &k_c = 1 && text("from Table x.x, bending") \
  &k_d = 1 && text("from Table x.x") \ 
  &k_e = 0.814 && text("for 99% reliability") \ 
  &k_f = 1 && text("No misc. factors") \
  &S_e' = 13.5 text("ksi") && text("from Eqn x.x") \
$
$
  S_e = k_a k_b k_c k_d k_e k_f S_e' = 8.12 text("ksi")
$

For this material to be considered valid for this operation, we need to verify
$
  S_e >= frac(32 M_max n_d, pi d^3)
$

We use shear and bending moment diagrams in X and Z to find the maximum bending moment along the shaft.
#figure(
  grid(
    columns: 2,
    gutter: 1mm,
    image("bram-images-420340594432/shearx.png", width: 100%),
    image("bram-images-420340594432/shearz.png", width: 100%),
    image("bram-images-420340594432/bendx.png", width: 100%),
    image("bram-images-420340594432/bendz.png", width: 100%),
  )
)
#image("bram-images-420340594432/shaft_calcs_shear.png")
#image("bram-images-420340594432/bend_calcs.png")

We see that the bending moment maximum is 
$
M_max = 950.18 text("N")text("mm") = 8.409 text("lbf") thin text("in")
$

Our shaft diameter was decided to be $frac(5,8)$\", so with a design factor of $n_d = 2.5$, we calculate

$
S_e >= frac(32 M_max n_d, pi d^3) = 872.9 text("psi") \
8.12 text("ksi") >= 872.9 text("psi")
$

so we can be sure that the aluminum material is strong enough to resist the stress. We now calculate
the minimum diameter required for this section of the shaft to ensure it is smaller than our design
shaft diameter. We use the following equation:

$

$
== Shaft 3 Bearing Calculations

= APPENDIX B


