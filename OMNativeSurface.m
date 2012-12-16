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
#ifdef _WIN32
#include <cairo/cairo-win32.h>
#elif defined __APPLE__
#import <Cocoa/Cocoa.h>
#include <cairo/cairo-quartz.h>
#elif defined __linux__
#import <gtk/gtk.h>
#else
#error "Unsupported Platform"
#endif
//----------------------------------------------------------------------------------------------------------------------------------
#import "OMNativeSurface.h"
#include <cairo/cairo.h>
//----------------------------------------------------------------------------------------------------------------------------------
#define CONTEXT (cairo_t *)_surfaceData
//==================================================================================================================================
@implementation OMNativeSurface
//----------------------------------------------------------------------------------------------------------------------------------
@synthesize nativeData = _nativeData;
//----------------------------------------------------------------------------------------------------------------------------------
+ nativeSurfaceWithData:(void *)data
{
  #ifdef _WIN32
    return [[[self alloc] initWithData:data] autorelease];
  #elif defined __APPLE__
    return [[(OMNativeSurface *)[self alloc] initWithData:data] autorelease];
  #elif defined __linux__
    return [[[self alloc] initWithData:data] autorelease];
  #endif
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithData:(void *)data
{
  self = [super init];
  #ifdef _WIN32
    _nativeData = data;
    HWND hwnd = (HWND)data;
    RECT clientRect;
    GetClientRect(hwnd, &clientRect);
    _width  = (float)(clientRect.right  - clientRect.left);
    _height = (float)(clientRect.bottom - clientRect.top );
    HDC hdc = GetDC(hwnd);
    cairo_surface_t *surf = cairo_win32_surface_create(hdc);
    _surfaceData = (void *)cairo_create(surf);
    cairo_surface_destroy(surf);
  #elif defined __APPLE__
    _nativeData = data;
    NSView *view = (NSView *)data;
    NSRect bounds = [view bounds];
    _width  = (float)bounds.size.width;
    _height = (float)bounds.size.height;
    CGContextRef ctx = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextTranslateCTM(ctx, 0.0, bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    cairo_surface_t   *surf   = cairo_quartz_surface_create_for_cg_context(ctx,
                                  (int)bounds.size.width,
                                  (int)bounds.size.height);
    _surfaceData = (void *)cairo_create(surf);
    cairo_surface_destroy(surf);
  #elif defined __linux__
    _nativeData = data;
    int iWidth, iHeight;
    GtkWidget *gwdg = (GtkWidget *)data;
    GtkWindow *gwnd = (GtkWindow *)gtk_widget_get_parent(gwdg);
    gtk_window_get_size(gwnd, &iWidth, &iHeight);
    _width  = (float)iWidth;
    _height = (float)iHeight;
    _surfaceData = (void *)gdk_cairo_create(gtk_widget_get_parent_window(gwdg));
  #endif
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)nativeRelease
{
  #ifdef _WIN32
    if(_nativeData != NULL)
    {
      HDC hdc = cairo_win32_surface_get_dc(cairo_get_target(CONTEXT));
      cairo_destroy(CONTEXT);
      ReleaseDC((HWND)_nativeData, hdc);
      _nativeData = NULL;
    }
  #elif defined __APPLE__
    cairo_destroy(CONTEXT);
    _nativeData = NULL;
  #elif defined __linux__
    cairo_destroy(CONTEXT);
    _nativeData = NULL;
  #endif
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
