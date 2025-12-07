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

In total this is why Dry-Running Nylon Sleeve bushings were selected.+

= RESULTS & FINAL DESIGN

= CONLUSIONS & RECOMENDATIONS

= APPENDIX A

= APPENDIX B
