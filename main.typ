#import "@preview/clean-cnam-template:1.3.0": *


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

#set text(
  lang: "en",
  size: 12pt
)

#show figure.where(
  kind: image
): set figure.caption(position: bottom)

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

Before the worm gear a reduction of almost $1:16$ is needed, see #link(<bnpcalc>)[calculations].
We will use a timing belt pulley system as timing belts are accurate with minimal backlash and have
a low noise profile. Due to the high reduction required we will use two timing
belt systems each with a reduction ratio of $1:4$ which in total gives use the required ratio. \

The selection for the Pulley system will use Gate's timing belt manual as it is easy to follow
and has readily available parts. We will use a 2GMT belt as it is appropriate for
our use case. From Gates we select the following pulley's to
get the appropriate speed reduction. \

Smaller sprocket: $18$ groove with $0.301 "in"$ pitch diameter. \
Larger sprocket: $72$ groove with $1.805 "in"$ pitch diameter. \ 

More details for this result can be found in the #link(<bnpcalc>)[appendix]

Next to select the belt our main consideration is the size constraint of the system.
Therefore we will assume a center distance close to the pitch diameter of the 
larger sprocket. Using this assumption we can select a belt after performing some
#link(<bnpcalc>)[calculations]. \

Select *2MR-192* $2 "mm"$ belt with pitch length $7.559 "in"$ and 
center distance of $1.984 "in"$.

This selection gives us wrap angles of $2.36 "rad"$ and $3.92 "rad"$. \
\
This system has a nominal saftey factor of $23$ and a worst case scenario of $1.25$
so the belts have little to no chance of failing or slipping. This is very good
as we require a high precission system.\
The pulleys can be found from McMaster-Carr for \$12 and \$22 and the belt for
under \$6 from motion giving us cheap, reliable and available components.


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


=== Numerical results
Calculations for the following results can be found in #link(<MOTT_worm>)[appendix].
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

=== Results
Calculations for the following results can be found in #link(<Other_worm>)[appendix].
- $p_n  = 0.2608 "in" = 0.006624 "m" $

- $v_(t G) = 0.001508 "ft/min" $

- $K_v approx 1.000 $

- $W_d = 54.701 "N" = 12.293 "lbf" $

- $sigma = 942.6 "psi" = 6.50 "MPa" $

  These are very small total loads on the teeth. Bronze gear fatigue strengths are in the range of 17,000 to 24,000 psi, so this type of loading is more than acceptable. There is no more analysis we can do in this section since (10-42) and beyond apply solely to steel worms and bronze gears.


== Shaft Design 

=== Shaft 1 Selection

#figure(
  image("CFImages/shaft1.jpg", width: 70%),
  caption: [Shaft 1],
)

#figure(
  image("CFImages/gearboxShaft1Image.jpg", width: 70%),
  caption: [Shaft 1 in CAD assembly],
)


=== 2nd Shaft Overview
The 2nd shaft transmits torque from the worm gear to the pulley which drives the timing belt. The shaft is supported by two bushings on either end. The shaft is subjected to forces from the worm gear and pulley as well as reaction forces from the bushings.
\
==== 2nd Shaft Key Specifications:
$"Shaft Length" &: "8-in" \
\
"Worm" &: "1⅝-in long shoulder with ¾-in diameter" \
"Pulley" &: "¾-in long shoulder with ⅕-in diameter" \
"Bushings" &: "¼-in long shoulders with 3/16-in diameter" \
$

#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft_with_components.png", width: 60%),
  // Add a caption using a content block ([...])
  caption: [2nd shaft with components],
  // Add a label fo r referencing (use a name enclosed in angle brackets)
) <fig:2nd_shaft_itself>
\

