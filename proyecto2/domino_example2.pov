global_settings { assumed_gamma 1.0 }
#default {finish{ambient 0.1 diffuse 0.9 } }
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "shapes3.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera{perspective angle 75 // front view
location<0.0, 3.0, -13.0>
        right x *image_width / image_height
                                   look_at<0.0, 1.0, 0.0>
}
#declare Camera_1 = camera{/*ultra_wide_angle*/ angle 90 // diagonal view
location<2.0, 2.5, -3.0>
        right x *image_width / image_height
                                   look_at<0.0, 1.0, 0.0>
}
#declare Camera_2 = camera{/*ultra_wide_angle*/ angle 90 //right side view
location<3.0, 1.0, 0.0>
        right x *image_width / image_height
                                   look_at<0.0, 1.0, 0.0>
}
#declare Camera_3 = camera{/*ultra_wide_angle*/ angle 90 // top view
location<0.0, 3.0, -0.001>
        right x *image_width / image_height
                                   look_at<0.0, 1.0, 0.0>
}
camera
{
    Camera_0
#if (frame_number > 200 & frame_number <= 220)
        translate<0, 3, -14>
#elseif(frame_number > 220 & frame_number <= 240)
            translate<0, 3, -13>
#elseif(frame_number > 240 & frame_number <= 260)
                translate<0, 3, -12>
#elseif(frame_number > 260 & frame_number <= 280)
                    translate<0, 3, -11>
#elseif(frame_number > 260 & frame_number <= 500)
                        translate<0, 3, -10>
#elseif(frame_number > 500 & frame_number < 530)
                            translate<0, 3, -8>
#elseif(frame_number >= 530 & frame_number < 560)
                                translate<0, 3, -7>
#elseif(frame_number >= 530 & frame_number < 560)
                                    translate<0, 2, -6>
#elseif(frame_number >= 560 & frame_number < 590)
                                        translate<0, 2, -5>
#elseif(frame_number >= 590 & frame_number < 700)
                                            rotate<0, 60 * clock + 1, 0>
                                                translate<0, 2, 3>
#end
}
// sun ----------------------------------------------------------------------
light_source{<3000, 3000, -3000> color White}
// sky ----------------------------------------------------------------------
plane
{
    <0, 1, 0>, 1 hollow
                   texture
    {
        pigment{bozo turbulence 0.92 color_map{
                    [0.00 rgb<0.2, 0.3, 1> * 0.5]
                        [0.50 rgb<0.2, 0.3, 1> * 0.8]
                        [0.70 rgb<1, 1, 1>]
                        [0.85 rgb<0.25, 0.25, 0.25>]
                        [1.0 rgb<0.5, 0.5, 0.5>]} scale<1, 1, 1.5> *
                2.5 translate<1.0, 0, -1>} // end of pigment
        finish
        {
            ambient 1 diffuse 0
        }
    } // end of texture
    scale 20000
} // end of sky

// TEXTURAS
#declare Segment_Texture =
texture
{
    pigment{bozo} finish { phong 1.0 }
}

#declare Segment_Texture2 =
texture
{
    pigment { agate }
}

#declare Segment_Texture3 =
texture
{
    Polished_Chrome
}

#declare esfera_texture =
texture
{
    pigment{granite} finish { phong 1.0 }
}

#declare esfera_texture2 =
texture
{
    pigment{wood} finish { phong 1.0 }
}

#declare esfera_texture3 =
texture
{
    Polished_Chrome
}

#declare box_Material =
material
{
    texture
    {
        pigment{color rgbt<0, 1, 0, 1>} finish
        {
            ambient 0 diffuse 0 reflection{
                0, 1 fresnel on} conserve_energy
        }
    }
    interior
    {
        ior 1.3
    }
}

#declare box_texture =

texture
{
    White_Wood
        normal{wood 0.5 scale 0.3 turbulence 0.1} finish{phong 1} rotate<60, 0, 45>
            scale 0.2
} // end of texture

