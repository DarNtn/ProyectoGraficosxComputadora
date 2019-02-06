
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