#grid(
  columns: 2,
  gutter: 1cm,
  figure(
    // The image function goes here (no '#' needed inside figure)
    image("images/2nd_shaft _itself.png", width: 100%),
    // Add a caption using a content block ([...])
    caption: [2nd shaft],
    // Add a label fo r referencing (use a name enclosed in angle brackets)
  ),

  figure(
    // The image function goes here (no '#' needed inside figure)
    image("images/2nd_shaft_FBD.jpeg", width: 100%),
    // Add a caption using a content block ([...])
    caption: [FBD of shaft 2],
    // Add a label for referencing (use a name enclosed in angle brackets)
  )
)

==== 2nd Shaft Design Choice:
The 2nd shaft will be made of Aluminum 2014 O for its high ductility, decent strength, and cheap cost of about \$1 per inch. The shaft diameter is determined by bending and torsional stress calculations to ensure it can withstand the applied loads with an appropriate safety factor. Detailed calculations are provided in Appendix A.


=== Aluminum 2014 O Material Properties
#align(center,
  figure(
    table(
      columns: 2,
      stroke: (x: none),
      row-gutter: (2.2pt, auto),
      table.header[Property][Value],
      [Tensile Strength], [27 ksi],
      [Yield Strength], [14 ksi],
      [Shear Strength], [18 ksi],
      [Endurance Strength], [13 ksi],
    ),
    caption: [Material Properties of Aluminum 2014 O],
  )
)
\
Reasons:
- Cheap (< \$1 per inch)
- Easy to machine
- Required minimum diameter below all components' bore diameter


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

= RESULTS & FINAL DESIGN

= CONLUSIONS & RECOMENDATIONS

= APPENDIX A

== Worm Gear Calculations

Calculate the coefficient of friction to be: 
$ 0.124 e^(-0.74 v_s^0.645)$ (10–26). Due to the very slow speed, but $v_s != 0$, the coefficient is not $0.15$

=== MOTT Calculations <MOTT_worm>
- Tangential force (10–29):
  $ W_(t G) = (2 T_0) / D_G $

- Axial force (10–30):
  $ W_(x G) = W_(t G) (cos phi_n sin lambda + mu cos lambda) / (cos phi_n cos lambda - mu sin lambda) $

- Radial force (10–31):
  $ W_(r G) = (W_(x G) sin phi_n) / (cos phi_n cos lambda - mu sin lambda) $

- Friction force (10–32):
  $ W_f = (mu W_(t G)) / (cos lambda cos phi_n - mu sin lambda) $

=== Other Calculations <Other_worm>
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
== Shaft 2 Calculations

Net driving force on the timing belt pulley is given by:
$
  F_N = T_C / (D_C / 2) = 0.521 "lbf"
$
Bending force on C is given by:
$
  F_C = 1.5 F_N = 0.866 "lbf"
$
Since z components of timing belt cancles out, we only consider x component of $F_C$.

$
F_(C x) = F_C cos(phi) = 0.819 "lbf"
$
Where $phi$ is the angle between the belt and horizontal plane, calculated in above section.\
\
#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft_FBD.jpeg", width: 70%),
  // Add a caption using a content block ([...])
  caption: [FBD of shaft 2],
  // Add a label for referencing (use a name enclosed in angle brackets)
)
\
Point A and D are the bushings, B is the worm gear, and C is the pulley for the timing belt.\
\
Known forces from above calculations are:
#align(center,
  grid(
    columns: 2,
    gutter: 1cm,

    $F_(B x) = 3.28 "lbf" \
    F_(B y) = 2.67 "lbf" \
    F_(B z) = 12.5 "lbf" \ $,

    $F_(C x) = 0.819 "lbf"
    $
  )
)
\
Forces on A and D are calcualated as follows:
\
#align(left,
$Sigma F_x = 0 :$
) $
  -F_(A x) + F_(B x) - F_(C x) - F_(D x) &= 0 \
  F_(A x) + F_(D x) &= F_(B x) - F_(C x) \
  F_(A x) &= F_(B x) - F_(C x) - F_(D x) \
  $