#declare box_texture2 =
texture
{
    pigment{color rgb<1, 1, 1> * 0.15} finish
    {
        phong 1 reflection { 0.00 metallic 0.00 }
    }
} // end of texture

#declare box_texture3 =
texture
{
    Polished_Chrome
        pigment{color rgb<0.5, 0.3, 0.8>} normal { crackle 3 scale 0.15 }
    // finish { phong 1}
} // end of texture

#declare torus_texture =
texture
{
    pigment{radial rotate - x * 90} finish { phong 0.4 }
}

#declare torus_texture2 =
texture
{
    pigment { mandel 256 }
}

#declare torus_texture3 =
texture
{
    pigment{checker} finish { phong 0.4 }
} // end of texture
// END TEXTURAS

// SPLINES
// coordinates for the points of a spline
#declare P1 = < -2.00, 1, -2.00 > ;
#declare P2 = < 1.00, 1, -2.00 > ;
#declare P3 = < 2.00, 1, -1.00 > ;
#declare P4 = < 2.00, 1, 2.00 > ;
#declare P5 = < 0.00, 1, 2.00 > ;
#declare P6 = < -2.00, 1, 1.50 > ;
#declare P7 = < -2.00, 1, -1.00 > ;
#declare P8 = < -2.00, 1, -2.00 > ;

//spline2
#declare z1 = < -6.00, 1, 6.00 > ;
#declare z2 = < -6.00, 1, 4.00 > ;
#declare z3 = < -6.00, 1, 2.00 > ;
#declare z4 = < -6.00, 1, 0 > ;
#declare z5 = < -6.00, 1, -2.00 > ;
#declare z6 = < -6.00, 1, -4.00 > ;
#declare z7 = < -6.00, 1, -6.00 > ;
#declare z8 = < -4.00, 1, -6.00 > ;
#declare z9 = < -2.00, 1, -6.00 > ;
#declare z10 = < 0.00, 1, -6.00 > ;
#declare z11 = < 2.00, 1, -6.00 > ;
#declare z12 = < 4.00, 1, -6.00 > ;
#declare z13 = < 6.00, 1, -6.00 > ;
#declare z14 = < 6.00, 1, -4.00 > ;
#declare z15 = < 6.00, 1, -2.00 > ;
#declare z16 = < 6.00, 1, 0 > ;
#declare z17 = < 6.00, 1, 2.00 > ;
#declare z18 = < 6.00, 1, 4.00 > ;
#declare z19 = < 6.00, 1, 6.00 > ;

#declare y1 = < -4.00, 1, 4.00 > ;
#declare y2 = < -4.00, 1, 2.00 > ;
#declare y3 = < -4.00, 1, 0 > ;
#declare y4 = < -4.00, 1, -2.00 > ;
#declare y5 = < -4.00, 1, -4.00 > ;
#declare y6 = < -2.00, 1, -4.00 > ;
#declare y7 = < 0.00, 1, -4.00 > ;
#declare y8 = < 2.00, 1, -4.00 > ;
#declare y9 = < 4.00, 1, -4.00 > ;
#declare y10 = < 4.00, 1, -2.00 > ;
#declare y11 = < 4.00, 1, 0 > ;
#declare y12 = < 4.00, 1, 2.00 > ;
#declare y13 = < 4.00, 1, 4.00 > ;

#declare Spline_tacho_basura =
spline
{
    cubic_spline - 0.150, P7, // control point
        0.300, P1,            // starting point
        0.225, P2,
        0.350, P3,
        0.440, P4,
        0.590, P5,
        0.880, P6,
        1.130, P7,
        1.200, P1, // end point
        1.325, P2  // control point
} // end of spline ---------------

