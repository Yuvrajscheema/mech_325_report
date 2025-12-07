#import "@preview/grape-suite:3.1.0": german-dates, seminar-paper

#set text(lang: "en")

= Shaft 1 Selection

#figure(
  image("CFImages/shaft1.jpg", width: 70%),
  caption: [Shaft 1],
)

#figure(
  image("CFImages/gearboxShaft1Image.jpg", width: 70%),
  caption: [Shaft 1 in CAD assembly],
)


= Appendix A: 
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
