// global_settings { assumed_gamma 1.0 }
// #default {finish{ambient 0.1 diffuse 0.9 } }

// #include "colors.inc"
// #include "textures.inc"

// #declare Camera_0 = camera{perspective angle 75 // front view
// location<0.0, 3.0, -13.0>
//         right x *image_width / image_height
//                                    look_at<0.0, 1.0, 0.0>
// }
// #declare Camera_1 = camera{/*ultra_wide_angle*/ angle 90 // diagonal view
// location<2.0, 2.5, -3.0>
//         right x *image_width / image_height
//                                    look_at<0.0, 1.0, 0.0>
// }
// #declare Camera_2 = camera{/*ultra_wide_angle*/ angle 90 //right side view
// location<3.0, 1.0, 0.0>
//         right x *image_width / image_height
//                                    look_at<0.0, 1.0, 0.0>
// }
// #declare Camera_3 = camera{/*ultra_wide_angle*/ angle 90 // top view
// location<0.0, 3.0, -0.001>
//         right x *image_width / image_height
//                                    look_at<0.0, 1.0, 0.0>
// }
// camera
// {
//     Camera_0
// #if (frame_number > 200 & frame_number <= 220)
//         translate<0, 3, -14>
// #elseif(frame_number > 220 & frame_number <= 240)
//             translate<0, 3, -13>
// #elseif(frame_number > 240 & frame_number <= 260)
//                 translate<0, 3, -12>
// #elseif(frame_number > 260 & frame_number <= 280)
//                     translate<0, 3, -11>
// #elseif(frame_number > 260 & frame_number <= 500)
//                         translate<0, 3, -10>
// #elseif(frame_number > 500 & frame_number < 530)
//                             translate<0, 3, -8>
// #elseif(frame_number >= 530 & frame_number < 560)
//                                 translate<0, 3, -7>
// #elseif(frame_number >= 530 & frame_number < 560)
//                                     translate<0, 2, -6>
// #elseif(frame_number >= 560 & frame_number < 590)
//                                         translate<0, 2, -5>
// #elseif(frame_number >= 590 & frame_number < 700)
//                                             rotate<0, 60 * clock + 1, 0>
//                                                 translate<0, 2, 3>
// #end
// }

// // sun ----------------------------------------------------------------------
// light_source{<3000, 3000, -3000> color White}

// // sky ----------------------------------------------------------------------
// plane{
//     <0, 1, 0>, 1 hollow
//                    texture{
//                        pigment{bozo turbulence 0.92 color_map{
//                                    [0.00 rgb<0.2, 0.1, 1> * 0.5]
//                                        [0.50 rgb<0.2, 0.3, 1> * 0.8]
//                                        [0.70 rgb<1, 1, 1>]
//                                        [0.85 rgb<0.25, 0.25, 0.25>]
//                                        [1.0 rgb<0.5, 0.5, 0.5>]} scale<1, 1, 1.5> *
//                                2.5 translate<1.0, 0, -1>} finish{
//                            ambient 1 diffuse 0}} scale 20000}

// fog{fog_type 2 distance 50 color rgb<1, 1, 1> * 0.8 fog_offset 0.1 fog_alt 1.5 turbulence 1.8} //
// plane
// {
//     <0, 0.25, 0>, -0.1 texture
//     {
//         // pigment{color rgb<0.22, 0.45, 0>} normal{bumps 0.75 scale 0.015} finish { phong 0.1 }
//     }
// }

// box
// {
//     <-1, -1, -1>
//         <1, 1, 1> scale<0.2, 1, 1>
//             translate<0, 0, 1> texture
//     {
//         pigment { color Pink }
//     }
// }

// box
// {
//     <-1, -1, -1>
//         <1, 1, 1> scale<0.2, 1, 1>
//             translate<0, 0, 4.5> texture
//     {
//         pigment { color Pink }
//     }
// }

// //  box {
// //     <-1, 0,   -1>,  // Near lower left corner
// //     < 1, 0.5,  3>   // Far upper right corner
// //     texture {
// //       T_Stone25     // Pre-defined from stones.inc
// //       scale 4       // Scale by the same amount in all
// //                     // directions
// //     }
// //     rotate y*20     // Equivalent to "rotate <0,20,0>"
// //   }

