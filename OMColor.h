//==================================================================================================================================
// OMColor.h
//==================================================================================================================================
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