#declare Spline_esfera =
spline
{
    natural_spline - 0.350, z1, // control point
        0.300, z2,              // starting point
        0.125, z3,
        0.250, z4,
        0.420, z5,
        0.490, z6,
        0.780, z7,
        0.900, z8,
        1.000, z9 1.125, z10,
        0.300, z11, // starting point
        0.125, z12,
        0.250, z13,
        0.420, z14,
        0.490, z15,
        0.780, z16,
        0.900, z17,
        1.000, z18 1.125, z19
} // end of spline ---------------

#declare Spline_box =
spline
{
    cubic_spline - 0.350, y1, // control point
        0.300, y2,            // starting point
        0.125, y3,
        0.250, y4,
        0.420, y5,
        0.490, y6,
        0.780, y7,
        0.900, y8,
        1.000, y9 1.125, y10,
        0.300, y11,
        0.125, y12,
        0.250, y13
} // end of spline ---------------

#declare Spline_torus =
spline{
    cubic_spline - 0.300, y2, // starting point
    0.125, y3,
    0.250, y4,
    0.420, y5,
    0.490, y6,
    0.780, y7,
    0.900, y8,
    1.000, y9 1.125, y10,
    0.300, y11,
    0.125, y12,
    0.125, y12,
    0.250, y2} // end of spline ---------------

//END SPLINES

// Create a plane
polygon
{
    5,
        <-10, 0, 10>, <-10, 0, -10>, <10, 0, -10>, <10, 0, 10>, <-10, 0, 10>
#if (frame_number < 200)
                                                                    texture
    {
        pigment{
            checker White Tan
                scale 0.4} finish
        {
            diffuse 0.9
        }
    }
#elseif(frame_number > 200)
    texture
    {
        pigment{
            checker Black Tan
                scale 0.4} finish
        {
            diffuse 0.9
        }
    }
#end
}

//ground floor
fog{fog_type 2 distance 50 color rgb<1, 1, 1> * 0.8 fog_offset 0.1 fog_alt 1.5 turbulence 1.8} //
// ground ----------------------------------
plane
{
    <0, 0.25, 0>, -0.1 texture
    {
        pigment{color rgb<0.22, 0.45, 0>} normal{bumps 0.75 scale 0.015} finish { phong 0.1 }
    } // end of texture
} // end of plane

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

#declare Ray_Profile =
box
{
    <-1, -1, -1>, <1, 1, 1>
                      scale<1, 1, 1> *sqrt(2)

                          texture
    {
        pigment{color rgb<0.5, 1.0, 0.0> * 1.0} finish { phong 1 }
    } // end of texture
    rotate<0, 0, 45>
        scale<1, 0.36, 1>
            rotate<45, 0, 0>
} // end of box ---------------------------------------

#declare Ray =
intersection{
    object{Ray_Profile} object{Ray_Profile scale<1, 1, -1>} box{<-2, -1, -1>, <0, 1, 1>
                                                                                  texture{pigment{color rgb<1, 0.0, 0.3>} finish{phong 1}} // end of texture
                                                                inverse}                                                                   // end of box
    scale<1, 0.5, 0.5>}

//----------------------------------------------------------

//estrella
object
{
    union {
#local Nr = 0;    // start
#local EndNr = 6; // end
#while (Nr < EndNr)
        object
        {
            Ray rotate<0, Nr * 360 / EndNr, 0>
        }

#local Nr = Nr + 1; // next Nr
#end                // ------------- end of loop
    }               // end of union
#if (frame_number < 500)
    scale<0.5, 0.5, 0.5>
        rotate<90, 360 * clock * frame_number / 2, 0> translate<0, 1, 0>
#elseif(frame_number >= 500 & frame_number < 600)
            scale<0.5, 0.5, 0.5> rotate<90, 200 / frame_number> translate<0, 1.5, 0>
#else
    scale <0.5,0.5,0.5> rotate<90,200/frame_number> translate<0,1.5*clock+0.8,0>
#end
}

//------------------------------------------------------- end
//sphere macro
#macro Esfera(Texture)
  sphere { <0,0,0>, 0.75
    texture { Texture
    } // end of texture

    scale<0.3,0.3,0.3>  rotate < 0,360*clock,0>  translate<1.55*clock,1.35,0>
  }
