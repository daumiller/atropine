//==================================================================================================================================
// OMSurface.h
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
#import <ObjFW/ObjFW.h>
#import "OMCoordinate.h"
#import "OMRectangle.h"
#import "OMColor.h"
//==================================================================================================================================
typedef enum
{
  OMSURFACE_OPERATOR_CLEAR,
  OMSURFACE_OPERATOR_SOURCE,
  OMSURFACE_OPERATOR_OVER,
  OMSURFACE_OPERATOR_IN,
  OMSURFACE_OPERATOR_OUT,
  OMSURFACE_OPERATOR_ATOP,
  OMSURFACE_OPERATOR_DEST,
  OMSURFACE_OPERATOR_DEST_OVER,
  OMSURFACE_OPERATOR_DEST_IN,
  OMSURFACE_OPERATOR_DEST_OUT,
  OMSURFACE_OPERATOR_DEST_ATOP,
  OMSURFACE_OPERATOR_XOR,
  OMSURFACE_OPERATOR_ADD,
  OMSURFACE_OPERATOR_SATURATE,
  OMSURFACE_OPERATOR_MULTIPLY,
  OMSURFACE_OPERATOR_SCREEN,
  OMSURFACE_OPERATOR_OVERLAY,
  OMSURFACE_OPERATOR_DARKEN,
  OMSURFACE_OPERATOR_LIGHTEN,
  OMSURFACE_OPERATOR_COLOR_DODGE,
  OMSURFACE_OPERATOR_COLOR_BURN,
  OMSURFACE_OPERATOR_HARD_LIGHT,
  OMSURFACE_OPERATOR_SOFT_LIGHT,
  OMSURFACE_OPERATOR_DIFFERENCE,
  OMSURFACE_OPERATOR_EXCLUSION,
  OMSURFACE_OPERATOR_HSL_HUE,
  OMSURFACE_OPERATOR_HSL_SATURATION,
  OMSURFACE_OPERATOR_HSL_COLOR,
  OMSURFACE_OPERATOR_HSL_LUMINOSITY
} OMSurfaceOperator;
//----------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
  OMSURFACE_LINECAP_BUTT,
  OMSURFACE_LINECAP_ROUND,
  OMSURFACE_LINECAP_SQUARE
} OMSurfaceLineCap;
//----------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
  OMSURFACE_LINEJOINT_MITER,
  OMSURFACE_LINEJOINT_ROUND,
  OMSURFACE_LINEJOINT_BEVEL
} OMSurfaceLineJoint;
//----------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
  OMSURFACE_ANTIALIAS_DEFAULT,
  OMSURFACE_ANTIALIAS_NONE,
  OMSURFACE_ANTIALIAS_GRAY,
  OMSURFACE_ANTIALIAS_SUBPIXEL
} OMSurfaceAntiAlias;
//==================================================================================================================================
@interface OMSurface : OFObject
//----------------------------------------------------------------------------------------------------------------------------------
{
  @protected
    void *_surfaceData;
    int   _width;
    int   _height;
}
//----------------------------------------------------------------------------------------------------------------------------------
@property (readonly) void              *surfaceData;
@property (readonly) int                width;
@property (readonly) int                height;
@property (assign)   float              lineWidth;
@property (assign)   OMCoordinate       position;
@property (assign)   OMSurfaceOperator  operator;
@property (assign)   OMSurfaceLineCap   lineCap;
@property (assign)   OMSurfaceLineJoint lineJoint;
@property (assign)   OMSurfaceAntiAlias antiAlias;
//----------------------------------------------------------------------------------------------------------------------------------
//NOTE: when creating an OMSurface with an existing Cairo context, the context is NOT cleaned/freed by the OMSurface
+ surfaceWithCairoContext:(void *)cairoContext width:(float)width height:(float)height;
- initWithCairoContext:(void *)cairoContext width:(float)width height:(float)height;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)contextReset;
- (void)contextPush;
- (void)contextPop;
- (void)clip;
- (void)clipReset;
- (void)newPath;
- (void)newSubPath;
- (void)closePath;
//- (void)mask:...
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setColor:(OMColor)Color;
- (void)setColorR:(float)R G:(float)G B:(float)B;
- (void)setColorR:(float)R G:(float)G B:(float)B A:(float)A;
- (void)setDashingOn:(float)On Off:(float)Off;
- (void)setDashingOn:(float)On Off:(float)Off Offset:(float)Offset;
- (void)setSourceSurface:(OMSurface *)Source;
- (void)setSourceSurface:(OMSurface *)Source atCoordinate:(OMCoordinate)Coordinate;
- (void)setSourceSurface:(OMSurface *)Source atX:(float)X Y:(float)Y;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)paint;
- (void)paintWithAlpha:(float)Alpha;
- (void)stroke;
- (void)strokePreserve;
- (void)fill;
- (void)fillPreserve;
- (void)clearToColor:(OMColor)color;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)moveTo:(OMCoordinate)Coordinate;
- (void)moveToX:(float)X Y:(float)Y;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)lineTo:(OMCoordinate)Coordinate;
- (void)lineToX:(float)X Y:(float)Y;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)curveControlA:(OMCoordinate)ControlA ControlB:(OMCoordinate)ControlB EndAt:(OMCoordinate)EndAt;
- (void)curveControlAX:(float)ControlAX ControlAY:(float)ControlAY ControlBX:(float)ControlBX ControlBY:(float)ControlBY EndAtX:(float)EndAtX EndAtY:(float)EndAtY;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)rectangle:(OMRectangle)Rectangle;
- (void)rectangleLeft:(float)Left Top:(float)Top Right:(float)Right Bottom:(float)Bottom;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- (void)dimension:(OMDimension)Dimension;
- (void)dimensionX:(float)X Y:(float)Y Width:(float)Width Height:(float)Height;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)arcCenter:(OMCoordinate)Center Radius:(float)Radius DegreeStart:(float)DegreeStart DegreeEnd:(float)DegreeEnd;
- (void)arcCenterX:(float)CenterX CenterY:(float)CenterY Radius:(float)Radius DegreeStart:(float)DegreeStart DegreeEnd:(float)DegreeEnd;
- (void)arcCenter:(OMCoordinate)Center Radius:(float)Radius RadianStart:(float)RadianStart RadianEnd:(float)RadianEnd;
- (void)arcCenterX:(float)CenterX CenterY:(float)CenterY Radius:(float)Radius RadianStart:(float)RadianStart RadianEnd:(float)RadianEnd;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)roundedDimension:(OMDimension)Dimension withRadius:(float)Radius;

@end
//==================================================================================================================================
