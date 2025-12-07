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
$ e_("RMS") = sqrt(e_("tolerance")^2 + e_("wear")^2 + e_("deformation")^2) $

$ Delta omega_("max") approx (e_("RMS"))/(2 pi R) Omega $

$ Delta omega_("max") approx 0.000566"rad"/"s" $

This represents $43%_("RMS")$ of the desired speed, which is below the acceptable limit of 50% based on the tracking tolerance of the optical system. Therefore, the design is deemed satisfactory. In-depth calculations can be found in the Appendix.

===== Final Bushing Selection

To support the axial load of the worm gear, a flanged bushing was selected. The low speed of the shafts allows the shaft shoulders to transfer axial load directly into the bushing flange with minimal wear. PEEK was chosen for its low friction, minimal wear, and resilience to moisture, making it suitable for outdoor operation.
The final bushing selected is a 3/16" shaft diameter, 1/4" long, 3/8" flange OD moisture-resistant, dry-running flanged sleeve bearing from McMaster-Carr.
For design consistency, all bushings are standardized throughout the system. With a unit cost of \$5.44, the total cost for bushings in the design is \$21.76.


= RESULTS & FINAL DESIGN

= CONLUSIONS & RECOMENDATIONS

= APPENDIX A

=== Bushing Calculations



= APPENDIX B