#align(left,
$Sigma F_y = 0 :$
)
  $
  F_(A y) - F_(B y) &= 0 \
  F_(A y) &= F_(B y)
  \
  $

#align(left,
$Sigma F_z = 0 :$
)
  $
  F_(A z) - F_(B z) + F_(D z) &= 0 \
  F_(A z) + F_(D z) &= F_(B z) \
  F_(A z) &= F_(B z) - F_(D z)
  $

#align(left,
$Sigma M_(A x) = 0 :$
)
  $
  -L_(A B)F_(B z) + L_(A D)F_(D z) &= 0 \
  F_(D z) &= L_(A B)/L_(A D)F_(B z) \ 
  $

#align(left,
$Sigma M_(A z) = 0 :$
)
  $
  -L_(A B)F_(B x) + L_(A C)F_(C x) +  L_(A D)F_(D x) &= 0 \
  F_(D x) &= (L_(A B)F_(B x) - L_(A C)F_(C x))/L_(A D) \ 
  $
\
Using the known forces, we get following forces on A and D:

#align(center,
  grid(
    columns: 2,
    gutter: 1cm,  
    $F_(A x) = 3.01 "lbf" \
    F_(A y) = 2.67 "lbf" \
    F_(A z) = 11.7 "lbf" \
    $,
    $F_(D x) = -0.553 "lbf" \
    F_(D y) =  0.00 "lbf" \
    F_(D z) = 0.812 "lbf" \
    $
  )
)
\

#align(center,
  grid(
    columns: 2,
    gutter: 1cm,

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
      caption: [Shear Forces],
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
      caption: [Bending Moments],
    )
  )
)

#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/2nd_shaft_shear_moment.jpeg", width: 70%),
  // Add a caption using a content block ([...])
  caption: [Shear and bending moment diagram],
  // Add a label for referencing (use a name enclosed in angle brackets)
) <fig:2nd_shaft_shear_moment>
\
#align(center,
  block(width: auto,
    grid(
      columns: 2,
      gutter: 1cm,

      figure(
        table(
          columns: 2,
          stroke: 1pt + black,
          inset: 4pt,
            [], [$"T (lbf·in)"$],
            [A], [0.00],
            [B], [0.521],
            [C], [-0.521],
            [D], [0.00]
        ),
        caption: [Torque],
      ),

      figure(
        image("images/2nd_shaft_torque.jpeg", width: 70%),
        caption: [Torque diagram of 2nd shaft],
      ),
    )
  )
)

\
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
\
For the material choice, we want to use an affordable, and easy to machine. Therefore, we will use Aluminum for the shaft material. \
From Appendix B I, we choose Aluminum 2014 O for its high ductility, decent strength, and cheap cost of about \$1 per inch.
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
$K_t = 2.5$ as sharp fillet is used for the shaft shoulders.\
$N = 2.0$ is chosen for our design factor since aluminum is a ductile material and the design factor is in the range of $1.5 < N < 2.5$. 
\
Substituting the values into the minimum diameter equation, we get:
$
D_(min, i) = [
  (64) / pi sqrt((2.5 M_("total", i) / 13000)^2 + (3/4) (T_i / 14000)^2)
]^(1/3) "for" i = A, B, C, D
$
\
Using eqn () and table (), we calculate the minimum shaft diameter at each location: \
\
#align(center,
  figure(
    table(
      columns: 3,
      stroke: 1pt + black,
      inset: 4pt,
        [], [$D_min "(in)"$],[$D_"Allowable" "(in)"$],
        [$D_A$], [0.00],[-],
        [$D_B$], [0.362],[0.75],
        [$D_C$], [0.172],[0.25],
        [$D_D$], [0.00], [-]
    ),
    caption: [Minimum and Allowable Shaft Diameters],
  )
)

\
The minimum shaft diameter at each location is well below the allowable shaft diameter determined by the components. 
Thus, Aluminum 2014 O is a suitable material for the 2nd shaft.
\

== Shaft 3 Calculations



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

*Requirement*

