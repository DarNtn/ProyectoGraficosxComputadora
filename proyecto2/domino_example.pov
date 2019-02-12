#include "colors.inc"
#include "textures.inc"

#declare Current = frame_number * 2 + (2000);
#declare Killer = 0;
#declare TDNormal = 1;
#declare TDNormal = 0.5;
#declare Sx = 5;
#declare St = 3;


#declare Sx0 = 0;
#declare Sx1 = 1 * Sx; #declare Sx5 = 5 * Sx; 
#declare Sx2 = 2 * Sx; #declare Sx6 = 6 * Sx; 
#declare Sx3 = 3 * Sx; #declare Sx7 = 7 * Sx; 
#declare Sx4 = 4 * Sx; #declare Sx8 = 8 * Sx; 

#declare St0 = 0;
#declare St1 = 1 * St; #declare St5 = 5 * St; 
#declare St2 = 2 * St; #declare St6 = 6 * St; 
#declare St3 = 3 * St; #declare St7 = 7 * St; 
#declare St4 = 4 * St; #declare St8 = 8 * St; 

//Declaracion de la ficha
#declare Ficha_domino = difference {
box
{
    <-1, 0, -1><0, 4, 1> texture
    {
        pigment { color rgb<0, 0, 0> }
    }
    finish { reflection 0.3 }
}
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

