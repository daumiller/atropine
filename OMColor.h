//==================================================================================================================================
// OMColor.h
/*==================================================================================================================================
Copyright © 2013, Dillon Aumiller <dillonaumiller@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met: 

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
==================================================================================================================================*/
typedef struct
{
  float r;
  float g;
  float b;
  float a;
} OMColor;
//==================================================================================================================================
OMColor OMMakeColorRGB (float r, float g, float b);
OMColor OMMakeColorRGBA(float r, float g, float b, float a);
//----------------------------------------------------------------------------------------------------------------------------------
OMColor OMMakeColorCMY (float c, float m, float y);
OMColor OMMakeColorCMYA(float c, float m, float y, float a);
//----------------------------------------------------------------------------------------------------------------------------------
OMColor OMMakeColorHSL (float h, float s, float l);
OMColor OMMakeColorHSLA(float h, float s, float l, float a);
//----------------------------------------------------------------------------------------------------------------------------------
OMColor OMMakeColorHSV (float h, float s, float v);
OMColor OMMakeColorHSVA(float h, float s, float v, float a);
//----------------------------------------------------------------------------------------------------------------------------------
void OMColorToCMY(OMColor *color);
void OMColorToHSL(OMColor *color);
void OMColorToHSV(OMColor *color);
//----------------------------------------------------------------------------------------------------------------------------------
unsigned int OMColorToIntRGBA(OMColor color);
unsigned int OMColorToIntARGB(OMColor color);
unsigned int OMColorToIntABGR(OMColor color);
//==================================================================================================================================