From the acceptable "smear" of pixels, we can calculate a constraint on the RMS variation
of the speed from shaft wobble. To find the maximum RMS variation of the output speed that meets our requirements.

This will depend on the maximum pixel smear permissible $s_("max")$ and the focal length $f$.
$ Delta omega_("max RMS") approx s_("max")/ f = 20 / 50 = 40%_("RMS")  $

The contributors to variance were approximated as coming from manufacturing tolerance, maximum permissible wear, and potential deformation of the bushing and shaft. Since the bushing is much more ductile than the shaft, its deformation dominates.

*Tolerance Calculation Overview*

The goal of this calculation is to determine the maximum amplitude of variation in speed caused by any eccentricity in the bushing
resulting the shaft "warbling" in the bushing. Since the system is very sensitive to speed variations,
a high tolerance bushing with low wear is required.
$ Delta omega_("max") approx 0.00230"rad"/"s" $

This represents $37%_("RMS")$ of the desired speed, which is below the acceptable limit of 40% based on the tracking tolerance of the optical system. Therefore, the design is deemed satisfactory. In-depth calculations can be found in the Appendix.

===== Final Bushing Selection

To support the axial load of the worm gear, a flanged bushing was selected. The low speed of the shafts allows the shaft shoulders to transfer axial load directly into the bushing flange with minimal wear. PEEK was chosen for its low friction, minimal wear, and resilience to moisture, making it suitable for outdoor operation.
The final bushing selected is a 3/8:" shaft diameter, 1/4" long, 11/16" flange OD moisture-resistant, dry-running flanged sleeve bearing from McMaster-Carr.
For design consistency, all bushings are standardized throughout the system. With a unit cost of \$14.84, the total cost for bushings in the design is \$59.36.


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
For nylon on steel, $f_s = 0.3$. Using Shigley Eqn. 12-49.

$
L >= (720  f_s  n_d  F  N) / (J h_("CR")  (T_f - T_("inf"))) $
$
L >= (720  0.3 * 1.0 * 11.6 * 0.000694) / (778 * 2.7 * (300 - 77)) $
$ L >= 4.95"e"-6 "in" $


This is sufficiently smaller than the chosen L = 1/4 in

===== Force and Velocity Calculations

Using the Shigley method of calculating bushing pressure and velocity. Using equations
12-40, 12-41, 12-42.
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

Which is within spec for this application as specified in the Bushing Selection and Design Rationale.


Plugging in these values yields...
$
D = 0.42 text("in") < 0.625 text("in")
$
so our shaft is fit for our needs!


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

We plan to use an angular contact ball bearing at C and a deep groove ball bearing at A. These locations are referenced in the figures
for Shaft 3 Calculations. 

== Aluminum Material Properties

#figure(
  // The image function goes here (no '#' needed inside figure)
  image("images/Mott_appendix_9.png", width: 70%),
  // Add a caption using a content block ([...])
  caption: [Typical Properties of Aluminum from Mott Appendix 9],
  // Add a label for referencing (use a name enclosed in angle brackets)
)
=== Angular Contact Bearing at C
We are finding a bearing to fit our pre-defined shaft diameter of $frac(5,8)$ in, or 15.875 mm. We can use interpolation to find $C_0$ from table 11-2.
For our shaft diameter,

$
C_10 = frac(9.95-8.06, 17-15)*(15.875-15) + 8.06 = 8.87 text("kN")
$

similarly, we interpolate $C_0$

$
C_0 = frac(4.75-3.65,17-15)*(15.875-15) + 3.65 = 4.13 text("kN")
$

Since we have both a thrust and radial force, we need to determine if $frac(F_a,C_0) <= e$ to see if we consider the thrust force in our bearing
calculation. 
$
F_a = sqrt(F_z^2+F_x^2) = 44.9 text("N") \ 
frac(F_a,C_0) = 0.006
$
The lowest value of $e$ on the table is 0.19 for $frac(F_a,C_0) = 0.014$, so we can safely ignore the thrust component and 
set $X_1 = 1$.

