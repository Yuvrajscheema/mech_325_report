#import "@preview/clean-cnam-template:1.3.0": *

#set text(
  lang: "en",
  size: 12pt
)

#show: clean-cnam-template.with(
  title: "Machine design my gpa",
  author: "Yuvraj Cheema, Samuel Sjoden, Connor Floyd, Taichi Kamei,
  Ari Cholakian, Bram Banik, Austin Bai",
  class: "MECH 325",
  subtitle: "StarTracker",
  main-color: "#C4122E",
  default-font: "New Computer Modern",
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
== Belt and Pulley Design

=== Overview
Before the worm gear a reduction of almost 1:16 is needed, as found in . For this we will use 
a two pulley system

== Worm Gear Selection

== Shaft Design 

=== 2nd Shaft Overview


The 2nd shaft transmits torque from the worm gear to the pulley which drives the timing belt. The shaft is supported by two bushings on either end. The shaft is subjected to forces from the worm gear and pulley as well as reaction forces from the bushings.
  
$
"Shaft Length" &: "8-in" \
"Worm" &: "1⅝-in long shoulder with ¾-in diameter" \
"Pulley" &: "¾-in long shoulder with ⅕-in diameter" \
"Bushings" &: "¼-in long shoulders with 3/16-in diameter" \
$

#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft _itself.png", width: 40%),
  // Add a caption using a content block ([...])
  caption: [2nd shaft],
  // Add a label fo r referencing (use a name enclosed in angle brackets)
) <fig:2nd_shaft_itself>

#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft_with_components.png", width: 40%),
  // Add a caption using a content block ([...])
  caption: [2nd shaft with components],
  // Add a label fo r referencing (use a name enclosed in angle brackets)
) <fig:2nd_shaft_itself>

=== 2nd Shaft Analysis

Point A and D are the bushings, B is the worm gear, and C is the pulley for the timing belt.
Force calculations are as follows: \
\

  $
  Sigma F_x = 0 : -F_(A x) + F_(B x) - F_(C x) - F_(D x) &= 0 \
  F_(A x) + F_(D x) &= F_(B x) - F_(C x) \
  F_(A x) &= F_(B x) - F_(C x) - F_(D x) \
  $
  $
  Sigma F_y = 0 : F_(A y) - F_(B y) &= 0 \
  F_(A y) &= F_(B y)
  \
  $
  $
  Sigma F_z = 0 : F_(A z) - F_(B z) + F_(D z) &= 0 \
  F_(A z) + F_(D z) &= F_(B z) \
  F_(A z) &= F_(B z) - F_(D z)
  $

  $
  Sigma M_(A x) = 0 : -L_(A B)F_(B z) + L_(A D)F_(D z) &= 0 \
  F_(D z) &= L_(A B)/L_(A D)F_(B z) \ 
  $
  $
  Sigma M_(A z) = 0 : -L_(A B)F_(B x) + L_(A C)F_(C x) +  L_(A D)F_(D x) &= 0 \
  F_(D x) &= (L_(A B)F_(B x) - L_(A C)F_(C x))/L_(A D) \ 
  $

Using the known forces, we get following forces on A and D:


$
F_(A x) = 3.01 "lbf" \
F_(A y) = 2.67 "lbf" \
F_(A z) = 11.7 "lbf" \
$

$
F_(D x) = -0.553 "lbf" \
F_(D y) =  0.00 "lbf" \
F_(D z) = 0.812 "lbf" \
$

#grid(
  columns: 2,

  figure(
    table(
      columns: 3,
      stroke: 1pt + black,
      inset: 4pt,
        [],[$"V"_("horizontal") "(lbf)"$],  [$"V"_("vertical") "(lbf)"$],
        [A],[-3.01],  [11.7],
        [B],[0.267],  [-0.812],
        [C],[-0.553], [-0.812],
        [D],[0.00],   [0.00]
    ),
    caption: [Vertical and Horizontal Plane Shear],
  ),

  figure(
    table(
      columns: 4,
      stroke: 1pt + black,
      inset: 4pt,
        [], [$"M"_("horizontal") "(lbf)"$], [$"M"_("vertical") "(lbf)"$], [$"M"_("total") "(lbf)"$],
        [A],[0.00],[0.00],[0.00],
        [B],[-3.01],[11.7],[12.1],
        [C],[-1.23],[0.406],[1.30],
        [D],[0.00],[0.00],[0.00]
    ),
    caption: [Vertical and Horizontal Bending Moments],
  )
)

#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft_shear_moment.jpeg", width: 70%),
  // Add a caption using a content block ([...])
  caption: [Shear and bending moment diagram],
  // Add a label for referencing (use a name enclosed in angle brackets)
) <fig:2nd_shaft_shear_moment>



#figure(
  table(
    columns: 2,
    stroke: 1pt + black,
    inset: 4pt,
      [], [$"T (lbf·in)"$],
      [A], [0.00],
      [B],   [0.521],
      [C],   [-0.521],
      [D], [0.00]
  ),
  caption: [Torque],
)

#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft_torque.jpeg", width: 70%),
  // Add a caption using a content block ([...])
  caption: [Torque diagram of 2nd shaft],
  // Add a label for referencing (use a name enclosed in angle brackets)
) <fig:2nd_shaft_Torque>

