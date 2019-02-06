#include "colors.inc"
#include "textures.inc"

//
//=======================================
//

#declare Current = frame_number * 2 + (2000); //1610,
#declare Killer = 0;
#declare TDNormal = 1;   //time inhibitor
#declare TDNormal = 0.5; //bullet time
#declare Sx = 15;        //separator
#declare St = 3;         //translation
#declare Relax1 = -70;

#declare Direx = 1;
#declare BasicRotator1 = -frame_number;

#declare Sx0 = 0;
#declare Sx1 = 1 * Sx; #declare Sx5 = 5 * Sx; #declare Sx9 = 9 * Sx; #declare Sx13 = 13 * Sx; #declare Sx17 = 17 * Sx; #declare Sx21 = 21 * Sx; #declare Sx25 = 25 * Sx; #declare Sx29 = 29 * Sx;
#declare Sx2 = 2 * Sx; #declare Sx6 = 6 * Sx; #declare Sx10 = 10 * Sx; #declare Sx14 = 14 * Sx; #declare Sx18 = 18 * Sx; #declare Sx22 = 22 * Sx; #declare Sx26 = 26 * Sx; #declare Sx30 = 30 * Sx;
#declare Sx3 = 3 * Sx; #declare Sx7 = 7 * Sx; #declare Sx11 = 11 * Sx; #declare Sx15 = 15 * Sx; #declare Sx19 = 19 * Sx; #declare Sx23 = 23 * Sx; #declare Sx27 = 27 * Sx; #declare Sx31 = 31 * Sx;
#declare Sx4 = 4 * Sx; #declare Sx8 = 8 * Sx; #declare Sx12 = 12 * Sx; #declare Sx16 = 16 * Sx; #declare Sx20 = 20 * Sx; #declare Sx24 = 24 * Sx; #declare Sx28 = 28 * Sx; #declare Sx32 = 32 * Sx;

#declare St0 = 0;
#declare St1 = 1 * St; #declare St5 = 5 * St; #declare St9 = 9 * St; #declare St13 = 13 * St; #declare St17 = 17 * St; #declare St21 = 21 * St; #declare St25 = 25 * St; #declare St29 = 29 * St;
#declare St2 = 2 * St; #declare St6 = 6 * St; #declare St10 = 10 * St; #declare St14 = 14 * St; #declare St18 = 18 * St; #declare St22 = 22 * St; #declare St26 = 26 * St; #declare St30 = 30 * St;
#declare St3 = 3 * St; #declare St7 = 7 * St; #declare St11 = 11 * St; #declare St15 = 15 * St; #declare St19 = 19 * St; #declare St23 = 23 * St; #declare St27 = 27 * St; #declare St31 = 31 * St;
#declare St4 = 4 * St; #declare St8 = 8 * St; #declare St12 = 12 * St; #declare St16 = 16 * St; #declare St20 = 20 * St; #declare St24 = 24 * St; #declare St28 = 28 * St; #declare St32 = 32 * St;

#declare BasicBox1 = difference {
box
{
    <-1, 0, -1><0, 4, 1> texture
    {
        pigment { color rgb<0.15, 0.25, 0.95> }
    }
    finish { reflection 0.3 }
} //  finish {reflection 0.3}   <<<<!
  //frez========
cylinder
{
    <-1, -1, -1><-1, 5, -1> 0.18 texture
    {
        pigment { color rgb<0.15, 0.25, 0.95> }
    }
    finish { reflection 0.3 }
}
cylinder
{
    <0, -1, -1><0, 5, -1> 0.18 texture
    {
        pigment { color rgb<0.15, 0.25, 0.95> }
    }
    finish { reflection 0.3 }
}
cylinder
{
    <-1, -1, 1><-1, 5, 1> 0.18 texture
    {
        pigment { color rgb<0.15, 0.25, 0.95> }
    }
    finish { reflection 0.3 }
}
cylinder
{
    <0, -1, 1><0, 5, 1> 0.18 texture
    {
        pigment { color rgb<0.15, 0.25, 0.95> }
    }
    finish { reflection 0.3 }
}
}
#declare Rurek1 = difference{cylinder{ < 0, 0, 0 > < 19, 0, 0 > 3 texture{pigment{color Red } } finish{reflection 0.4 } }

cylinder
{
    <0, 0, 0><19, 0, 0> 2.5 open texture
    {
        pigment { color Red }
    }
    finish { reflection 0.5 }
}
}

