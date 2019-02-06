#include "colors.inc"
#include "textures.inc"

#declare BasicBox1 = difference {
box
{
    <-1, 0, -1><0, 4, 1> texture
    {
        pigment { color rgb<0, 0, 0> }
    }
    finish { reflection 0.3 }
} //  finish {reflection 0.3}   <<<<!
  //frez========
cylinder
{
    <-1, -1, -1><-1, 5, -1> 0.18 texture
    {
        pigment { color rgb<0, 0, 0> }
    }
    finish { reflection 0.3 }
}
cylinder
{
    <0, -1, -1><0, 5, -1> 0.18 texture
    {
        pigment { color rgb<0, 0, 0> }
    }
    finish { reflection 0.3 }
}
cylinder
{
    <-1, -1, 1><-1, 5, 1> 0.18 texture
    {
        pigment { color rgb<0, 0, 0> }
    }
    finish { reflection 0.3 }
}
cylinder
{
    <0, -1, 1><0, 5, 1> 0.18 texture
    {
        pigment { color rgb<0, 0, 0> }
    }
    finish { reflection 0.3 }
}
}