#figure(
table(
  columns: 3,
  stroke: 1pt + black,
  inset: 4pt,
    [], [$"M"_("total") "(lbf)"$], [$"T (lbf·in)"$],
    [A], [0.00],  [0.00],
    [B], [12.1],  [0.521],
    [C], [1.30],  [-0.521],
    [D], [0.00],  [0.00]
),
caption: [Summary of Moments and Torques],
)

The constraint we have is the diameter sizes for the worm gear and the pulley. The mateiral is suitable for the shaft if the minimum diameter calculation at each location is below the allowable diameter determined by those components' bore diameter.

From Mott eqn 12-24,

$
D_min = [
  (32N) / pi sqrt((k_t M / S_n')^2 + (3/4) (T / S_y)^2)
]^(1/3)
$

$K_t = 2.5$ as sharp fillet is used for the shaft shoulders.\
Aluminum is a ductile material so the design factor shoud range from $1.5 < N < 2.5$. We choose $N = 2.0$ for our design.

For the material choice, we want to use an affordable, and easy to machine. Therefore, we will use Aluminum for the shaft material. \
From Mott Appendix 9, we choose Aluminum 2014 O for its high ductility and decent strength as well as cheap cost of about \$1 per inch.
\
#align(center,
  figure(
    table(
      columns: 2,
      stroke: 1pt + black,
      inset: 4pt,
        [$S_u$], [27 ksi],
        [$S_y$], [14 ksi],
        [$S_(n')$], [13 ksi],
    ),
    caption: [Material Properties of Aluminum 2014 O],
  )
)
\
Substituting the values into the minimum diameter equation, we get:
$
D_(min, i) = [
  (64) / pi sqrt((2.5 M_("total", i) / 13000)^2 + (3/4) (T_i / 14000)^2)
]^(1/3) "for" i = A, B, C, D
$
\
Using the 
\
#table(
  columns: 3,
  stroke: 1pt + black,
  inset: 4pt,
    [], [$D_min "(in)"$],[$D_"Allowable" "(in)"$],
    [$D_A$], [0.00],[],
    [$D_B$], [0.362],[0.75],
    [$D_C$], [0.172],[0.25],
    [$D_D$], [0.00], []
)
\
Therefore, the minimum shaft diameter at each location is well below the  allowable shaft diameter determined by the components mounted on the shaft. 
Thus, Aluminum 2014 O is a suitable material for the 2nd shaft.
\




== Bushing Selection and Design Rationale

=== Overview
To suppport both ends of the two shafts in the reduction stage, two sets of Dry-Running Nylon Sleeve bushings were chosen for their minimal wear properties, low cost, and light weight.

=== Key Selection Requirements
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
  &=-3.28 text("lbf"), 3.019 text("lbf"), -1.61 text("lbf") \
  &=-14.5 text("N"), 13.42 text("N"), -7.16 text("N")
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
D = [frac(32 N, pi) sqrt([frac(k_t M, s'_n)]^2+frac(3,4)[frac(T,s_y)]^2) thin]^frac(1,3)
$

All of these parameters were either previously derived or from the diagrams:

$
s'_n = 872.9 text("psi") wide T = 5.886 text("Nm") = 52.1 text("lbf in") \
N = 2.5 wide s_y = 14 text("ksi") wide k_t = 3
$

Plugging in these values yields...
$
D = 0.42 text("in") < 0.625 text("in")
$
so our shaft is fit for our needs!



== Shaft 3 Bearing Calculations
== Belt and Pulley Calculations
A typical stepper motor can outpout around $3000 "rpm"$ and $1.2 "N" dot "m"$ of torque. \
We desire an output speed of around $0.05886 "rpm"$ at $0.0694 "N" dot "m"$ of torque. \
Our system will use this power but we design for the stepper maximum. \
\
From table *ENTER TABLE* we select a 2GMT belt. \
We can assume that the belt is going to run at less than $10 "rpm"$ so from table *ENTER TABLE* 
we select a $6 "mm"$ wide belt and the smaller sprocket size of $18$ grooves which is rated for 
$1.35 "N" dot "m"$ of torque at this speed. \
\
We want the stepper to spin at around $1.1" rpm"$ so then $V R = 14.4$ and to 
reduce complexity we use the same pair of sprockets twice. \
Since a stepper motor can run at variable speed we will say that each belt will 
need a reduction of $1:4$. \ 
So we select the larger sprocket size to be $72$ groove. The pitch diameters 
are found from *ENTER TABLE* to be:
$ p d = 0.301 "in" quad P D = 1.805 "in" $
\
We want the center distance to be small so temporarily select $C D=1.9 "in"$ since
we want to minimize size.\
$ P L = 2 dot C D + [1.57 dot (p d + P D)] + frac((P D - p d)^2, 4 C D) = 1.984 "in" $
\
So using *ENTER TABLE* we select a 2MR-192 belt with a pitch length $P L = 7.559$
which is a stock length. \
$ K = 4 P L - 6.28 dot (P D + p d) $
$ C D = frac(K + sqrt(K^2 - 32(P D - p d)^2), 17 ) = 1.984 "in" $
Giving our center distance.\
Our nominal safety factor is given by $S F = frac(1.35, 0.05886)=23$.\
Our worst case safety factor, which shouldn't occur is $S F = frac(1.35, 1.2)=1.125$.\
Now we calculate the wrap angles to be: \
$phi_(D) = pi - arcsin frac(P D - p d, 2C D) = 2.364 "rad" quad "and" quad phi_(D) 
= pi + arcsin frac(P D - p d, 2C D) = 3.92 "rad"$

= APPENDIX B


