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

== Bushing Selection and Design Rationale

=== Overview
To support both ends of the two shafts in the reduction stage, two sets of Moisture-Resistant Dry-Running Flanged Sleeve Bearings were chosen for their minimal wear properties, high tolerances, low cost, and light weight.

==== Key Selection Requirements
+ The bushings must have minimal wear to maintain the accuracy of rotational speed.
+ The bushings must require minimal maintenance and eliminate lubrication requirements for the convenience of hobbyists.
+ Minimize length to keep the overall reduction stage compact.
+ Be resilient to moisture for outdoor operation.

Bushings were selected instead of bearings due to the small loads involved, which reduces cost and minimizes space requirements. Dry bushings eliminate lubrication requirements and reduce maintenance, improving reliability and ease of construction for hobbyists.
The low forces in this system allow the use of inexpensive bushings without compromising performance. The dominant selection criterion was tolerance.

===== Tolerances

A key requirement for the StarTracker is high accuracy with minimal speed variation. Bushing selection plays a role in achieving this. The primary contributors to speed variation are:

- _Eccentricity:_ radial play between the shafts and bushings can lead to wobble in the reduction system.  
- _Friction (stick–slip):_ high friction can produce stick–slip motion, generating speed fluctuations.  
- _Elastic deformation:_ loading of the bushing can compress it, introducing additional eccentricity.

*Assumptions*

+ The shaft rolls without slipping.  
+ Shaft deflection at the bushing is negligible compared to bushing deformation.  
+ Eccentricities are small enough that the small-angle approximation applies.

The contributors to variance were approximated as coming from manufacturing tolerance, maximum permissible wear, and potential deformation of the bushing and shaft. Since the bushing is much more ductile than the shaft, its deformation dominates.

*Tolerance Calculation Overview*

The goal of this calculation is to determine the maximum amplitude of variation in speed caused by eccentricity. Calculations focus on the first stage of reduction, where speed is highest.
The overall eccentricity was approximated as the root-mean-square (RMS) of all considered contributions:
#show table.cell.where(y: 0): strong

#set table(
  stroke: (x, y) => if y == 0 { (bottom: 0.7pt + black) },
  align: (x, y) => if x == 0 { left } else { center }
)
#set align(center)
#table(
  columns: 2,
  table.header(
    [Symbol],
    [Description]
  ),
  [R], [Input pulley radius (inches)],
  [$Omega$], [Shaft angular speed (rad/s)],
  [e], [Eccentricity of the bushing (inches)]
)
#set align(left)

$ Delta omega_("max") approx 0.00230"rad"/"s" $

This represents $37%_("RMS")$ of the desired speed, which is below the acceptable limit of 50% based on the tracking tolerance of the optical system. Therefore, the design is deemed satisfactory. In-depth calculations can be found in the Appendix.

===== Final Bushing Selection

To support the axial load of the worm gear, a flanged bushing was selected. The low speed of the shafts allows the shaft shoulders to transfer axial load directly into the bushing flange with minimal wear. PEEK was chosen for its low friction, minimal wear, and resilience to moisture, making it suitable for outdoor operation.
The final bushing selected is a 3/8:" shaft diameter, 1/4" long, 11/16" flange OD moisture-resistant, dry-running flanged sleeve bearing from McMaster-Carr.
For design consistency, all bushings are standardized throughout the system. With a unit cost of \$6.42, the total cost for bushings in the design is \$25.68.


= RESULTS & FINAL DESIGN

= CONLUSIONS & RECOMENDATIONS

= APPENDIX A

=== Bushing Calculations

===== Geometery Calculations
From the shaft diameter, choose D = 3/16 in  
To minimize the footprint, select a minimal length L = 1/4 in  
This satisfies

$
0.5 <= L / D <= 2.0
$


This bearing application requires high precision, with low lubrication, but remains under constant load. Since the application is non-critical, a safety factor of 2 will be used:

$
n_d = 2.0
$


Validate length under thermal conditions.

*Assumptions*:  

The StarTracker will only be operated at night and is primarily targeted to hobbyists in North America.  
$T_("inf") = 77$ F - Typical summer nighttime temperature near the 49th parallel.  
For nylon on steel, $f_s = 0.3$

$
L >= (720  f_s  n_d  F  N) / (J h_("CR")  (T_f - T_("inf"))) $
$
L >= (720  0.3 * 1.0 * 11.6 * 0.000694) / (778 * 2.7 * (300 - 77)) $
$ L >= 4.95"e"-6 "in" $


This is sufficiently smaller than the chosen L = 1/4 in

===== Force and Velocity Calculations
At the point experiencing the greatest load (next to the worm gear):

$
P_("max") = (4 / pi)  (F  n_d) / (D  L) = ((4 / pi)  11.6) / ((3/16)(1/4)) = 388.71 "psi" < 4,500 "psi"
$

$
V = (pi  D  N  n_d) / 12 = 6.81"e"-5 "fpm" < 400 "fpm"
$

$
P V = 0.00520 "psi-fpm" < 25,000 "psi-fpm"
$

The bushing selected comforatbly meets the requirements for presure and velocity.

===== Tolerance Calculations


*Assumptions*

 1. The primary assumption for calculations done to specify the tolerances on the bushings that the primary effect of bushing wear and ill-tolerancing impact the eccentricity of the 
  shaft rotating inside of the bushing. Due to small loads and low friction effects like
  stick-slip and major shaft misalignment and deflections can be ignored. 
2. The next assumption is that eccentricity comes from three primary sources:
    - Bushing tolerances: Assume worst case senario as eccentric as possible
    - Wear: Eccentricity caused by runout
    - Compression: Eccentricity caused by compression of the bushing

To calculate the maximum possible eccentricity, find the sum of all of the maximum possible
displacements. Displacements come from the material properties of the bushing, the manufactuer specified tolerance
on the inner diameter (contacting the shaft) and the lifetime of the bushings.

$ delta_("tolerance") = 0.001 "in" $
$ delta_("wear") = 0.0001 "in" $
$ delta_("deformation") = sigma / E = 328 "psi" / 435000 "psi" = 0.00075 "in" $

#figure(
  image("sam_images/eccentricity.jpg", width: 70%),
  caption: [ Demonstration of how displacement is being converted to eccentricity
  ],
)

Now calculating the eccentricity where $d$ is the diameter of the shaft.

$ e = sqrt(1 - (d/ (d + delta_("tolerance") + delta_("wear") + delta_("deformation") ))^2) $
$ e = 0.0989 $

Then to find the variation in speed, since eccentricity is small, a small angle approximation
can be used. Then using the output speed of the reduction system, the variation of the speed 
can be found.
$ Delta omega approx e / R omega_0 = 0.0989 /((1/2)(3/8)) (0.000694 "rpm") 2 pi $

Then comparing the $Delta omega$ to the operating $omega$ 

$ (Delta omega) / omega = 0.5278 $
 Which gives an RMS within $50%$ of $omega$

$ ((Delta omega) / omega)_("RMS") = 37.7% $

Which is within spec for this application


= APPENDIX B
