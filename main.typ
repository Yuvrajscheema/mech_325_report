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

== Belt and Pulley Design

=== Overview
Before the worm gear a reduction of almost 1:16 is needed, as found in . For this we will use 
a two pulley system

== Worm Gear Selection

== Shaft Design 

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

To support the axial load of the worm gear, so a flanged bushing is used. The low speed of the shafts allow the 
shoulder of the shafts to directly transfer axial load into the bushing flange with minimal wear. Nylon is perfect for this
because of its low friction and minimal wearing properties.

Price was also another important consideration, which the Nylon bushings meet, with a unit price of \$4.59.

In total this is why Dry-Running Nylon Sleeve bushings were selected.

= RESULTS & FINAL DESIGN

= CONLUSIONS & RECOMENDATIONS

= APPENDIX A

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