// POV-Ray 3.6 / 3.7 Scene File "cam_rot1".pov"
// created by Friedrich A. Lohmüller, 2003-2013
// Demonstrates rotating camera
//--------------------------------------------------------------------------
#version 3.6;
global_settings { assumed_gamma 1.3 }
//--------------------------------------------------------------------------
#include "shapes.inc"
#include "colors.inc"
#include "textures.inc"
#include "skies.inc"
#include "metals.inc"
#include "woods.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera{angle 35
location<3.0, 1.0, -20.0>
        right x *image_width / image_height

                                   look_at<-1.0, 3.5, 5.0>
                                       rotate<0, -360 * (clock + 0.10), 0>
}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<1500, 2500, -2500> color White * 0.95} light_source{<1500, 2500, 2500> color White * 0.1}
// sky ---------------------------------------------------------------------
sky_sphere
{
    pigment
    {
        gradient<0, 1, 0>
            color_map{[0.00 rgb<0.6, 0.7, 1.0>]
                          [0.35 rgb<0.0, 0.1, 0.8>]
                          [0.65 rgb<0.0, 0.1, 0.8>]
                          [1.00 rgb<0.6, 0.7, 1.0>]} scale 2
    } // end of pigment
} //end of skysphere -------------------------------------
// fog ---------------------------------------------------------------------
fog{fog_type 2 distance 50 color White
        fog_offset 0.1 fog_alt 2.0 turbulence 0.8}
// ground ------------------------------------------------------------------

plane
{
    <0, 1, 0>, 0 texture
    {
        pigment{color rgb<0.35, 0.65, 0.0>} normal{bumps 0.75 scale 0.015} finish { ambient 0.1 diffuse 0.8 }
    } // end of texture
} // end of plane

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
box
{
<-2.0, -0.2, -2.0>, <1.0, 0.2, 1.0>
                            finish{
                                ambient 0.2 diffuse 0.8} pigment{color White}

    rotate<90, 0, 0>
}

// union { // a little church

//     box{<-1, 0, -1>, <1, 5, 1>
//                          texture{pigment{color White} finish{ambient 0.15 diffuse 0.85 phong 1}} // end of texture
//         scale<1, 1, 1>
//             rotate<0, 0, 0>
//                 translate<0, 0, 0>} // end of box

//     intersection{
//         // linear prism in x-direction: from ... to ..., number of points (first = last)
//         prism{-1.00, 1.00, 4 < -1.00, 0.00 >, <1.00, 0.00>, <0.00, 1.50>, <-1.00, 0.00> rotate<-90, -90, 0> //turns prism in x direction! Don't change this line!
//                                                                               texture{pigment{color Scarlet} finish{ambient 0.15 diffuse 0.85 phong 1.0}} rotate<0, 0, 0>
//                                                                                   translate<0, 0, 0>} // end of prism --------------------------------------------------------
//         // linear prism in z-direction: from ,to ,number of points (first = last)
//         prism{-1.00, 1.00, 4 < -1.00, 0.00 >, <1.00, 0.00>, <0.00, 2.00>, <-1.00, 0.00> rotate<-90, 0, 0> scale<1, 1, -1> //turns prism in z direction! Don't change this line!
//                                                                               texture{pigment{color Scarlet} finish{ambient 0.15 diffuse 0.85 phong 1.0}} rotate<0, 0, 0>
//                                                                                   translate<0, 0, 0>} // end of prism --------------------------------------------------------
//         scale<1.1, 0.5, 1.1>
//             translate<0, 5, 0>}

//     // linear prism in z-direction: from ,to ,number of points (first = last)
//     prism{-0.00, 5.00, 6

//                            < -2.00,
//           0.00 >,
//           <2.00, 0.00>,
//           <2.00, 2.00>,
//           <0.00, 3.00>,
//           <-2.00, 2.00>,
//           <-2.00, 0.00>
//               rotate<-90, 0, 0>
//                   scale<1, 1, -1> //turns prism in z direction! Don't change this line!
//                       texture{pigment{color White} finish{ambient 0.15 diffuse 0.85 phong 1.0}} rotate<0, 0, 0>
//                           translate<-3, 0, 0>} // end of prism --------------------------------------------------------

//     // linear prism in z-direction: from ,to ,number of points (first = last)
//     prism{-0.05, 5.05, 7

//                            < -2.00,
//           2.00 >,
//           <0.00, 3.00>,
//           <2.00, 2.00>,
//           <2.00, 2.05>,
//           <0.00, 3.05>,
//           <-2.00, 2.05>,
//           <-2.00, 2.00>
//               rotate<-90, 0, 0>
//                   scale<1, 1, -1> //turns prism in z direction! Don't change this line!
//                       texture{pigment{color Scarlet} finish{ambient 0.15 diffuse 0.85 phong 1.0}} rotate<0, 0, 0>
//                           translate<-3, 0, 0>} // end of prism --------------------------------------------------------

//     translate<2.0, 0, -2>
// }
//-----------------------------------------------------------------------------
