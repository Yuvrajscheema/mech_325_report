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

== Worm Gear Selection

== Shaft Design 

=== 2nd Shaft Analysis
#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft_FBD.jpeg", width: 70%),
  // Add a caption using a content block ([...])
  caption: [FBD of 2nd shaft],
  // Add a label for referencing (use a name enclosed in angle brackets)
) <fig:2nd_shaft_FBD>



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

#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft_torque.jpeg", width: 70%),
  // Add a caption using a content block ([...])
  caption: [Torque diagram of 2nd shaft],
  // Add a label for referencing (use a name enclosed in angle brackets)
) <fig:2nd_shaft_Torque>

#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft_shear_moment.jpeg", width: 70%),
  // Add a caption using a content block ([...])
  caption: [Shear and bending moment diagram],
  // Add a label for referencing (use a name enclosed in angle brackets)
) <fig:2nd_shaft_shear_moment>

#table(
  columns: 3,
  stroke: 1pt + black,
  inset: 4pt,
    [],[$"V"_("horizontal") "(lbf)"$],  [$"V"_("vertical") "(lbf)"$],
    [A],[-3.01],              [11.7],
    [B],[0.267],               [-0.812],
    [C],[-0.553],              [-0.812],
    [D],[0.00],                [0.00]
)

#table(
  columns: 4,
  stroke: 1pt + black,
  inset: 4pt,
    [], [$"M"_("horizontal plane") "(lbf)"$], [$"M"_("vertical plane") "(lbf)"$], [$"M"_("total") "(lbf)"$],
    [A],[0.00],[0.00],[0.00],
    [B],[-3.01],[11.7],[12.1],
    [C],[-1.23],[0.406],[1.30],
    [D],[0.00],[0.00],[0.00]
)

#table(
  columns: 2,
  stroke: 1pt + black,
  inset: 4pt,
    [], [$"T (lbf·in)"$],
    [A], [0.00],
    [B],   [0.521],
    [C],   [-0.521],
    [D], [0.00]
)

#table(
  columns: 3,
  stroke: 1pt + black,
  inset: 4pt,
    [], [$"M"_("total") "(lbf)"$], [$"T (lbf·in)"$],
    [A], [0.00],  [0.00],
    [B], [12.1],  [0.521],
    [C], [1.30],  [-0.521],
    [D], [0.00],  [0.00]
)

From Mott Appendix 9, we choose Aluminum 2014 O.

#table(
  columns: 2,
  stroke: 1pt + black,
  inset: 4pt,
    [], [Aluminum 2014 O],  
    [$S_u$],[27 ksi],
    [$S_y$],[14 ksi],
    [$S_n '$],[13 ksi]
)

Sharp fillet is used for the shaft shoulders so $K_t = 2.5$ \
Aluminum is a ductile material so the deisgn shoud range from $1.5 < N < 2.5$. We choose $N = 2.0$ for our design.

From Mott eqn 

$D_min = [
  (32N) / pi sqrt((k_t M / S_n')^2 + (3/4) (T / S_y)^2)
]^(1/3)$

$D_(min, i) = [
  (64) / pi sqrt((2.5 M_("total", i) / 13000)^2 + (3/4) (T_i / 14000)^2)
]^(1/3)$
for $i = A, B, C, D$

#table(
  columns: 2,
  stroke: 1pt + black,
  inset: 4pt,
    [], [$D_min "(in)"$],
    [$D_A$], [0.00],
    [$D_B$], [0.362],
    [$D_C$], [0.172],
    [$D_D$], [0.00]
)





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

To support the axial load of the worm gear, so a flanged bushing is used. The low speed of the shafts allow the 
shoulder of the shafts to directly transfer axial load into the bushing flange with minimal wear. Nylon is perfect for this
because of its low friction and minimal wearing properties.

Price was also another important consideration, which the Nylon bushings meet, with a unit price of \$4.59.

In total this is why Dry-Running Nylon Sleeve bushings were selected.

= RESULTS & FINAL DESIGN

= CONLUSIONS & RECOMENDATIONS

= APPENDIX A

= APPENDIX B
