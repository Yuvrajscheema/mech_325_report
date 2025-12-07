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

= RESULTS & FINAL DEssSIGN

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



= APPENDIX B


