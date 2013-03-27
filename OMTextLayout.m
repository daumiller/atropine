//==================================================================================================================================
// OMTextLayout.m
//==================================================================================================================================
#import "OMTextLayout.h"
#include <glib.h>              //not happy about this include... but i'm too lazy to look into the UTF8->gunichar conversion process
#include <cairo/cairo.h>
#include <pango/pangocairo.h>
//----------------------------------------------------------------------------------------------------------------------------------
#define CONTEXT (cairo_t *)(Surface.surfaceData)
#define LAYOUT  (PangoLayout *)_layoutData
//==================================================================================================================================
@implementation OMTextLayout
//==================================================================================================================================
- (void)setFont:(OMFont *)inFont {                                         pango_layout_set_font_description(LAYOUT, (const PangoFontDescription *)inFont.fontData); }
- (OMFont *)font                 { return [OMFont fontWithFontData:(void *)pango_layout_get_font_description(LAYOUT)]; /*..._get_font_description() owned/free()d by the layout*/ }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setText:(OFString *)inText
{
  //[OFString UTF8String]'s alloc'd data is autoreleased along with the instance it came from
  OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init];
  pango_layout_set_text(LAYOUT, [inText UTF8String], -1);
  [pool drain];
}
- (OFString *)text                 { return [OFString stringWithUTF8String:pango_layout_get_text(LAYOUT)]; /*owned/free()d by the layout*/ }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setEllipsis:(OMTextLayoutEllipsis)inEllipsis {                              pango_layout_set_ellipsize(LAYOUT, (PangoEllipsizeMode)inEllipsis); }
- (OMTextLayoutEllipsis)ellipsis                     { return (OMTextLayoutEllipsis)pango_layout_get_ellipsize(LAYOUT);                                 }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setWrap:(OMTextLayoutWrap)inWrap {                          pango_layout_set_wrap(LAYOUT, (PangoWrapMode)inWrap); }
- (OMTextLayoutWrap)wrap                 { return (OMTextLayoutWrap)pango_layout_get_wrap(LAYOUT);                        }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setAlignment:(OMTextLayoutAlignment)inAlignment {                               pango_layout_set_alignment(LAYOUT, (PangoAlignment)inAlignment); }
- (OMTextLayoutAlignment)alignment                      { return (OMTextLayoutAlignment)pango_layout_get_alignment(LAYOUT);                              }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setWrapWidth:(float)inWrapWidth
{
  int iwrap = (inWrapWidth < 0.0f) ? -1 : ((int)inWrapWidth);
  pango_layout_set_width(LAYOUT, iwrap);
}
- (float)wrapWidth
{
  return (float)pango_layout_get_width(LAYOUT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setWrapHeight:(float)inWrapHeight
{
  int iwrap = (inWrapHeight < 0.0f) ? -1 : ((int)inWrapHeight);
  pango_layout_set_height(LAYOUT, iwrap);
}
- (float)wrapHeight
{
  return (float)pango_layout_get_height(LAYOUT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setWrapSize:(OMSize)inWrapSize
{
  [self setWrapWidth :inWrapSize.width];
  [self setWrapHeight:inWrapSize.height];
}
- (OMSize)wrapSize
{
  return OMMakeSize(self.wrapWidth, self.wrapHeight);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setIndent:(float)inIndent {               pango_layout_set_indent(LAYOUT, (int)inIndent); }
- (float)indent                   { return (float)pango_layout_get_indent(LAYOUT);                }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setLineSpacing:(float)inLineSpacing {               pango_layout_set_spacing(LAYOUT, (int)inLineSpacing); }
- (float)lineSpacing                        { return (float)pango_layout_get_spacing(LAYOUT);                     }
//----------------------------------------------------------------------------------------------------------------------------------
- (OMSize)extents
{
  int extW, extH;
  pango_layout_get_pixel_size(LAYOUT, &extW, &extH);
  return OMMakeSize((float)extW, (float)extH);
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (float)extentWidth
{
  int extW;
  pango_layout_get_pixel_size(LAYOUT, &extW, NULL);
  return (float)extW;
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (float)extentHeight
{
  int extH;
  pango_layout_get_pixel_size(LAYOUT, NULL, &extH);
  return (float)extH;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (float)baseLine { return (float)pango_layout_get_baseline  (LAYOUT); }
- (int)lineCount  { return        pango_layout_get_line_count(LAYOUT); }
- (BOOL)isWrapped { return        pango_layout_is_wrapped    (LAYOUT); }
//==================================================================================================================================
+ layoutWithSurface:(OMSurface *)Surface
{
  return [[[self alloc] initWithSurface:Surface] autorelease];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
+ layoutWithSurface:(OMSurface *)Surface Text:(OFString *)Text
{
  return [[[self alloc] initWithSurface:Surface Text:Text] autorelease];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
+ layoutWithSurface:(OMSurface *)Surface Text:(OFString *)Text Font:(OMFont *)Font
{
  return [[[self alloc] initWithSurface:Surface Text:Text Font:Font] autorelease];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
+ layoutWithSurface:(OMSurface *)Surface Text:(OFString *)Text Font:(OMFont *)Font WrapSize:(OMSize)WrapSize
{
  return [[[self alloc] initWithSurface:Surface Text:Text Font:Font WrapSize:WrapSize] autorelease];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
+ layoutWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup
{
  return [[[self alloc] initWithSurface:Surface Markup:Markup] autorelease];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
+layoutWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup Accelerator:(OFString *)Accelerator
{
  return [[[self alloc] initWithSurface:Surface Markup:Markup Accelerator:Accelerator] autorelease];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
+ layoutWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup WrapSize:(OMSize)WrapSize
{
  return [[[self alloc] initWithSurface:Surface Markup:Markup WrapSize:WrapSize] autorelease];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
+ layoutWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup Accelerator:(OFString *)Accelerator WrapSize:(OMSize)WrapSize
{
  return [[[self alloc] initWithSurface:Surface Markup:Markup Accelerator:Accelerator WrapSize:WrapSize] autorelease];
}
//==================================================================================================================================
- initWithSurface:(OMSurface *)Surface
{
  self = [super init];
  _layoutData = (void *)pango_cairo_create_layout(CONTEXT);
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithSurface:(OMSurface *)Surface Text:(OFString *)Text
{
  self = [super init];
  _layoutData = (void *)pango_cairo_create_layout(CONTEXT);
  self.text = Text;
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithSurface:(OMSurface *)Surface Text:(OFString *)Text Font:(OMFont *)Font
{
  self = [super init];
  _layoutData = (void *)pango_cairo_create_layout(CONTEXT);
  self.font = Font;
  self.text = Text;
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithSurface:(OMSurface *)Surface Text:(OFString *)Text Font:(OMFont *)Font WrapSize:(OMSize)WrapSize
{
  self = [super init];
  _layoutData = (void *)pango_cairo_create_layout(CONTEXT);
  self.font          = Font;
  self.wrapSize      = WrapSize;
  self.text          = Text;
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup
{
  self = [super init];
  _layoutData = (void *)pango_cairo_create_layout(CONTEXT);
  [self setTextAsMarkup:Markup];
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup Accelerator:(OFString *)Accelerator
{
  self = [super init];
  _layoutData = (void *)pango_cairo_create_layout(CONTEXT);
  [self setTextAsMarkup:Markup Accelerator:Accelerator];
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup WrapSize:(OMSize)WrapSize
{
  self = [super init];
  _layoutData = (void *)pango_cairo_create_layout(CONTEXT);
  self.wrapSize = WrapSize;
  [self setTextAsMarkup:Markup];
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup Accelerator:(OFString *)Accelerator WrapSize:(OMSize)WrapSize
{
  self = [super init];
  _layoutData = (void *)pango_cairo_create_layout(CONTEXT);
  self.wrapSize = WrapSize;
  [self setTextAsMarkup:Markup Accelerator:Accelerator];
  return self;
}
//==================================================================================================================================
- (void)dealloc
{
  if(_layoutData != NULL)
    g_object_unref(_layoutData);
  [super dealloc];
}
//==================================================================================================================================
- (void)setTextAsMarkup:(OFString *)Markup
{
  OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init]; //collect "[Markup UTF8String]" container object
  pango_layout_set_markup(LAYOUT, [Markup UTF8String], -1);
  [pool drain];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- (void)setTextAsMarkup:(OFString *)Markup Accelerator:(OFString *)Accelerator
{
  OFAutoreleasePool *pool = [[OFAutoreleasePool alloc] init]; //another couple [STRING UTF8String]s...
  glong readBytes, wroteChars;
  gunichar *tmp = g_utf8_to_ucs4([Accelerator UTF8String], 4, &readBytes, &wroteChars, NULL);
  if((tmp == NULL) || (wroteChars == 0))
  {
    //error occured, or empty string given; revert to non-accelerator version
    [self setTextAsMarkup:Markup];
    [pool drain];
    return;
  }
  pango_layout_set_markup_with_accel(LAYOUT, [Markup UTF8String], -1, tmp[0], NULL);
  g_free(tmp);
  [pool drain];
}
//==================================================================================================================================
- (void)pathToSurface:(OMSurface *)Surface
{
  pango_cairo_layout_path(CONTEXT, LAYOUT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)pathToSurface:(OMSurface *)Surface X:(float)X Y:(float)Y
{
  [Surface moveToX:X Y:Y];
  pango_cairo_layout_path(CONTEXT, LAYOUT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)pathToSurface:(OMSurface *)Surface Coordinate:(OMCoordinate)Coordinate
{
  [Surface moveTo:Coordinate];
  pango_cairo_layout_path(CONTEXT, LAYOUT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)pathToSurface:(OMSurface *)Surface Rectangle:(OMRectangle)Rectangle
{
  //TODO: need to test this! not sure if it's correct...
  [Surface rectangle:Rectangle];
  [Surface clip];
  [Surface moveToX:Rectangle.topLeft.x Y:Rectangle.topLeft.y];
  pango_cairo_layout_path(CONTEXT, LAYOUT);
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)pathToSurface:(OMSurface *)Surface Dimension:(OMDimension)Dimension
{
  //TODO: need to test this! not sure if it's correct...
  [Surface dimension:Dimension];
  [Surface clip];
  [Surface moveToX:Dimension.origin.x Y:Dimension.origin.y];
  pango_cairo_layout_path(CONTEXT, LAYOUT);
}
//==================================================================================================================================
@end
//==================================================================================================================================