#declare BasicBox2 = union
{
    difference
    {
        box
        {
            <-1, 0, -1><0, 4, 1> texture
            {
                pigment { color rgb<0.15, 0.25, 0.95> }
            }
            finish { reflection 0.3 }
        }
        difference{
            cylinder{<-1, 0, 0><2, 0, 0> 1 translate<-0.5, 2, 0> scale<0.7, 0.7, 0.7> texture{pigment{color rgb<0.15, 0.25, 0.95>}} finish{reflection 0.3}} box{<-1, -1, -1><1, 1, 1> translate<-1, 3.8, 0> scale<1, 0.5, 1>} translate<0, 0.5, 0>}
        //tak zawany "lol"
        cylinder
        {
            <-1, 0, 0><2, 0, 0> 0.7 translate<-0.5, 8.5, -1.6> scale<1, 0.3, 0.3> texture
            {
                pigment { color rgb<0.15, 0.25, 0.95> }
            }
            finish { reflection 0.3 }
        }
        cylinder
        {
            <-1, 0, 0><2, 0, 0> 0.7 translate<-0.5, 8.5, 1.6> scale<1, 0.3, 0.3> texture
            {
                pigment { color rgb<0.15, 0.25, 0.95> }
            }
            finish { reflection 0.3 }
        }

        //frez========
        cylinder
        {
            <-1, -1, -1><-1, 5, -1> 0.18 texture
            {
                pigment { color rgb<0.15, 0.25, 0.95> }
            }
            finish { reflection 0.3 }
        }
        cylinder
        {
            <0, -1, -1><0, 5, -1> 0.18 texture
            {
                pigment { color rgb<0.15, 0.25, 0.95> }
            }
            finish { reflection 0.3 }
        }
        cylinder
        {
            <-1, -1, 1><-1, 5, 1> 0.18 texture
            {
                pigment { color rgb<0.15, 0.25, 0.95> }
            }
            finish { reflection 0.3 }
        }
        cylinder
        {
            <0, -1, 1><0, 5, 1> 0.18 texture
            {
                pigment { color rgb<0.15, 0.25, 0.95> }
            }
            finish { reflection 0.3 }
        }
    }
    //    union
    //    {
    //    cone{<0,0,0>0.1<0,1,0>0.4 texture{pigment{color White}} translate<0,1.5,-0.2> scale<0.8,0.6,0.8> translate<0,0.4,0>}
    //    cone{<0,0,0>0.1<0,1,0>0.4 texture{pigment{color White}} translate<0,1.5,-0.2> scale<0.8,0.6,0.8> translate<0,0.4,0.6>}
    //    translate <-0.5,0,0>
    //    }
}

