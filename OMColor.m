//==================================================================================================================================
// OMColor.m
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
//HSL & HSV code based on: http://mjijackson.com/2008/02/rgb-to-hsl-and-rgb-to-hsv-color-model-conversion-algorithms-in-javascript
//==================================================================================================================================
#include <math.h>
#import "OMColor.h"
//==================================================================================================================================
static float hueHelper(float p, float q, float t);
//==================================================================================================================================
OMColor OMMakeColorRGB(float r, float g, float b) { return OMMakeColorRGBA(r, g, b, 1.0f); }
OMColor OMMakeColorRGBA(float r, float g, float b, float a)
{
  OMColor color;
  color.r = r;
  color.g = g;
  color.b = b;
  color.a = a;
  return color;
}
//==================================================================================================================================
OMColor OMMakeColorCMY(float c, float m, float y) { return OMMakeColorCMYA(c, m, y, 1.0f); }
OMColor OMMakeColorCMYA(float c, float m, float y, float a)
{
  OMColor color;
  color.r = 1.0f - c;
  color.g = 1.0f - m;
  color.b = 1.0f - y;
  color.a = a;
  return color;
}
//==================================================================================================================================
OMColor OMMakeColorHSL(float h, float s, float l) { return OMMakeColorHSLA(h, s, l, 1.0f); }
OMColor OMMakeColorHSLA(float h, float s, float l, float a)
{
  OMColor color;
  color.a = a;
  if(s < 0.000001)
    color.r = color.g = color.b = l;
  else
  {
    float q = (l < 0.5f) ? (l * (1.0f + s)) : (l + s - l*s);
    float p = 2.0f*l - q;
    color.r = hueHelper(p, q, h + 0.3333333333333333333333333333333f);
    color.g = hueHelper(p, q, h);
    color.b = hueHelper(p, q, h - 0.3333333333333333333333333333333f);
  }
  return color;
}
//==================================================================================================================================
OMColor OMMakeColorHSV(float h, float s, float v) { return OMMakeColorHSVA(h, s, v, 1.0f); }
OMColor OMMakeColorHSVA(float h, float s, float v, float a)
{
  OMColor color;
  color.a = a;
  
  int i = floor(h * 6.0f);
  float f = h*6.0f - i;
  float p = v * (1.0f - s);
  float q = v * (1.0f - f*s);
  float t = v * (1.0f - (1.0f - f)*s);
  switch(i % 6)
  {
    case 0:  color.r=v;  color.g=t;  color.b=p;  break;
    case 1:  color.r=q;  color.g=v;  color.b=p;  break;
    case 2:  color.r=p;  color.g=v;  color.b=t;  break;
    case 3:  color.r=p;  color.g=q;  color.b=v;  break;
    case 4:  color.r=t;  color.g=p;  color.b=v;  break;
    case 5:  color.r=v;  color.g=p;  color.b=q;  break;
  }
  return color;
}
//==================================================================================================================================
void OMColorToCMY(OMColor *color)
{
  float c = 1.0f - color->r;
  float m = 1.0f - color->g;
  float y = 1.0f - color->b;
  
  color->r = c;
  color->g = m;
  color->b = y;
}
//----------------------------------------------------------------------------------------------------------------------------------
void OMColorToHSL(OMColor *color)
{
  float r=color->r, g=color->g, b=color->b;
  float max = (r > g) ? r : g; max = (max > b) ? max : b;
  float min = (r < g) ? r : g; min = (min < b) ? min : b;
  float h, s, l = (max + min)/2.0f;
  if(fabs(max - min) < 0.000001f)
    h = s = 0.0f;
  else
  {
    float d = max - min;
    s = (l > 0.5f) ? (d / (2.0f - max - min)) : (d / (max + min));
    float rdiff=fabs(max-r), gdiff=fabs(max-g), bdiff=(max-b);
    if((rdiff < gdiff) && (rdiff < bdiff)) h = (g - b) / (d + ((g < b) ? 6.0f : 0.0f));
    if((gdiff < rdiff) && (gdiff < bdiff)) h = (b - r) / (d + 2.0f);
    if((bdiff < rdiff) && (bdiff < gdiff)) h = (r - g) / (d + 4.0f);
    h /= 6.0f;
  }
  
  color->r = h;
  color->g = s;
  color->b = l;
}
//----------------------------------------------------------------------------------------------------------------------------------
void OMColorToHSV(OMColor *color)
{
  float r=color->r, g=color->g, b=color->b;
  float max = (r > g) ? r : g; max = (max > b) ? max : b;
  float min = (r < g) ? r : g; min = (min < b) ? min : b;
  float h, s, v = max;
  float d = max - min;
  s = (max == 0.0f) ? 0.0f : (d / max);
  if(fabs(max - min) < 0.000001f)
    h = 0.0f;
  else
  {
    float rdiff=fabs(max-r), gdiff=fabs(max-g), bdiff=(max-b);
    if((rdiff < gdiff) && (rdiff < bdiff)) h = (g - b) / (d + ((g < b) ? 6.0f : 0.0f));
    if((gdiff < rdiff) && (gdiff < bdiff)) h = (b - r) / (d + 2.0f);
    if((bdiff < rdiff) && (bdiff < gdiff)) h = (r - g) / (d + 4.0f);
    h /= 6.0f;
  }

  color->r = h;
  color->g = s;
  color->b = v;
}
//==================================================================================================================================
unsigned int OMColorToIntRGBA(OMColor color)
{
  unsigned int rgba = (unsigned int)(color.a * 255.0f);
  rgba |= ((unsigned int)(color.b * 255.0f))<< 8;
  rgba |= ((unsigned int)(color.g * 255.0f))<<16;
  rgba |= ((unsigned int)(color.r * 255.0f))<<24;
  return rgba;
}
//----------------------------------------------------------------------------------------------------------------------------------
unsigned int OMColorToIntARGB(OMColor color)
{
  unsigned int argb = (unsigned int)(color.b * 255.0f);
  argb |= ((unsigned int)(color.g * 255.0f))<< 8;
  argb |= ((unsigned int)(color.r * 255.0f))<<16;
  argb |= ((unsigned int)(color.a * 255.0f))<<24;
  return argb;
}
//----------------------------------------------------------------------------------------------------------------------------------
unsigned int OMColorToIntABGR(OMColor color)
{
  unsigned int agbr = (unsigned int)(color.r * 255.0f);
  agbr |= ((unsigned int)(color.g * 255.0f))<< 8;
  agbr |= ((unsigned int)(color.b * 255.0f))<<16;
  agbr |= ((unsigned int)(color.a * 255.0f))<<24;
  return agbr;
}
//==================================================================================================================================
static float hueHelper(float p, float q, float t)
{
  if(t < 0.0f) t += 1.0f;
  if(t > 1.0f) t -= 1.0f;
  if(t < 0.1666666666666666666666666666666f) return (p + (q - p) * 6.0f * t);
  if(t < 0.5f                              ) return q;
  if(t < 0.6666666666666666666666666666666f) return (p + (q - p) * (2.0f/3.0f - t) * 6.0f);
  return p;
}
//==================================================================================================================================