$
F_e = X_1 V F_r + Y_1 F_a = 44.9 text("N")
$

We can now calculate our working value for $C_10$ with the following equation:

$
C_10 = 
$

=== Deep Groove Ball Bearing at A 

== Belt and Pulley Calculations <bnpcalc>
A typical stepper motor can outpout around $3000 "rpm"$ and $1.2 "N" dot "m"$ of torque. \
We desire an output speed of around $0.05886 "rpm"$ at $0.0694 "N" dot "m"$ of torque. \
Our system will use this power but we design for the stepper maximum. \
\
From @belt_sizing we select a 2GMT belt. \
We can assume that the belt is going to run at less than $10 "rpm"$ so from table @smaller_sheave 
we select a $6 "mm"$ wide belt and the smaller sprocket size of $18$ grooves which is rated for 
$1.35 "N" dot "m"$ of torque at this speed. \
\
We want the stepper to spin at around $1.1" rpm"$ so then $V R = 14.4$ and to 
reduce complexity we use the same pair of sprockets twice. \
Since a stepper motor can run at variable speed we will say that each belt will 
need a reduction of $1:4$. \ 
So we select the larger sprocket size to be $72$ groove. The pitch diameters 
are found from @pulley_inf:
$ p d = 0.301 "in" quad P D = 1.805 "in" $
\
We want the center distance to be small so temporarily select $C D=1.9 "in"$ since
we want to minimize size.\
$ P L = 2 dot C D + [1.57 dot (p d + P D)] + frac((P D - p d)^2, 4 C D) = 1.984 "in" $
\
So using @belt_selection $P L = 7.559$
which is a stock length. \
$ K = 4 P L - 6.28 dot (P D + p d) $
$ C D = frac(K + sqrt(K^2 - 32(P D - p d)^2), 17 ) = 1.984 "in" $
Giving our center distance.\
Our nominal safety factor is given by $S F = frac(1.35, 0.05886)=23$.\
Our worst case safety factor, which shouldn't occur is $S F = frac(1.35, 1.2)=1.125$.\
Now we calculate the wrap angles to be: \
$phi.alt_(D) = pi - arcsin frac(P D - p d, 2C D) = 2.364 "rad" quad "and" quad phi.alt_(D) 
= pi + arcsin frac(P D - p d, 2C D) = 3.92 "rad"$
== Shaft 1 Force Calculations

As stated earlier, the torque on shaft 1 is 14.7 N*mm. The first stage of the force calculations was determining the direction in which the belt tension acts. In the CAD below, the endview of the gear reducer has been shown, with the diagonal lines representing belts going between pulleys. As can be seen, the belts act at a 19.79 degree angle.

#figure(
  image("CFImages/shaft1Pulleys.jpg", width: 70%),
  caption: [End view of shaft 1, belt angles shown],
)

Then, a FBD diagram was drawn, and forces calculated.

#figure(
  image("CFImages/shaft1FBD.png", width: 70%),
  caption: [Shaft 1 FBD],
)

The FBD shows the reaction forces of bushings at both ends, as well as the forces from the belts.

Next, the forces were calculated. The total force from each pulley was calculated using the torque and pulley radius. Then, using the 19.79 degree angle, the total force was broken up into y and z components. Moment equations around bushing 1 were used to find the reaction forces at bushing 2. Lastly, using $F_("net") = 0$, the reaction forces at bushing 1 were calculated.

#figure(
  image("CFImages/shaft1Forces.jpg", width: 70%),
  caption: [Shaft 1 Forces],
)

From these forces, the following torsion, shear, and bending diagrams were plotted.

#figure(
  image("CFImages/torsionGraph.png", width: 50%),
  caption: [Graph of Torsion vs Position],
)

#figure(
  image("CFImages/yShearGraph.png", width: 50%),
  caption: [Graph of Y Shear vs Position],
)