#end // end of sphere macro -----------------------------------

//torus macro
#macro Torus(Texture)
  torus { 0.35,0.15
    texture { Texture}
    scale <0.6,0.6,0.6> rotate<90,360*clock,0> translate<0,0.60,0>
  }
#end
// end of torus macro  -------------------------------

//box macro
#macro Box(Texture)
  box { <0,0,0>,< 1.00, 1.00, 1.00>
    texture { Texture}
    scale <0.5,0.5,0.5>
    rotate< 0,360*clock,0> translate<0.2,1.2,0>
  }
#end
//end of box macro

/* Declaration of worm components*/
#declare Position_1 = < 0, 0.25, 1 > ;


/*macro used to create the worm*/
#macro Worm(radius_segment, radius_ring, Texture)
#local Segment1 =
  sphere{ <radius_ring,0,0>,radius_segment
    texture{Texture}}

  union{

    // lapiz
    object{
      cylinder {
        <0.1,-2,-0.2>, // start
        <0.3,0.5,0.2>, // end
        0.1         // Radius
        open           // Remove end caps
        texture { Polished_Chrome }
      }
    }
    //envase
    object {
      Round_Cylinder_Tube(
        <0.1,-2,-0.2>, // start
        <0.1,-0.8,-0.2>, // end
        0.3, // major radius
        0.03, // border radius
        0, //  1 = filled; 0 = open
        0  //  Merge_On,
      ) // ------------------------------
      texture{ pigment{ color rgb<1,1,1>}
        finish { phong 0.1}
      } // end texture
      scale <1,1,1>
      rotate <0,0,0>
      translate < 0, 0.9, 0>
    } // end of object
    object{Segment1 rotate <0,  0,0>}
    object{Segment1 rotate <0,20+ 20*clock,0>}
    object{Segment1 rotate <0,40+ 40*clock,0>}
    object{Segment1 rotate <0, 60+ 60*clock,0>}
    object{Segment1 rotate <0, 80+80*clock,0>}
    object{Segment1 rotate <0,100+100*clock,0>}
    object{Segment1 rotate <0,120+120*clock,0>}
    object{Segment1 rotate <0,140+140*clock,0>}
    object{Segment1 rotate <0,160+160*clock,0>}
    object{Segment1 rotate <0,180+180*clock,0>}
    object{Segment1 rotate <0,200+ 200*clock,0>}
    object{Segment1 rotate <0,220+ 220*clock,0>}
    object{Segment1 rotate <0,240+ 240*clock,0>}
    object{Segment1 rotate <0,260+ 260*clock,0>}
    object{Segment1 rotate <0,280+ 280*clock,0>}
    object{Segment1 rotate <0,300+300*clock,0>}
    object{Segment1 rotate <0,320+320*clock,0>}
    object{Segment1 rotate <0,340+340*clock,0>}
    object{Segment1 rotate <0,360+360*clock,0>}
  } // end of union
#end // ------------------ end of worm's macro

/*Drawing the sphere*/
#if (frame_number < 100)
  object{
    Esfera(esfera_texture3)
    translate Spline_esfera(clock+0/30)}
  // -------------------------------- end
#elseif(frame_number >= 100 & frame_number < 200)
  object{
    Esfera(esfera_texture2)
    translate Spline_esfera(clock+0/30)}
#elseif(frame_number >= 200)
  object{
    Esfera(esfera_texture3)
    translate Spline_esfera(clock+0/30)}
#end
//end draw sphere.

/* Drawing the torus*/
#if (frame_number < 100)
  object{
    Torus(torus_texture)
    translate Spline_torus(clock+0/30)}
  // -------------------------------- end
#elseif(frame_number >= 100 & frame_number < 200)
  object{
    Torus(torus_texture2)
    translate Spline_torus(clock+0/30)}
