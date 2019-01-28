#include "colors.inc"

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

light_source{
    <10, 10, -10> color White}

cylinder
{
    <0, 1, 0>,
        <0, -1, 0>, 2 texture
    {
        pigment { Red }
    }
}