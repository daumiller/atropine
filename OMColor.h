//==================================================================================================================================
// OMColor.h
/*==================================================================================================================================
Copyright © 2012 Dillon Aumiller <dillonaumiller@gmail.com>

This file is part of the atropine library.

atropine is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.

atropine is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with atropine.  If not, see <http://www.gnu.org/licenses/>.
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