#figure(
  image("CFImages/zShearGraph.png", width: 50%),
  caption: [Graph of Z Shear vs Position],
)

#figure(
  image("CFImages/yBendingGraph.png", width: 50%),
  caption: [Graph of Y Shear vs Position],
)

#figure(
  image("CFImages/zBendingGraph.png", width: 50%),
  caption: [Graph of Z Bending vs Position],
)

The next step of the force calculations is to determine the stress concentration factors for the setscrew flat and shoulders. Since a specific value was not given, we assumed a conservative stress concentration factor $K_t$ of 2 for the setscrew flat.

For the shoulder we assume a sharp radius, which gives us $K_t = 2.5$.

We then calculate the required minimum diameters.

#figure(
  image("CFImages/aluminumProperties.jpg", width: 70%),
  caption: [Properties of Aluminum 2014 O],
)

We start with endurance strength $S_n = 13"ksi"$ from the table above. We choose $K_a = 0.8$ for machined finish, $K_b = 0.879d^(-0.107) = 1.02$, $K_c = 1$ for no axial load, $K_d = 1$ as operating temperature is around 20 celcius, $K_e = 1$ since we do not require infinite life, and $K_f$ = 1 for no miscelenous factors.

This gives us $S_n' = 10.608 "ksi"$

We then plug in the equation for minimum diameter based on bending and torque 

$ D = ((32N)/pi sqrt(((K_t M)/(s'_n))^2 + (3/4) (T/s_y)^2))^(1/3) $ 

and minimum diameter based on shear 

$ D = sqrt((2.95 K_t V N)/(s'_n)) $

We assume a safety factor N = 2.

That gives us the following minimum diameters. 

#figure(
  image("CFImages/shaft1minD.jpg", width: 70%),
  caption: [Minimum shaft diameters],
)

This gives us a minimum diamter of \~0.1", which is limited by the shear at the small pulley. Therefore shaft 1 is strong enough.


== Shaft 1 & 2 Setscrew Calculations

There are four pulleys which are secured to shafts through setscrews. The ones to fail, if any, would be either pulley 3, which expereinces the highest torque of the small pulleys, or pulley 4, which experiences the highest torque of the large pulleys.

$ T_(max) = (F_(max) D) / 2$

Where $T_(max)$ is the maximum torque the setscrews can trasmit, $F_(max)$ is the setscrew holding power according to the table below, and D is the shaft diameter.

#figure(
  image("CFImages/setscrewTable.png", width: 50%),
  caption: [Shigley table 7-4 Typical Holding Power (Force) for Socket Setscrews],
)

The small pulley uses \#4 setscrews, while the large pulley uses \#8 setscrews.

$ T_("max,sm") = (160*(1/4))/2 "lb"*"in" = 20 "lb"*"in" = 2260 N*"mm" $


$ T_("max,lg") = (385*(1/4))/2 "lb"*"in" = 48.125 "lb"*"in" = 5437 N*"mm" $

After applying a design factor of 2, as Shigley recommends for static loads, we can see that neither setscrew will fail.

$ (1/2)*T_("max,sm") = 1130 N*"mm" > 14.7 N*"mm" $

$ (1/2)*T_("max,lg") = 2718.5 N*"mm" > 58.86 N*"mm" $


= APPENDIX B
== Gates Manual
#figure(
  image("yuvy_images/Gates_manual_selection_zones.png", width: 80%),
  caption: [Belt Size Selection],
) <belt_sizing>
#figure(
  image("yuvy_images/gates_smaller_sheave.png", width: 100%),
  caption: [Smaller Sprocket Selection],
) <smaller_sheave>
#figure(
  image("yuvy_images/sprocket_numbers.png", width: 100%),
  caption: [Pulley Information],
) <pulley_inf>
#figure(
  image("yuvy_images/Gates_manual_belts.png", width: 100%),
  caption: [Belt Selection],
) <belt_selection>
