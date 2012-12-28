//==================================================================================================================================
// OMSurface.m
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
#import "OMSurface.h"
#include <cairo/cairo.h>
//----------------------------------------------------------------------------------------------------------------------------------
#define CONTEXT (cairo_t *)_surfaceData
#define DEGREE  0.017453292519
//==================================================================================================================================
@implementation OMSurface
//==================================================================================================================================
+ surfaceWithCairoContext:(void *)cairoContext width:(float)width height:(float)height
{
  return [[[self alloc] initWithCairoContext:cairoContext width:width height:height] autorelease];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- initWithCairoContext:(void *)cairoContext width:(float)width height:(float)height
{
  self = [super init];
  if(self)
  {
    _surfaceData = cairoContext;
    _width       = width;
    _height      = height;
  }
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
@synthesize width       = _width;
@synthesize height      = _height;
@synthesize surfaceData = _surfaceData;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setLineWidth:(float)inLineWidth {               cairo_set_line_width(CONTEXT, (double)inLineWidth); }
- (float)lineWidth                      { return (float)cairo_get_line_width(CONTEXT);                      }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setPosition:(OMCoordinate)inPosition { cairo_move_to(CONTEXT, (double)inPosition.x, (double)inPosition.y);            }
- (OMCoordinate)position { double x,y; cairo_get_current_point(CONTEXT,&x,&y); return OMMakeCoordinate((float)x, (float)y); }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setOperator:(OMSurfaceOperator)inOperator {                           cairo_set_operator(CONTEXT, (cairo_operator_t)inOperator); }
- (OMSurfaceOperator)operator                     { return (OMSurfaceOperator)cairo_get_operator(CONTEXT);                               }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setLineCap:(OMSurfaceLineCap)inLineCap {                          cairo_set_line_cap(CONTEXT, (cairo_line_cap_t)inLineCap);  }
- (OMSurfaceLineCap)lineCap                    { return (OMSurfaceLineCap)cairo_get_line_cap(CONTEXT);                               }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setLineJoint:(OMSurfaceLineJoint)inLineJoint {                            cairo_set_line_join(CONTEXT, (cairo_line_join_t)inLineJoint);  }
- (OMSurfaceLineJoint)lineJoint                      { return (OMSurfaceLineJoint)cairo_get_line_join(CONTEXT);                                  }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setAntiAlias:(OMSurfaceAntiAlias)inAntiAlias {                            cairo_set_antialias(CONTEXT, (cairo_antialias_t)inAntiAlias); }
- (OMSurfaceAntiAlias)antiAlias                      { return (OMSurfaceAntiAlias)cairo_get_antialias(CONTEXT);                                 }
//----------------------------------------------------------------------------------------------------------------------------------
//@property (assign) ... dashing;
//==================================================================================================================================
- (void)contextReset { cairo_restore(CONTEXT);      }
- (void)contextPush  { cairo_save(CONTEXT);         }
- (void)contextPop   { cairo_restore(CONTEXT);      }
- (void)clip         { cairo_clip(CONTEXT);         }
- (void)clipReset    { cairo_reset_clip(CONTEXT);   }
//- (void)mask         { ...                          }
- (void)newPath      { cairo_new_path(CONTEXT);     }
- (void)newSubPath   { cairo_new_sub_path(CONTEXT); }
- (void)closePath    { cairo_close_path(CONTEXT);   }
//==================================================================================================================================
- (void)setColor:(OMColor)Color                             { cairo_set_source_rgba(CONTEXT, Color.r, Color.g, Color.b, Color.a); }
- (void)setColorR:(float)R G:(float)G B:(float)B            { cairo_set_source_rgb (CONTEXT,       R,       G,       B         ); }
- (void)setColorR:(float)R G:(float)G B:(float)B A:(float)A { cairo_set_source_rgba(CONTEXT,       R,       G,       B,       A); }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setDashingOn:(float)On Off:(float)Off
{
  if((On < 0.0f) || (Off < 0.0f)) //passing a negative value for On or Off will disable dashing
    cairo_set_dash(CONTEXT, NULL, 0, 0.0);
  else
  {
    double dashes[2];
    dashes[0] = On;
    dashes[1] = Off;
    cairo_set_dash(CONTEXT, dashes, 2, 0.0);
  }
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)setDashingOn:(float)On Off:(float)Off Offset:(float)Offset
{
  if((On < 0.0f) || (Off < 0.0f)) //passing a negative value for On or Off will disable dashing
    cairo_set_dash(CONTEXT, NULL, 0, 0.0);
  else
  {
    double dashes[2];
    dashes[0] = On;
    dashes[1] = Off;
    cairo_set_dash(CONTEXT, dashes, 2, (double)Offset);
  }
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setSourceSurface:(OMSurface *)Source
{
  cairo_set_source_surface(CONTEXT, cairo_get_target(Source.surfaceData), 0.0, 0.0);
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)setSourceSurface:(OMSurface *)Source atCoordinate:(OMCoordinate)Coordinate
{
  cairo_set_source_surface(CONTEXT, cairo_get_target(Source.surfaceData), (double)Coordinate.x, (double)Coordinate.y);
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)setSourceSurface:(OMSurface *)Source atX:(float)X Y:(float)Y
{
  cairo_set_source_surface(CONTEXT, cairo_get_target(Source.surfaceData), (double)X, (double)Y);
}
//==================================================================================================================================
- (void)paint                       { cairo_paint(CONTEXT);                           }
- (void)paintWithAlpha:(float)Alpha { cairo_paint_with_alpha(CONTEXT, (double)Alpha); }
- (void)stroke                      { cairo_stroke(CONTEXT);                          }
- (void)strokePreserve              { cairo_stroke_preserve(CONTEXT);                 }
- (void)fill                        { cairo_fill(CONTEXT);                            }
- (void)fillPreserve                { cairo_fill_preserve(CONTEXT);                   }
- (void)clearToColor:(OMColor)color
{
  cairo_set_source_rgb(CONTEXT, color.r, color.g, color.b);
  cairo_rectangle(CONTEXT, 0.0f, 0.0f, (float)_width, (float)_height);
  cairo_fill(CONTEXT);
}
//==================================================================================================================================
- (void)lineTo:(OMCoordinate)Coordinate { cairo_line_to(CONTEXT, (double)Coordinate.x, (double)Coordinate.y);   }
- (void)lineToX:(float)X Y:(float)Y     { cairo_line_to(CONTEXT, (double)            X, (double)            Y); }
- (void)moveTo:(OMCoordinate)Coordinate { cairo_move_to(CONTEXT, (double)Coordinate.x, (double)Coordinate.y);   }
- (void)moveToX:(float)X Y:(float)Y     { cairo_move_to(CONTEXT, (double)            X, (double)            Y); }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)curveControlA:(OMCoordinate)ControlA ControlB:(OMCoordinate)ControlB EndAt:(OMCoordinate)EndAt
{
  cairo_curve_to(CONTEXT, (double)ControlA.x, (double)ControlA.y, (double)ControlB.x, (double)ControlB.y, (double)EndAt.x, (double)EndAt.y);
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)curveControlAX:(float)ControlAX ControlAY:(float)ControlAY ControlBX:(float)ControlBX ControlBY:(float)ControlBY EndAtX:(float)EndAtX EndAtY:(float)EndAtY
{
  cairo_curve_to(CONTEXT, (double)ControlAX, (double)ControlAY, (double)ControlBX, (double)ControlBY, (double)EndAtX, (double)EndAtY);
}
//==================================================================================================================================
- (void)rectangle:(OMRectangle)Rectangle
{
  cairo_rectangle(CONTEXT, (double)Rectangle.topLeft.x,
                           (double)Rectangle.topLeft.y,
                           (double)(Rectangle.bottomRight.x - Rectangle.topLeft.x),
                           (double)(Rectangle.bottomRight.y - Rectangle.topLeft.y));
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)rectangleLeft:(float)Left Top:(float)Top Right:(float)Right Bottom:(float)Bottom
{
  cairo_rectangle(CONTEXT, (double)Left, (double)Top, (double)(Right-Left), (double)(Bottom-Top));
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)dimension:(OMDimension)Dimension
{
  cairo_rectangle(CONTEXT, (double)Dimension.origin.x, (double)Dimension.origin.y, (double)Dimension.size.width, (double)Dimension.size.height);
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)dimensionX:(float)X Y:(float)Y Width:(float)Width Height:(float)Height
{
  cairo_rectangle(CONTEXT, (double)X, (double)Y, (double)Width, (double)Height);
}
//==================================================================================================================================
- (void)arcCenter:(OMCoordinate)Center Radius:(float)Radius DegreeStart:(float)DegreeStart DegreeEnd:(float)DegreeEnd
{
  cairo_arc(CONTEXT, (double)Center.x, (double)Center.y, (double)Radius, DegreeStart*DEGREE, DegreeEnd*DEGREE);
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)arcCenterX:(float)CenterX CenterY:(float)CenterY Radius:(float)Radius DegreeStart:(float)DegreeStart DegreeEnd:(float)DegreeEnd
{
  cairo_arc(CONTEXT, (double)CenterX, (double)CenterY, (double)Radius, DegreeStart*DEGREE, DegreeEnd*DEGREE);
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)arcCenter:(OMCoordinate)Center Radius:(float)Radius RadianStart:(float)RadianStart RadianEnd:(float)RadianEnd
{
  cairo_arc(CONTEXT, (double)Center.x, (double)Center.y, (double)Radius, (double)RadianStart, (double)RadianEnd);
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)arcCenterX:(float)CenterX CenterY:(float)CenterY Radius:(float)Radius RadianStart:(float)RadianStart RadianEnd:(float)RadianEnd
{
  cairo_arc(CONTEXT, (double)CenterX, (double)CenterY, (double)Radius, (double)RadianStart, (double)RadianEnd);
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)roundedDimension:(OMDimension)Dimension withRadius:(float)Radius
{
  [self newSubPath];
  [self arcCenterX: Dimension.origin.x + Dimension.size.width  - Radius
           CenterY: Dimension.origin.y +                         Radius
            Radius: Radius
       DegreeStart: -90.0f
         DegreeEnd:   0.0f];
  [self arcCenterX: Dimension.origin.x + Dimension.size.width  - Radius
           CenterY: Dimension.origin.y + Dimension.size.height - Radius
            Radius: Radius
       DegreeStart:   0.0f
         DegreeEnd:  90.0f];
  [self arcCenterX: Dimension.origin.x +                         Radius
           CenterY: Dimension.origin.y + Dimension.size.height - Radius
            Radius: Radius
       DegreeStart:  90.0f
         DegreeEnd: 180.0f];
  [self arcCenterX: Dimension.origin.x +                         Radius
           CenterY: Dimension.origin.y +                         Radius
            Radius: Radius
       DegreeStart: 180.0f
         DegreeEnd: 270.0f];
  [self closePath];
}

//==================================================================================================================================
@end
//==================================================================================================================================