#elseif(frame_number >= 200)
  object{
    Torus(torus_texture3)
    translate Spline_torus(clock+0/30)}
#end
//end draw torus

/* Drawing the box*/
#if (frame_number < 100)
  object{
    Box(box_texture)
    translate Spline_box(clock+0/30)}
  // -------------------------------- end
#elseif(frame_number >= 100 & frame_number < 300)
  object{
    Box(box_texture2)
    translate Spline_box(clock+0/30)}
#elseif(frame_number >= 300)
  object{
    Box(box_texture3)
    translate Spline_box(clock+0/30)}
#end
//end draw box

/* Drawing the custom object*/
#if (frame_number < 100)
  object{
    Worm(0.15, 0.50, Segment_Texture)
    translate Spline_tacho_basura(clock+0/30)}
  // -------------------------------- end
#elseif(frame_number >= 100 & frame_number < 200)
  object{
    Worm(0.15, 0.50, Segment_Texture2)
    translate Spline_tacho_basura(clock+0/30)}
#elseif(frame_number >= 200)
  object{
    Worm(0.15, 0.50, Segment_Texture3)
    translate Spline_tacho_basura(clock+0/30)}
#end

// message of pov ray.
difference {
  box{
    <-3,-2, 8>, <4, 2, 8>
    texture{
      pigment{Red}
      normal { wrinkles 0.75 scale 0.01}
      finish { diffuse 0.9 phong 0.2}
    } // end of texture
  }
  text {
    ttf "timrom.ttf" " POV-RAY RLZ!"+0.25, 0
    pigment {
      bozo
      frequency 4            // <- add this line
      color_map {
        [0.00 color Red]
        [0.33 color Blue]
        [0.66 color Yellow]
        [1.00 color Red]
      }
      rotate -45*z
    }
    finish { reflection .25 specular 1 }
    translate <-3,1,8>
  }
}
// end povray message  ------------------------------------------------------------

#declare p1 = < 1, 0, 0 > ;
#declare p2 = < 0, 1, 0 > ;
#declare p3 = < -1, 0, 0 > ;
#declare p4 = < 0, -1, 0 > ;
#declare p5 = < 0, 0, 1 > ;

//Define the polygons for each of the five sides.
//Notice that the last point must be a repetition of the first.
//The first number indicates how many points will be listed.
#declare f1 = polygon{5, p1, p2, p4, p3, p1 };
#declare f2 = polygon{4, p1, p2, p5, p1 };
#declare f3 = polygon{4, p2, p3, p5, p2 };
#declare f4 = polygon{4, p3, p4, p5, p3 };
#declare f5 = polygon{4, p4, p1, p5, p4 };

//Define the pyramid to be the union of its faces.
#declare mypyramid = object{union {
  object{f1}
  object{f2}
  object{f3}
  object{f4}
  object{f5}
}
  texture{ pigment{ granite}
    finish { phong 1.0 }
  }

  rotate <0,90,90>
  translate <1.5,1,4>
  rotate <0, 360*clock,0>
};

//List the defined object(s) to be displayed
mypyramid

#include "povtree_001.inc"
//-------------------------------------------------------------------------------------//
#declare Tree =
  object{ Tree_00
    scale <1,1,1>*1
    rotate<0,0,0>
    translate<0.00, 0.00, 0.00>}
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//

#declare Random_1 = seed(34053); // Use: "rand(Random_1)"
#declare Random_2 = seed(62853); // Use: "rand(Random_2)"
#declare Random_3 = seed(8353);  // Use: "rand(Random_3)"

// planting a row of trees:
union{
#declare Nr = 1;                 // start
#declare EndNr = 10;             // end
#while (Nr < EndNr + 1)

