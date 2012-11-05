//==================================================================================================================================
// OMBufferSurface.m
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
#import "OMBufferSurface.h"
#include <cairo/cairo.h>
//----------------------------------------------------------------------------------------------------------------------------------
#define CONTEXT (cairo_t *)_surfaceData
#define DESTCONTEXT (cairo_t *)(surface.surfaceData)
//==================================================================================================================================
@implementation OMBufferSurface
//----------------------------------------------------------------------------------------------------------------------------------
+ bufferSurfaceWithSize:(OMSize)Size
{
  return [[self alloc] initWithOMSize:Size];
}
//----------------------------------------------------------------------------------------------------------------------------------
+ bufferSurfaceWithWidth:(int)Width Height:(int)Height
{
  return [[self alloc] initWithWidth:Width Height:Height];
}
//----------------------------------------------------------------------------------------------------------------------------------
+ bufferSurfaceWithPNG:(OFString *)Filename
{
  return [[self alloc] initWithPNG:Filename];
}
//----------------------------------------------------------------------------------------------------------------------------------
- copy
{
  OMBufferSurface *surf = [[OMBufferSurface alloc] initWithWidth:(float)_width Height:(float)_height];
  [self copyToSurface:surf DestinationX:0.0f DestinationY:0.0f];
  return surf;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithOMSize:(OMSize)Size
{
  self   = [super init];
  _width  = Size.width;
  _height = Size.height;
  cairo_surface_t *cairoSurf = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, _width, _height);
  _surfaceData = (void *)cairo_create(cairoSurf);
  cairo_surface_destroy(cairoSurf); //maintain a single reference inside our cairo context (_surfaceData)
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithWidth:(int)Width Height:(int)Height
{
  self = [super init];
  _width  = Width;
  _height = Height;
  cairo_surface_t *cairoSurf = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, _width, _height);
  _surfaceData = (void *)cairo_create(cairoSurf);
  cairo_surface_destroy(cairoSurf); //maintain a single reference inside our cairo context (_surfaceData)
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithPNG:(OFString *)Filename
{
  self = [super init];
  cairo_surface_t *cairoSurf = NULL;
  @autoreleasepool  //collect our "[Filename UTF8String]" container object
  {
    cairoSurf = cairo_image_surface_create_from_png((const char *)[Filename UTF8String]);
  }
  cairo_status_t readStatus = cairo_surface_status(cairoSurf);
  if((readStatus == CAIRO_STATUS_FILE_NOT_FOUND) || (readStatus == CAIRO_STATUS_NO_MEMORY) || (readStatus == CAIRO_STATUS_READ_ERROR))
    @throw [[OFReadFailedException alloc] init];
  _width  = cairo_image_surface_get_width(cairoSurf);
  _height = cairo_image_surface_get_height(cairoSurf);
  _surfaceData = (void *)cairo_create(cairoSurf);
  cairo_surface_destroy(cairoSurf); //maintain a single reference inside our cairo context (_surfaceData)
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)bufferRelease
{
  cairo_destroy((cairo_t *)_surfaceData);
  _surfaceData = NULL;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc
{
  if(_surfaceData != NULL)
    [self bufferRelease];
}
//----------------------------------------------------------------------------------------------------------------------------------
- (unsigned char *)rawData
{
  return cairo_image_surface_get_data(cairo_get_target(CONTEXT));
}
//----------------------------------------------------------------------------------------------------------------------------------
- (int)rawStride
{
  return cairo_image_surface_get_stride(cairo_get_target(CONTEXT));
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)resize:(OMSize)Size
{
  _width  = Size.width;
  _height = Size.height;
  cairo_surface_t *resizeSurf = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, _width, _height);
  cairo_t *resizedCtx = cairo_create(resizeSurf);
  cairo_surface_destroy(resizeSurf);
  cairo_t *oldCtx = CONTEXT;
  _surfaceData = (void *)resizedCtx;
  cairo_destroy(oldCtx);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)resizeWidth:(int)Width Height:(int)Height
{
  _width  = Width;
  _height = Height;
  cairo_surface_t *resizeSurf = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, _width, _height);
  cairo_t *resizedCtx = cairo_create(resizeSurf);
  cairo_surface_destroy(resizeSurf);
  cairo_t *oldCtx = CONTEXT;
  _surfaceData = (void *)resizedCtx;
  cairo_destroy(oldCtx);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)resizePreserve:(OMSize)Size
{
  [self resizePreserveWidth:Size.width Height:Size.height];
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)resizePreserveWidth:(int)Width Height:(int)Height
{
  cairo_surface_t *resizeSurf = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, Width, Height);
  cairo_t *resizedCtx = cairo_create(resizeSurf);
  cairo_surface_destroy(resizeSurf);
  cairo_t *oldCtx = CONTEXT;
  _surfaceData = (void *)resizedCtx;
  OMSize copySize = OMMakeSize(_width, _height);
  if(Width  < _width ) copySize.width  = Width;
  if(Height < _height) copySize.height = Height;
  cairo_set_source_surface(CONTEXT, cairo_get_target((cairo_t *)oldCtx), 0.0f, 0.0f);
  cairo_set_operator(CONTEXT, CAIRO_OPERATOR_SOURCE);
  cairo_rectangle(CONTEXT, 0.0f, 0.0f, copySize.width, copySize.height);
  cairo_fill(CONTEXT);
  cairo_destroy(oldCtx);
  _width  = Width;
  _height = Height;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)copyToSurface:(OMSurface *)surface DestinationX:(float)X DestinationY:(float)Y
{
  cairo_set_source_surface(DESTCONTEXT, cairo_get_target(CONTEXT), X, Y);
  cairo_set_operator(DESTCONTEXT, CAIRO_OPERATOR_SOURCE);
  cairo_rectangle(DESTCONTEXT, X, Y, _width, _height);
  cairo_fill(DESTCONTEXT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)copyToSurface:(OMSurface *)surface DestinationCoordinate:(OMCoordinate)Coordinate
{
  cairo_set_source_surface(DESTCONTEXT, cairo_get_target(CONTEXT), Coordinate.x, Coordinate.y);
  cairo_set_operator(DESTCONTEXT, CAIRO_OPERATOR_SOURCE);
  cairo_rectangle(DESTCONTEXT, Coordinate.x, Coordinate.y, _width, _height);
  cairo_fill(DESTCONTEXT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)copyToSurface:(OMSurface *)surface DestinationCoordinate:(OMCoordinate)Coordinate SourceRectangle:(OMRectangle)Rectangle
{
  cairo_set_source_surface(DESTCONTEXT, cairo_get_target(CONTEXT), Coordinate.x, Coordinate.y);
  cairo_set_operator(DESTCONTEXT, CAIRO_OPERATOR_SOURCE);
  cairo_rectangle(DESTCONTEXT,
                  Coordinate.x + Rectangle.topLeft.x,
                  Coordinate.y + Rectangle.topLeft.y,
                  Rectangle.bottomRight.x - Rectangle.topLeft.x,
                  Rectangle.bottomRight.y - Rectangle.topLeft.y);
  cairo_fill(DESTCONTEXT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)copyToSurface:(OMSurface *)surface DestinationCoordinate:(OMCoordinate)Coordinate SourceDimension:(OMDimension)Dimension
{
  cairo_set_source_surface(DESTCONTEXT, cairo_get_target(CONTEXT), Coordinate.x, Coordinate.y);
  cairo_set_operator(DESTCONTEXT, CAIRO_OPERATOR_SOURCE);
  cairo_rectangle(DESTCONTEXT,
                  Coordinate.x + Dimension.origin.x,
                  Coordinate.y + Dimension.origin.y,
                  Dimension.size.width,
                  Dimension.size.height);
  cairo_fill(DESTCONTEXT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)writeToPNG:(OFString *)Filename
{
  cairo_status_t writeStatus;
  @autoreleasepool  //collect "[Filename UTF8String]" container object
  {
    writeStatus = cairo_surface_write_to_png(cairo_get_target(CONTEXT), [Filename UTF8String]);
  }
  if(writeStatus != CAIRO_STATUS_SUCCESS)
    @throw [[OFWriteFailedException alloc] init];
}
//----------------------------------------------------------------------------------------------------------------------------------
@end
//==================================================================================================================================
