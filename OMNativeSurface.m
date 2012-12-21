//==================================================================================================================================
// OMNativeSurface.m
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
#import "OMNativeSurface.h"
#include <gdk/gdk.h>
#include <cairo/cairo.h>
//----------------------------------------------------------------------------------------------------------------------------------
#define CONTEXT (cairo_t *)_surfaceData
//==================================================================================================================================
@implementation OMNativeSurface
//----------------------------------------------------------------------------------------------------------------------------------
@synthesize nativeData = _nativeData;
//----------------------------------------------------------------------------------------------------------------------------------
+ nativeSurfaceWithData:(void *)data width:(float)width height:(float)height;
{
  return [[[self alloc] initWithData:data width:width height:height] autorelease];
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithData:(void *)gdkWindow width:(float)width height:(float)height
{
  self = [super init];
  if(self)
  {
    _nativeData  = gdkWindow;
    _width       = width;
    _height      = height;
    _surfaceData = (void *)gdk_cairo_create((GdkWindow *)gdkWindow);
  }
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)nativeRelease
{
  cairo_destroy(CONTEXT);
  _nativeData = NULL;
}
//----------------------------------------------------------------------------------------------------------------------------------
-(void)dealloc
{
  [self nativeRelease];
  [super dealloc];
}
//----------------------------------------------------------------------------------------------------------------------------------
@end
//==================================================================================================================================
