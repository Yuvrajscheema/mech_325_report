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

The fundemental challenge of astrophotography is the amount of light gathered by a camera. While most cameras have no problem capturing photos in bright daylight, deep space objects and stars tend to be very dim. The amount of light gathered by a lens or telescope depends on a few factors, one of which is  its cross-sectional area (or _aperture_). To capture increasingly darker objects, it quickly becomes impractical to increase the diameter of the lens. A much more appropriate solution is to gather light for over a longer period of time at the camera, but this introduces its own issues.

The main issue is that if a camera is held pointing at a particular area of the sky, over a significant period of time (as little as 2-4 seconds on a regular 50mm lens & camera), the earth will have rotated slightly, and the camera will be pointing in a marginally different direction. The net result of this is called _star streaking_ where instead of appearing as points, stars appear as _lines or arcs_ around the north star.

IMAGE HERE 

An _Equatorial Mount_ is a mechanical device intended to solve this issue. It was first invented in 1842, and its design has largely remained unchanged since. The idea is to mount your camera and have it rotate around one axis. This axis is the polar axis, and it points at the north star (polaris), which does not move in the sky from the perspective of an observer on Earth.

IMAGE HERE

== 3D Printing
The advent of affordable 3D printing technology has fundamentally transformed the landscape of all hobbyist and amateur technical pursuits. Hobbies, such as astrophotography, which previouly required boutique and expensive products are now being approached from a new  perspective. Desktop 3D printers, which have dropped in price from tens of thousands to just a few hundred dollars over the past decade, have democratized the ability to rapidly prototype and fabricate custom tools. This accessibility has enabled hobbyists to tackle increasingly sophisticated projects that would have been impractical or impossible just years ago. The maker community has flourished as enthusiasts share designs, collaborate on complex builds, and push the boundaries of what can be achieved outside traditional manufacturing settings. 

IMAGE HERE

Astrophotography is one such older hobby with already established industry that serves it. All forms of telescopes, filters, cameras, mounts, controllers, and respective accessories already exist on the market, but due to the small volume of products these companies sell, design and manufacturing remains very expensive and outside of the range of many hobbiysts. In particular, equatorial mounts from astrophotography hobbyist stores can cost anywhere between \$1000 and \$10,000 CAD. 

= PURPOSE

= DETAILED ANALYSIS

== RPM Considerations

== Worm Gear Selection
For the fine resolution required at the output, it was important to able to do large gear ratios for the last stage of the drive. After the 1:16 ratio of the timing belt drive stage, a solution was needed to achieve single stage large ratio in the magnitude of 1:100. In reality, there are several ways to achieve this (e.g. see #link("https://en.wikipedia.org/wiki/Cycloidal_drive")[Cycloidal Drives]) but a solution for high ratios explicitly recommended by Mott and Shigley is a worm gear drive. These are sold commercially in gear ratios of up to 1:100 and this was what was selected for the final design. 

A worm and worm gear set from rushgears.com, and American manufacturing company was selected. This manufacturer sells standard gears but can also grind custom gears if required. We selected the WB12L and WB1200L gears for our prototype. The set is a 12 pitch, has a 14.5° standard pitch angle and a very low 4.6° lead angle. The worm has a signle thread and the worm gear has 100 teeth. The self-locking feature is somewhat important to ensure that unbalanced loads are not created on the rest of the system.

Due to the low power and speed conditions under which this worm drive will run, consideration of the material in terms of maximum strength is not as critical as the precision of the drive. While theoretically any material can be used as the worm and worm gear material, commercially, it is easiest to find bronze or cast iron gears. For this project, we selected bronze as opposed to cast iron for its precise machinability. For the final product, whatever is a good tradeoff between wear, precision, and cost would be selected. 

In most other precision applications, the use of a worm gear may not be ideal due to the fundemental nature of gear backlash, but thankfully, this is not a concern here. Over the course of an exposure (and over the course of the night), the base only ever rotates in one direction. Thus, as far as precision is concened, all we can really do quantatively for this section with the tools learned in MECH 235 is analyze the forces and confirm that they are acceptable for the given material. 

Given the  $5.886 N dot m m$ output torque, we can analyze the forces of the worm and gear as follows.

=== Given

- Pitch diameter: $D_G = 8.333 "in" = 0.2116582 "m"$
- Torque on worm wheel: $T_0 = 5.789 "N·m"$
- Normal pressure angle: $phi_n = 14.5°$
- Worm lead angle: $lambda = 4.7666°$ (= 0.083176 rad)
- Coefficient of friction: $mu = 0.124$

The coefficient of friction is calculated using $ 0.124 e^(-0.74 v_s^0.645)$ (10–26). Due to the very slow speed, but $v_s != 0$, the coefficient is not $0.15$

=== Mott equations

- Tangential force (10–29):
  $ W_(t G) = (2 T_0) / D_G $

- Axial force (10–30):
  $ W_(x G) = W_(t G) (cos phi_n sin lambda + mu cos lambda) / (cos phi_n cos lambda - mu sin lambda) $

- Radial force (10–31):
  $ W_(r G) = (W_(x G) sin phi_n) / (cos phi_n cos lambda - mu sin lambda) $

- Friction force (10–32):
  $ W_f = (mu W_(t G)) / (cos lambda cos phi_n - mu sin lambda) $

=== Numerical results

- $W_(t G) = 54.701 "N"$

- $W_(x G) = 11.698 "N"$ (axial / along worm axis)

- $W_(r G) = 3.068 "N"$ (radial, toward gear center)

- $W_f = 7.104 "N"$ (friction force, parallel to tooth face)

- Resultant contact force: $W_c = sqrt(54.701^2 + 11.698^2 + 3.068^2) = 55.951 "N"$

As we can see, these forces are extremely small. 

=== Given additional parameters

- Face width: $F = 0.5 "in" = 0.0127 "m"$
- Gear speed: $n_G = 0.000694 "rpm"$
- Diametral pitch: $P_d = 12 "teeth/in"$
- Lewis form factor (for $phi_n = 14.5°$): $y = 0.100$

=== Calculations

- Normal circular pitch (10–38):
  $ p_n = (pi cos lambda) / P_d = 0.2608 "in" = 0.006624 "m" $

- Pitch line speed (10–41):
  $ v_(t G) = (pi D_G n_G) / 12 = 0.001508 "ft/min" $

- Velocity factor (10–40):
  $ K_v = 1200 / (1200 + v_(t G)) = 1200 / (1200 + 0.001508) = 0.99999874 approx 1.000 $

- Dynamic load (10–39):
  $ W_d = 54.701 "N" = 12.293 "lbf" $

- Tooth bending stress (10–37):
  $ sigma = W_d / (y F p_n) = (12.293 "lbf") / (0.100 times 0.5 "in" times 0.2608 "in") = 942.6 "psi" = 6.50 "MPa" $

  These are very small total loads on the teeth. Bronze gear fatigue strengths are in the range of 17,000 to 24,000 psi, so this type of loading is more than acceptable. There is no more analysis we can do in this section since (10-42) and beyond apply solely to steel worms and bronze gears.


== Shaft Design 

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