/*
Incho - nazwa zmiennej powstała z połšcznia słów inhibitor i echo :P

*/
#macro GiveMeNineMacro(incho)
union ////////////////////////////////
{
    object { BasicBox1 #if (Current > Sx0 + incho) #if ((Current - Sx0 - incho) < 55) #if ((Current - Sx0 - incho) > 15) rotate<0, 0, -2 * (Current - Sx0 - incho) + ((Current - Sx0 - incho - 15) * (1 * ((Current - Sx0 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx0 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St0, 0, 0> }
    object { BasicBox1 #if (Current > Sx1 + incho) #if ((Current - Sx1 - incho) < 55) #if ((Current - Sx1 - incho) > 15) rotate<0, 0, -2 * (Current - Sx1 - incho) + ((Current - Sx1 - incho - 15) * (1 * ((Current - Sx1 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx1 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St1, 0, 0> }
    object { BasicBox1 #if (Current > Sx2 + incho) #if ((Current - Sx2 - incho) < 55) #if ((Current - Sx2 - incho) > 15) rotate<0, 0, -2 * (Current - Sx2 - incho) + ((Current - Sx2 - incho - 15) * (1 * ((Current - Sx2 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx2 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St2, 0, 0> }
    object { BasicBox1 #if (Current > Sx3 + incho) #if ((Current - Sx3 - incho) < 55) #if ((Current - Sx3 - incho) > 15) rotate<0, 0, -2 * (Current - Sx3 - incho) + ((Current - Sx3 - incho - 15) * (1 * ((Current - Sx3 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx3 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St3, 0, 0> }
    object { BasicBox1 #if (Current > Sx4 + incho) #if ((Current - Sx4 - incho) < 55) #if ((Current - Sx4 - incho) > 15) rotate<0, 0, -2 * (Current - Sx4 - incho) + ((Current - Sx4 - incho - 15) * (1 * ((Current - Sx4 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx4 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St4, 0, 0> }
    object { BasicBox1 #if (Current > Sx5 + incho) #if ((Current - Sx5 - incho) < 55) #if ((Current - Sx5 - incho) > 15) rotate<0, 0, -2 * (Current - Sx5 - incho) + ((Current - Sx5 - incho - 15) * (1 * ((Current - Sx5 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx5 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St5, 0, 0> }
    object { BasicBox1 #if (Current > Sx6 + incho) #if ((Current - Sx6 - incho) < 55) #if ((Current - Sx6 - incho) > 15) rotate<0, 0, -2 * (Current - Sx6 - incho) + ((Current - Sx6 - incho - 15) * (1 * ((Current - Sx6 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx6 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St6, 0, 0> }
    object { BasicBox1 #if (Current > Sx7 + incho) #if ((Current - Sx7 - incho) < 55) #if ((Current - Sx7 - incho) > 15) rotate<0, 0, -2 * (Current - Sx7 - incho) + ((Current - Sx7 - incho - 15) * (1 * ((Current - Sx7 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx7 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St7, 0, 0> }
    object { BasicBox1 #if (Current > Sx8 + incho) #if ((Current - Sx8 - incho) < 55) #if ((Current - Sx8 - incho) > 15) rotate<0, 0, -2 * (Current - Sx8 - incho) + ((Current - Sx8 - incho - 15) * (1 * ((Current - Sx8 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx8 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St8, 0, 0> }

}

#end

#macro GiveMeThreeMacro(incho)
union ////////////////////////////////
{
    object { BasicBox1 #if (Current > Sx0 + incho) #if ((Current - Sx0 - incho) < 55) #if ((Current - Sx0 - incho) > 15) rotate<0, 0, -2 * (Current - Sx0 - incho) + ((Current - Sx0 - incho - 15) * (1 * ((Current - Sx0 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx0 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St0, 0, 0> }
    object { BasicBox1 #if (Current > Sx1 + incho) #if ((Current - Sx1 - incho) < 55) #if ((Current - Sx1 - incho) > 15) rotate<0, 0, -2 * (Current - Sx1 - incho) + ((Current - Sx1 - incho - 15) * (1 * ((Current - Sx1 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx1 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St1, 0, 0> }
    object { BasicBox1 #if (Current > Sx2 + incho) #if ((Current - Sx2 - incho) < 55) #if ((Current - Sx2 - incho) > 15) rotate<0, 0, -2 * (Current - Sx2 - incho) + ((Current - Sx2 - incho - 15) * (1 * ((Current - Sx2 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx2 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St2, 0, 0> }

}

#end

#macro GiveMeFourMacro(incho)
union ////////////////////////////////
{
    object { BasicBox1 #if (Current > Sx0 + incho) #if ((Current - Sx0 - incho) < 55) #if ((Current - Sx0 - incho) > 15) rotate<0, 0, -2 * (Current - Sx0 - incho) + ((Current - Sx0 - incho - 15) * (1 * ((Current - Sx0 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx0 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St0, 0, 0> }
    object { BasicBox1 #if (Current > Sx1 + incho) #if ((Current - Sx1 - incho) < 55) #if ((Current - Sx1 - incho) > 15) rotate<0, 0, -2 * (Current - Sx1 - incho) + ((Current - Sx1 - incho - 15) * (1 * ((Current - Sx1 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx1 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St1, 0, 0> }
    object { BasicBox1 #if (Current > Sx2 + incho) #if ((Current - Sx2 - incho) < 55) #if ((Current - Sx2 - incho) > 15) rotate<0, 0, -2 * (Current - Sx2 - incho) + ((Current - Sx2 - incho - 15) * (1 * ((Current - Sx2 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx2 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St2, 0, 0> }
    object { BasicBox1 #if (Current > Sx3 + incho) #if ((Current - Sx3 - incho) < 55) #if ((Current - Sx3 - incho) > 15) rotate<0, 0, -2 * (Current - Sx3 - incho) + ((Current - Sx3 - incho - 15) * (1 * ((Current - Sx3 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx3 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St3, 0, 0> }

}

#end

#macro GiveMeFiveMacro(incho)
union ////////////////////////////////
{
    object { BasicBox1 #if (Current > Sx0 + incho) #if ((Current - Sx0 - incho) < 55) #if ((Current - Sx0 - incho) > 15) rotate<0, 0, -2 * (Current - Sx0 - incho) + ((Current - Sx0 - incho - 15) * (1 * ((Current - Sx0 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx0 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St0, 0, 0> }
    object { BasicBox1 #if (Current > Sx1 + incho) #if ((Current - Sx1 - incho) < 55) #if ((Current - Sx1 - incho) > 15) rotate<0, 0, -2 * (Current - Sx1 - incho) + ((Current - Sx1 - incho - 15) * (1 * ((Current - Sx1 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx1 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St1, 0, 0> }
    object { BasicBox1 #if (Current > Sx2 + incho) #if ((Current - Sx2 - incho) < 55) #if ((Current - Sx2 - incho) > 15) rotate<0, 0, -2 * (Current - Sx2 - incho) + ((Current - Sx2 - incho - 15) * (1 * ((Current - Sx2 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx2 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St2, 0, 0> }
    object { BasicBox1 #if (Current > Sx3 + incho) #if ((Current - Sx3 - incho) < 55) #if ((Current - Sx3 - incho) > 15) rotate<0, 0, -2 * (Current - Sx3 - incho) + ((Current - Sx3 - incho - 15) * (1 * ((Current - Sx3 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx3 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St3, 0, 0> }
    object { BasicBox1 #if (Current > Sx4 + incho) #if ((Current - Sx4 - incho) < 55) #if ((Current - Sx4 - incho) > 15) rotate<0, 0, -2 * (Current - Sx4 - incho) + ((Current - Sx4 - incho - 15) * (1 * ((Current - Sx4 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx4 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St4, 0, 0> }

}

#end

#macro GiveMeOneMacro(incho)
union ////////////////////////////////
{
    object { BasicBox1 #if (Current > Sx0 + incho) #if ((Current - Sx0 - incho) < 55) #if ((Current - Sx0 - incho) > 15) rotate<0, 0, -2 * (Current - Sx0 - incho) + ((Current - Sx0 - incho - 15) * (1 * ((Current - Sx0 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx0 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St0, 0, 0> }
}

#end

#macro GiveMeFourMacroCurve(incho)
union {
    object { BasicBox1 #if (Current > Sx0 + incho) #if ((Current - Sx0 - incho) < 55) #if ((Current - Sx0 - incho) > 15) rotate<0, 0, -2 * (Current - Sx0 - incho) + ((Current - Sx0 - incho - 15) * (1 * ((Current - Sx0 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx0 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St0, 0, 0> rotate<0, -20, 0> }
    object { BasicBox1 #if (Current > Sx1 + incho) #if ((Current - Sx1 - incho) < 55) #if ((Current - Sx1 - incho) > 15) rotate<0, 0, -2 * (Current - Sx1 - incho) + ((Current - Sx1 - incho - 15) * (1 * ((Current - Sx1 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx1 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St1, 0, 0> rotate<0, -40, 0> }
    object { BasicBox1 #if (Current > Sx2 + incho) #if ((Current - Sx2 - incho) < 55) #if ((Current - Sx2 - incho) > 15) rotate<0, 0, -2 * (Current - Sx2 - incho) + ((Current - Sx2 - incho - 15) * (1 * ((Current - Sx2 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx2 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St2, 0, 0> rotate<0, -60, 0> }
    object { BasicBox1 #if (Current > Sx3 + incho) #if ((Current - Sx3 - incho) < 55) #if ((Current - Sx3 - incho) > 15) rotate<0, 0, -2 * (Current - Sx3 - incho) + ((Current - Sx3 - incho - 15) * (1 * ((Current - Sx3 - incho - 15) / 4.41) / 9))> #else rotate<0, 0, -2 * (Current - Sx3 - incho)> #end #else rotate<0, 0, -2 * 35> #end #end translate<St3, 0, 0> rotate<0, -90, 0> }
}

#end

#declare GiveMeEight = union
{
    object { BasicBox1 #if (Current > Sx0) #if ((Current - Sx0) < 35) rotate<0, 0, -2 * (Current - Sx0)> #else rotate<0, 0, -2 * 35> #end #end translate<St0, 0, 0> }
    object { BasicBox1 #if (Current > Sx1) #if ((Current - Sx1) < 35) rotate<0, 0, -2 * (Current - Sx1)> #else rotate<0, 0, -2 * 35> #end #end translate<St1, 0, 0> }
    object { BasicBox1 #if (Current > Sx2) #if ((Current - Sx2) < 35) rotate<0, 0, -2 * (Current - Sx2)> #else rotate<0, 0, -2 * 35> #end #end translate<St2, 0, 0> }
    object { BasicBox1 #if (Current > Sx3) #if ((Current - Sx3) < 35) rotate<0, 0, -2 * (Current - Sx3)> #else rotate<0, 0, -2 * 35> #end #end translate<St3, 0, 0> }
    object { BasicBox1 #if (Current > Sx4) #if ((Current - Sx4) < 35) rotate<0, 0, -2 * (Current - Sx4)> #else rotate<0, 0, -2 * 35> #end #end translate<St4, 0, 0> }
    object { BasicBox1 #if (Current > Sx5) #if ((Current - Sx5) < 35) rotate<0, 0, -2 * (Current - Sx5)> #else rotate<0, 0, -2 * 35> #end #end translate<St5, 0, 0> }
    object { BasicBox1 #if (Current > Sx6) #if ((Current - Sx6) < 35) rotate<0, 0, -2 * (Current - Sx6)> #else rotate<0, 0, -2 * 35> #end #end translate<St6, 0, 0> }
    object { BasicBox1 #if (Current > Sx7) #if ((Current - Sx7) < 35) rotate<0, 0, -2 * (Current - Sx7)> #else rotate<0, 0, -2 * 35> #end #end translate<St7, 0, 0> }
    object { BasicBox1 #if (Current > Sx8) #if ((Current - Sx8) < 35) rotate<0, 0, -2 * (Current - Sx8)> #else rotate<0, 0, -2 * 35> #end #end translate<St8, 0, 0> }
}

#declare Transceiver = difference
{
    box{<-1, -1, -1>, <1, 1, 1> scale<3, 3, 3> rotate<0, 40, 0> translate<3, 2, 3>} box{<-1, -1, -1>, <1, 1, 1> scale<3, 3, 5> rotate<0, 90, 0> translate<3, 3, 0.5>} box { <-1,-1,-1>, <1,1,1> scale<3,3,5>rotate<0,180,0>translate<0.5,3,3> }
}

#declare Hol3 = difference
{
    cylinder
    {
        <0, 0, 0><0, 0.1, 0> 3 texture
        {
            pigment { color Black }
        }
    }
}
#declare Sball = sphere{ < 0, 0, 0 >, 2.5 texture{Aluminum } }

#declare Rurekb =

difference
{
    cylinder
    {
        <0, 0, 0><0, 20, 0> 3 texture
        {
            pigment { color Grey }
        }
    }
    cylinder
    {
        <0, 0, 0><0, 20, 0> 2 scale<0, 1.4, 0> translate<0, -1, 0> texture
        {
            pigment { color Grey }
        }
    }
    box
    {
        <-1, -1, -1><1, 1, 1> scale<3, 22, 5> translate<0, 0, 4.5> texture
        {
            pigment { color Pink }
        }
    }
    scale<0, 2, 0>

        rotate<0, 90, 90>
            rotate<0, -90, 0>
}

#declare lift = difference
{
    cylinder
    {
        <0, 0, 0><0, 20, 0> 3 texture
        {
            pigment { color Blue }
        }
    }
    box
    {
        <-1, -1, -1><1, 1, 1> scale<6, 3, 6> rotate<0, 45, 0> rotate<-45, 45, 0> translate<0, 20, 0> texture
        {
            pigment { color Blue }
        }
    }
}

//                         ====================================================
//================================        ++++++++++++++++++++        ================================
//                        ========================HEAD========================

camera{

    //   location <-60+(Current/16),30,40> look_at <-80+(Current/7),10,80-(Current/40)>
    location<-90 + ((Current - 2000) / 4), 170 - ((Current - 2000) / 12), -95> look_at<0, 0, -40>

    //  location <0,30,0> look_at <0,0,0>

}

light_source{
    <-8, 42, 8>
        color White
    //  looks_like{Rurek1}
}

light_source{
    <40, 14, -40>
        color White}

plane
{
    y, 0 texture
    {
        pigment { color rgb<0.75, 0.85, 0.95> }
    }
}
plane
{
    x, -100 texture
    {
        pigment { color rgb<0.95, 0.85, 0.95> }
    }
}
plane
{
    z, 100 texture
    {
        pigment { color rgb<0.95, 0.85, 0.95> }
    }
}

//                        ========================HEAD========================
//================================        ++++++++++++++++++++        ================================
//                        ====================================================

/* 
union
{

union
{  
object {BasicBox1 rotate<1,0,-70> translate<-27,0,0>}  
object {BasicBox1 rotate<-3,0,-70>  translate<-24,0,0>} 
object {BasicBox1 rotate<5,0,-70> translate<-21,0,0>}  
object {BasicBox1 rotate<-3,0-70> translate<-18,0,0>}  
object {BasicBox1 rotate<4,0,-70>  translate<-15,0,0>}   
//5 pts
object {BasicBox1 rotate<0,0,290> translate<-12,0,0>}  
object {BasicBox1 rotate<0,0,293>  translate<-9,0,0>} 
object {BasicBox1 rotate<0,0,298>  translate<-6,0,0>} 
object {BasicBox1 rotate<0,0,313> translate<-3,0,0>}  
object {BasicBox1 rotate<0,0,340>  translate<0,0,0>}    
//5 pts
union
{
object {BasicBox1 rotate<0,0,-frame_number>  translate<3,0,0>}   
object {BasicBox1 #if (frame_number>40) rotate<0,0,-frame_number+40>#end  translate<6,0.8,0>}
object {BasicBox1 rotate<0,0,0>  translate<9,0.8,0>}  
translate<0,0,0>
}  
union
{
object {BasicBox1 rotate<0,0,0>  translate<3,0.8,0>}   
object {BasicBox1 rotate<0,0,0>  translate<6,0.8,0>}
object {BasicBox1 rotate<0,0,0>  translate<9,0.8,0>}  
translate<9,0,0>
}  
union
{
object {BasicBox1 rotate<0,0,0>  translate<3,0.8,0>}   
object {BasicBox1 rotate<0,0,0>  translate<6,0.8,0>}
  
translate<18,0,0>
} 

union
{
object {BasicBox1 rotate<0,0,-70>  translate<3,0,0>}  //natura ruchu shot   
object {BasicBox1 rotate<0,0,-69>  translate<6,0,0>}
object {BasicBox1 rotate<0,0,-64>  translate<9,0,0>}   
object {BasicBox1 rotate<0,0,-53>  translate<12,0,0>}
object {BasicBox1 rotate<0,0,-30>  translate<15,0,0>} 
object {BasicBox1 rotate<0,0,0>  translate<18,0,0>}
translate<24,0,0>
}  

}}  
 
//object {BasicBox1 translate<0,0,-12>}  //testowy lol

 //text{ttf "Arial.ttf", "mansfeld.pl",  0.2,0 texture{pigment{color rgb<0.4,0.4,0.4>}} finish{reflection 0.5} scale<3,3,3> translate<6,6,-1> rotate<0,0,0>}


 */

object{GiveMeNineMacro(0) rotate<0, 0, 0> translate<-80, 0, 80>} object{GiveMeNineMacro(135) rotate<0, 0, 0> translate<-53, 0, 80>} object{GiveMeNineMacro(270) rotate<0, 0, 0> translate<-26, 0, 80>} object{GiveMeNineMacro(405) rotate<0, 0, 0> translate<1, 0, 80>} object{GiveMeNineMacro(540) rotate<0, 30, 0> translate<27.5, 0, 79.5>} //ukos
object{GiveMeNineMacro(675) rotate<0, 30, 0> translate<51, 0, 66>}

object{GiveMeNineMacro(270) rotate<0, 36.6, 0> translate<-27, 0, 77.8>} //rozgalezienie
object{GiveMeNineMacro(405) rotate<0, 36.6, 0> translate<-5, 0, 61.5>}  // rozgalezienie
object{GiveMeNineMacro(540) rotate<0, 36.6, 0> translate<16.5, 0, 45.5>} object{GiveMeNineMacro(675) rotate<0, 36.6, 0> translate<38.5, 0, 29.2>} object{GiveMeFourMacro(810) rotate<0, 36.6, 0> translate<60, 0, 13>}

object{GiveMeNineMacro(810) rotate<0, 10, 0> translate<75, 0, 54>} //   //outside

object{GiveMeNineMacro(840) rotate<0, 40, 0> translate<77.5, 0, 48.5>} //  middle

object{GiveMeNineMacro(810) rotate<0, 60, 0> translate<74, 0, 52>} // inside  \


object{GiveMeNineMacro(945) rotate<0, 40, 0> translate<101.5, 0, 48.5>} //outside

object{GiveMeNineMacro(975) rotate<0, 84.5, 0> translate<97.5, 0, 30.5>} //  middle

object{GiveMeNineMacro(945) rotate<0, 120, 0> translate<86.5, 0, 28.5>} // transceiver

object{GiveMeNineMacro(1080) rotate<0, 80, 0> translate<121.5, 0, 31>} //outside
object{GiveMeThreeMacro(1110) rotate<0, 130, 0> translate<99, 0, 4>}   //  middle

object{GiveMeNineMacro(1215) rotate<0, 130, 0> translate<124.5, 0, 5>} //outside
object{GiveMeThreeMacro(1155) rotate<0, 170, 0> translate<92, 0, -2>}  //  middle

object{GiveMeThreeMacro(1345) rotate<0, 160, 0> translate<106, 0, -15>} //outside
object{GiveMeFourMacro(1200) rotate<0, 205, 0> translate<83, 0, -2>}    //  transceiver  middle

object{GiveMeThreeMacro(1390) rotate<0, 180, 0> translate<97, 0, -17.5>} //outside

object{GiveMeFiveMacro(1435) rotate<0, 200, 0> translate<88, 0, -16.5>} //outside

object{GiveMeThreeMacro(1510) rotate<0, 220, 0> translate<74.5, 0, -10.5>} //outside

object{GiveMeOneMacro(1555) rotate<0, 230, 0> translate<67, 0, -5>} //outside

object{GiveMeOneMacro(1570) rotate<0, 270, 0> translate<65.5, 0, -2.5>} //outside

object{GiveMeOneMacro(1585) rotate<0, 300, 0> translate<67, 0, 0.5>} //outside

// trasceiver osišgniety przez outside

//transceiver
object
{
    Transceiver #if (Current > 1080) texture
    {
        pigment { color Green }
    }
#else texture
    {
        pigment { color Red }
    }
#end translate < 68, 0, 1 >
}
object
{
    Transceiver #if (Current > 1275) texture
    {
        pigment { color Green }
    }
#else texture
    {
        pigment { color Red }
    }
#end rotate < 0, 90, 0 > translate < 68, 0, 7.5 >
}
object
{
    Transceiver #if (Current > 1605) texture
    {
        pigment { color Green }
    }
#else texture
    {
        pigment { color Red }
    }
#end rotate < 0, 180, 0 > translate < 74.5, 0, 7.5 >
}
object
{
    Transceiver #if (Current > 870) texture
    {
        pigment { color Green }
    }
#else texture
    {
        pigment { color Red }
    }
#end rotate < 0, 270, 0 > translate < 74.5, 0, 1 >
}

object{Hol3 translate<0, 0, 20>}

object
{
    Sball translate<0, 2.5, 20>
#if (Current > 2330) translate <-44.7, 0, -14> #else #if (Current > 1620) #if (Current > 2090) translate <-(Current - 1620) / 16, 0, -29.5 + (Current - 2090) / 16> #else translate <-(Current - 1620) / 16, 0, -(Current - 1620) / 16> #end #end #end
}

object{GiveMeNineMacro(2090) rotate<0, 90, 0> translate<-29.1, 0, -13>} object{GiveMeNineMacro(2225) rotate<0, 90, 0> translate<-29.1, 0, -40>}

object{GiveMeOneMacro(2360) rotate<0, 70, 0> translate<-28, 0, -67>} object{GiveMeOneMacro(2375) rotate<0, 50, 0> translate<-26, 0, -69.3>} object{GiveMeOneMacro(2390) rotate<0, 30, 0> translate<-24, 0, -71>} object{GiveMeOneMacro(2410) rotate<0, 30, 0> translate<-22, 0, -73>} object{GiveMeOneMacro(2425) rotate<0, 10, 0> translate<-19.5, 0, -74>}

object{GiveMeNineMacro(2440) rotate<0, 0, 0> translate<-16.5, 0, -74>} object{GiveMeNineMacro(2575) rotate<0, 0, 0> translate<10.5, 0, -74>}

object{GiveMeNineMacro(2710) rotate<0, 0, 0> translate<37.5, 0, -74>}

object{GiveMeNineMacro(2710) rotate<0, -20, 0> translate<36.5, 0, -72>} object
{
    GiveMeNineMacro(2710) rotate<0, 20, 0> translate<36.5, 0, -76>
}

union {
    object{GiveMeNineMacro(2845) rotate<0, 0, 0> translate<37.5, 0, -74>} object{GiveMeNineMacro(2980) rotate<0, 0, 0> translate<64.5, 0, -74>} object{GiveMeNineMacro(3115) rotate<0, 0, 0> translate<91.5, 0, -74>} object{GiveMeNineMacro(3250) rotate<0, 0, 0> translate<118.5, 0, -74>} object{GiveMeNineMacro(3385) rotate<0, 0, 0> translate<145.5, 0, -74>} object{GiveMeNineMacro(3520) rotate<0, 0, 0> translate<172.5, 0, -74>}

    object{GiveMeNineMacro(2845) rotate<0, -20, 0> translate<36.5, 0, -72>} translate<25, 0, 10.7>
}

union {
    object{GiveMeNineMacro(2845) rotate<0, 0, 0> translate<37.5, 0, -74>} object{GiveMeNineMacro(2980) rotate<0, 0, 0> translate<64.5, 0, -74>} object{GiveMeNineMacro(3115) rotate<0, 0, 0> translate<91.5, 0, -74>} object{GiveMeNineMacro(3250) rotate<0, 0, 0> translate<118.5, 0, -74>} object{GiveMeNineMacro(3385) rotate<0, 0, 0> translate<145.5, 0, -74>} object{GiveMeNineMacro(3520) rotate<0, 0, 0> translate<172.5, 0, -74>} object{GiveMeNineMacro(2845) rotate<0, 20, 0> translate<36.5, 0, -76>} translate<25, 0, -10.7>
}

object
{
    GiveMeNineMacro(2845) rotate<0, 0, 0> translate<64.5, 0, -74>
}

union {
    object{GiveMeNineMacro(2980) rotate<0, 0, 0> translate<37.5, 0, -74>} object{GiveMeNineMacro(3115) rotate<0, 0, 0> translate<64.5, 0, -74>} object{GiveMeNineMacro(3250) rotate<0, 0, 0> translate<91.5, 0, -74>} object{GiveMeNineMacro(3385) rotate<0, 0, 0> translate<118.5, 0, -74>} object{GiveMeNineMacro(3520) rotate<0, 0, 0> translate<145.5, 0, -74>} object{GiveMeNineMacro(2980) rotate<0, -20, 0> translate<36.5, 0, -72>} translate<25, 0, 10.7> translate<25, 0, 10.7>
}

union {
    object{GiveMeNineMacro(2980) rotate<0, 0, 0> translate<37.5, 0, -74>} object{GiveMeNineMacro(3115) rotate<0, 0, 0> translate<64.5, 0, -74>} //git
    object{GiveMeNineMacro(3250) rotate<0, 0, 0> translate<91.5, 0, -74>} object{GiveMeNineMacro(3385) rotate<0, 0, 0> translate<118.5, 0, -74>} object{GiveMeNineMacro(3520) rotate<0, 0, 0> translate<145.5, 0, -74>}

    object{GiveMeNineMacro(2980) rotate<0, 20, 0> translate<36.5, 0, -76>} translate<25, 0, -10.7>
        translate<25, 0, -10.7>
}

object
{
    GiveMeNineMacro(2980) rotate<0, 0, 0> translate<91.5, 0, -74>
}

union {
    object{GiveMeNineMacro(3115) rotate<0, 0, 0> translate<37.5, 0, -74>} object{GiveMeNineMacro(3250) rotate<0, 0, 0> translate<64.5, 0, -74>} object{GiveMeNineMacro(3385) rotate<0, 0, 0> translate<91.5, 0, -74>} object{GiveMeNineMacro(3520) rotate<0, 0, 0> translate<118.5, 0, -74>} object{GiveMeNineMacro(3115) rotate<0, -20, 0> translate<36.5, 0, -72>} translate<25, 0, 10.7> translate<25, 0, 10.7> translate<25, 0, 10.7>
}

union {
    object{GiveMeNineMacro(3115) rotate<0, 0, 0> translate<37.5, 0, -74>} object{GiveMeNineMacro(3250) rotate<0, 0, 0> translate<64.5, 0, -74>} object{GiveMeNineMacro(3385) rotate<0, 0, 0> translate<91.5, 0, -74>} object{GiveMeNineMacro(3520) rotate<0, 0, 0> translate<118.5, 0, -74>}

    object{GiveMeNineMacro(3115) rotate<0, 20, 0> translate<36.5, 0, -76>} translate<25, 0, -10.7>
        translate<25, 0, -10.7> translate<25, 0, -10.7>
}

object
{
    GiveMeNineMacro(3115) rotate<0, 0, 0> translate<118.5, 0, -74>
}

union {
    object{GiveMeNineMacro(3250) rotate<0, 0, 0> translate<37.5, 0, -74>} object{GiveMeNineMacro(3385) rotate<0, 0, 0> translate<64.5, 0, -74>} object{GiveMeNineMacro(3520) rotate<0, 0, 0> translate<91.5, 0, -74>}

    translate<25, 0, 10.7>
        translate<25, 0, 10.7> translate<25, 0, 10.7> translate<25, 0, 10.7>
}

union {
    object{GiveMeNineMacro(3250) rotate<0, 0, 0> translate<37.5, 0, -74>} object{GiveMeNineMacro(3385) rotate<0, 0, 0> translate<64.5, 0, -74>} object{GiveMeNineMacro(3520) rotate<0, 0, 0> translate<91.5, 0, -74>}

    translate<25, 0, -10.7>
        translate<25, 0, -10.7> translate<25, 0, -10.7> translate<25, 0, -10.7>
}

object{GiveMeNineMacro(3250) rotate<0, 0, 0> translate<145.5, 0, -74>}

object{GiveMeNineMacro(3385) rotate<0, 0, 0> translate<172.5, 0, -74>}

object
{
    GiveMeNineMacro(3520) rotate<0, 0, 0> translate<199.5, 0, -74>
}

//object {lift translate <0,8,20>
//translate <0,-20,0>
// #if (Current>1620)  translate<0,((Current-1620)/2),0> #end
//}

//object {Rurekb          rotate<15,0,0>    //w x
//rotate<0,225,0>      translate <-28,4,-8>     }

//object {GiveMeEightMacro(135) translate<27,0,0>}
//object {GiveMeEightMacro(270) translate<54,0,0>}
//object {GiveMeFourMacroCurve(405) translate<81,0,0>}
//object {GiveMeFourMacroCurve(470) rotate <0,90,0> translate<88,0,-8>}
//object {GiveMeEightMacro(540)  rotate<0,180,0> translate<81,0,-16>}
//object {GiveMeEightMacro(675)  rotate<0,180,0> translate<54,0,-16>}
//object {GiveMeEightMacro(810)  rotate<0,180,0> translate<27,0,-16>}

//object {GiveMeSix translate<0,0,0>}
//wyjscie z rury

/*
union
{    

object {BasicBox1 rotate<0,0,0>  translate<30,0,0>}

object {BasicBox1 rotate<0,0,0>  scale<1.5,1.5,1.5> translate<34,0,0> }    

object {BasicBox1 rotate<0,0,0>  scale<2,2,2> translate<38,0,0> }  

object {BasicBox1 rotate<0,0,0>  scale<3,3,3> translate<44,0,0> }  

object {BasicBox1 rotate<0,0,0>  scale<5,5,5> translate<56,0,0> }   

object {BasicBox1 rotate<0,0,0>  scale<8,8,8> translate<76,0,0> }
 
rotate<0,25,0>translate<50,0,-4>  

texture{pigment{color rgb<0.15,0.25,0.95>}} 
finish {reflection 0.2}
}     
  

*/

//zastosowaa gdzieo hexagon color i tesktury!

/* 
   
  Notes: 

    union{   
disc{<0,1,0> <0,0.5,0> 2 1}   
union{   
triangle{<-1,1,-1.3><-1,1,1.3><-3,1,0>}   
triangle{<-1,1,-1.3><-1,1,1.3><-3,1,0> rotate<0,90,0>}  
triangle{<-1,1,-1.3><-1,1,1.3><-3,1,0> rotate<0,180,0>}  
triangle{<-1,1,-1.3><-1,1,1.3><-3,1,0>  rotate<0,270,0>}  
   rotate <0,0,0>   
   
   }  
   
   union{   
triangle{<-1,1,-1.3><-1,1,1.3><-3,1,0>}   
triangle{<-1,1,-1.3><-1,1,1.3><-3,1,0> rotate<0,90,0>}  
triangle{<-1,1,-1.3><-1,1,1.3><-3,1,0> rotate<0,180,0>}  
triangle{<-1,1,-1.3><-1,1,1.3><-3,1,0>  rotate<0,270,0>}  
   rotate <0,45,0>   
   
   } 
    texture{pigment{color Red}} 
    
    rotate<15,0,0>
      }


polygon{8 <-4,1,-2><4,1,-2><4,1,-3><6,1,0><4,1,3><4,1,2><-4,1,2><-1,1,0> texture{pigment{color Red}}}





   
  
  
 // ring================= 
  
  union{

torus {5,0.5  texture{Gold_Texture} rotate<0,0,0> scale<1,1.5,1> } 
 
superellipsoid{<0.1,1>texture{White_Marble} rotate<0,0,0> scale<2,1,1> finish{reflection 0.3} translate<0,0,-5>}
superellipsoid{<0.1,1>texture{pigment{color Gray}} rotate<0,0,0> scale<0.5,1,1> finish{reflection 0.3} translate<0,0,-5.5>}  
 
sphere {<0,0,0> 0.2 texture{pigment{color Black}} finish{reflection 0.5} translate<1,0,-5.9>} 
sphere {<0,0,0> 0.2 texture{pigment{color Black}} finish{reflection 0.5} translate<-1,0,-5.9>}   
sphere {<0,0,0> 0.2 texture{pigment{color Black}} finish{reflection 0.5} translate<0,0.9,-5.9>} 
sphere {<0,0,0> 0.2 texture{pigment{color Black}} finish{reflection 0.5} translate<0,-0.9,-5.9>}
 
 rotate<5,0,0>
 }
 
   :)
   
//  lathe
 // {quadratic_spline 
 // 8 <6,0><6,0.1><8,0.5><3,2><3,3><3,3.5><6,6><0,18>
//   texture {pigment{color Black} finish{reflection 0.05}} 
 //  translate<0,0,-12>
 //  }   
 
 
*/