//Funcion para obtener 9 fichas
#macro GiveMeNineMacro(incho)
union
{
    object { Ficha_domino #if (Current > Sx0 + incho) #if ((Current - Sx0 - incho) < 55) #if ((Current - Sx0 - incho) > 15) rotate<0, 0, -2 * (Current - Sx0 - incho) + ((Current - Sx0 - incho - 15) * (1 * ((Current - Sx0 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx0 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St0, 0, 0> }
    object { Ficha_domino #if (Current > Sx1 + incho) #if ((Current - Sx1 - incho) < 55) #if ((Current - Sx1 - incho) > 15) rotate<0, 0, -2 * (Current - Sx1 - incho) + ((Current - Sx1 - incho - 15) * (1 * ((Current - Sx1 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx1 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St1, 0, 0> }
    object { Ficha_domino #if (Current > Sx2 + incho) #if ((Current - Sx2 - incho) < 55) #if ((Current - Sx2 - incho) > 15) rotate<0, 0, -2 * (Current - Sx2 - incho) + ((Current - Sx2 - incho - 15) * (1 * ((Current - Sx2 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx2 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St2, 0, 0> }
    object { Ficha_domino #if (Current > Sx3 + incho) #if ((Current - Sx3 - incho) < 55) #if ((Current - Sx3 - incho) > 15) rotate<0, 0, -2 * (Current - Sx3 - incho) + ((Current - Sx3 - incho - 15) * (1 * ((Current - Sx3 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx3 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St3, 0, 0> }
    object { Ficha_domino #if (Current > Sx4 + incho) #if ((Current - Sx4 - incho) < 55) #if ((Current - Sx4 - incho) > 15) rotate<0, 0, -2 * (Current - Sx4 - incho) + ((Current - Sx4 - incho - 15) * (1 * ((Current - Sx4 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx4 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St4, 0, 0> }
    object { Ficha_domino #if (Current > Sx5 + incho) #if ((Current - Sx5 - incho) < 55) #if ((Current - Sx5 - incho) > 15) rotate<0, 0, -2 * (Current - Sx5 - incho) + ((Current - Sx5 - incho - 15) * (1 * ((Current - Sx5 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx5 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St5, 0, 0> }
    object { Ficha_domino #if (Current > Sx6 + incho) #if ((Current - Sx6 - incho) < 55) #if ((Current - Sx6 - incho) > 15) rotate<0, 0, -2 * (Current - Sx6 - incho) + ((Current - Sx6 - incho - 15) * (1 * ((Current - Sx6 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx6 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St6, 0, 0> }
    object { Ficha_domino #if (Current > Sx7 + incho) #if ((Current - Sx7 - incho) < 55) #if ((Current - Sx7 - incho) > 15) rotate<0, 0, -2 * (Current - Sx7 - incho) + ((Current - Sx7 - incho - 15) * (1 * ((Current - Sx7 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx7 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St7, 0, 0> }
    object { Ficha_domino #if (Current > Sx8 + incho) #if ((Current - Sx8 - incho) < 55) #if ((Current - Sx8 - incho) > 15) rotate<0, 0, -2 * (Current - Sx8 - incho) + ((Current - Sx8 - incho - 15) * (1 * ((Current - Sx8 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx8 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St8, 0, 0> }

}
#end

//Funcion para obtener 1 ficha
#macro GiveMeOneMacro(incho)
union
{
    object { Ficha_domino #if (Current > Sx0 + incho) #if ((Current - Sx0 - incho) < 55) #if ((Current - Sx0 - incho) > 15) rotate<0, 0, -2 * (Current - Sx0 - incho) + ((Current - Sx0 - incho - 15) * (1 * ((Current - Sx0 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx0 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St0, 0, 0> }
}

#end

//Declarar esfera
#declare Sball = sphere{ < 0, 0, 0 >, 2.5 texture{Aluminum } }


#declare Jump_Start  = 0.5;
#declare Jump_Height = 7;
#if (clock < Jump_Start )
 #declare Camera_Y = 1.00;
#else
 #declare Camera_Y = 1.00
   + Jump_Height*
     0.5*(1-cos(4*pi*(clock-Jump_Start)));
#end
// camera ------------------------------------------------------------------
#declare Camera_0 = camera { angle 55
                             location  <-80 , Camera_Y + 20, 85 - clock*100>
                             right     x*image_width/image_height
                             look_at   <-40 , 0, -50>
                             rotate<0,-360*(clock/8 +0.10),0>
                           }
camera{Camera_0}

//Fuentes de luz
light_source{
    <-8, 42, 8>
        color White
}

light_source{
    <40, 14, -40>
        color White}  
        
//Cielo
sky_sphere
{
    pigment
    {
        gradient<0, 1, 0>
            color_map{[0.00 rgb<0.6, 0.7, 1.0>]
                          [0.35 rgb<0.0, 0.1, 0.8>]
                          [0.65 rgb<0.0, 0.1, 0.8>]
                          [1.00 rgb<0.6, 0.7, 1.0>]} scale 2
    }
}
   
//Piso césped
fog{fog_type 2 distance 50 color White
        fog_offset 0.1 fog_alt 2.0 turbulence 0.8}

plane
{
    <0, 1, 0>, 0 texture
    {
        pigment{color rgb<0.35, 0.65, 0.0>} normal{bumps 0.75 scale 0.015} finish { ambient 0.1 diffuse 0.8 }
    }
}

//Esfera de aluminio
object
{
    Sball translate<0, 2.5, 20>
    #if (Current > 2330) translate <-44.7, 0, -14>
    #else #if (Current > 1620)
    #if (Current > 2090) translate <-(Current - 1620) / 16, 0, -29.5 + (Current - 2090) / 16>
    #else translate <-(Current - 1620) / 16, 0, -(Current - 1620) / 16>
    #end
    #end
    #end
}

//Fichas de domino
object{GiveMeNineMacro(2090) rotate<0, 90, 0> translate<-29.1, 0, -13>}
object{GiveMeNineMacro(2140) rotate<0, 90, 0> translate<-29.1, 0, -40>}
object{GiveMeOneMacro(2190) rotate<0, 70, 0> translate<-28, 0, -67>}
object{GiveMeOneMacro(2200) rotate<0, 50, 0> translate<-26, 0, -69.3>}
object{GiveMeOneMacro(2210) rotate<0, 30, 0> translate<-24, 0, -71>}
object{GiveMeOneMacro(2220) rotate<0, 30, 0> translate<-22, 0, -73>}
object{GiveMeOneMacro(2230) rotate<0, 10, 0> translate<-19.5, 0, -74>}
object{GiveMeNineMacro(2240) rotate<0, 0, 0> translate<-16.5, 0, -74>}
object{GiveMeNineMacro(2290) rotate<0, 0, 0> translate<10.5, 0, -74>}