    object{ Tree
      // scaled by random
      scale 1 + 0.5*(-0.5*rand(Random_1)) // (0.75 ~ 1.25)
      // rotated by random
      rotate<10*rand(Random_2),30*(-0.5+rand(Random_2)),0>
      // translate + Random
      translate< 0.25*(-0.5+rand(Random_2)),-0.05, Nr*2.25+0.5*rand(Random_2)>

    } // end of sphere ----------------------

#declare Nr = Nr + 1; // next Nr
#end                  // --------------- end of loop

  rotate<0,0,0>
  translate<11,0,-10>
} // end of union ---- end of row of trees
//----------------------------------------------------------------------------------


union{
#declare Nr = 1;      // start
#declare EndNr = 10;  // end
#while (Nr < EndNr + 1)

    object{ Tree
      // scaled by random
      scale 1 + 0.5*(-0.5*rand(Random_1)) // (0.75 ~ 1.25)
      // rotated by random
      rotate<10*rand(Random_2),30*(-0.5+rand(Random_2)),0>
      // translate + Random
      translate< 0.25*(-0.5+rand(Random_2)),-0.05, Nr*2.25+0.5*rand(Random_2)>

    } // end of sphere ----------------------

#declare Nr = Nr + 1; // next Nr
#end                  // --------------- end of loop

  rotate<0,90,0>
  translate<-15,0,15>
} // end of union ---- end of row of trees
//----------------------------------------------------------------------------------


union{
#declare Nr = 1;      // start
#declare EndNr = 10;  // end
#while (Nr < EndNr + 1)

    object{ Tree
      // scaled by random
      scale 1 + 0.5*(-0.5*rand(Random_1)) // (0.75 ~ 1.25)
      // rotated by random
      rotate<10*rand(Random_2),30*(-0.5+rand(Random_2)),0>
      // translate + Random
      translate< 0.25*(-0.5+rand(Random_2)),-0.05, Nr*2.25+0.5*rand(Random_2)>

    } // end of sphere ----------------------

#declare Nr = Nr + 1; // next Nr
#end                  // --------------- end of loop

  rotate<0,0,0>
  translate<-13,0,-10>
} // end of union ---- end of row of trees

#macro Glass_01(G_R, // radius of glass
  G_H, // height of glass
) //------------------------

  difference{
    cylinder{<0,      0,0>,<0,G_H   ,0>,G_R }
    cylinder{<0,G_R*.05,0>,<0,G_H+.1,0>,G_R*.9}
  } // end of difference

#end // end of macro

//----------------------------------------------------------------------------------
object{
  difference{
    union{
      cylinder{
        <0,0,0>, <0,2.2,0>, 1
        pigment { rgbf <0.5,0.9,1,0.95> } // A blue-tinted glass
        finish
        { phong 0.9 phong_size 40  // A highlight
          reflection 0.2  // Glass reflects a bit
        }
        interior
        { ior 1.5 // Glass refraction
        }
        finish{ambient .4}
        translate<-0.3,0,-3>

      }
      sphere_sweep {
        b_spline
        6,
        <-1,1,0>, .2
        <0,0,0>, .2
        <1,0,0>, .2
        <1,2,0>, .2
        <0,2,0>, .2
        <-1,1,0>, .2

        pigment { rgbf <0.5,0.9,1,0.95> } // A blue-tinted glass
        finish
        { phong 0.9 phong_size 40  // A highlight
          reflection 0.2  // Glass reflects a bit
        }
        interior
        { ior 1.5 // Glass refraction
        }

        finish {ambient .4}
        translate<0.2,0,-3>
      }
    }

    cylinder{
      <0,0,0>, <0,2.3,0>, 0.7
      pigment { rgbf <0.5,0.9,1,0.95> } // A blue-tinted glass
      finish
      { phong 0.9 phong_size 40  // A highlight
        reflection 0.2  // Glass reflects a bit
      }
      interior
      { ior 1.5 // Glass refraction
      }
      finish{ambient .4}
      translate<-0.4,0,-3>
    }

  }
  scale <0.5,0.5,0.5>
  translate <1,1,2>
  rotate < 0,360*clock,0>
}