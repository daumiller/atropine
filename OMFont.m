//==================================================================================================================================
// OMFont.m
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
#import "OMFont.h"
#import "OMFontNotFoundException.h"
#include <pango/pango.h>
//----------------------------------------------------------------------------------------------------------------------------------
#ifdef _WIN32
#undef STRICT //disable an annoying warning. 
#include <pango/pangowin32.h>
#elif defined __APPLE__
#include <pango/pangocairo.h>
#elif defined __linux__
#include <pango/pangocairo.h>
#else
#error "Unsupported Platform"
#endif
//----------------------------------------------------------------------------------------------------------------------------------
#define PFDESCRIPTION       (PangoFontDescription *)_fontData
#define CONST_PFDESCRIPTION (const PangoFontDescription *)_fontData
//==================================================================================================================================
@implementation OMFont
//----------------------------------------------------------------------------------------------------------------------------------
@synthesize fontData = _fontData;
//----------------------------------------------------------------------------------------------------------------------------------
+ font
{
  return [[self alloc] init];
}
//----------------------------------------------------------------------------------------------------------------------------------
+ fontWithFamily:(OFString *)family
{
  return [[self alloc] initWithFamily:family];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
+ fontWithDescription:(OFString *)description
{
  return [[self alloc] initWithDescription:description];
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
+ fontWithFontData:(void *)FontData
{
  return [[self alloc] initWithFontData:FontData];
}
//----------------------------------------------------------------------------------------------------------------------------------
- copy
{
  char *descr = pango_font_description_to_string(PFDESCRIPTION);
  PangoFontDescription *newData = pango_font_description_from_string(descr);
  g_free(descr);
  return [[OMFont alloc] initWithFontData:(void *)newData];
}
//----------------------------------------------------------------------------------------------------------------------------------
- init
{
  self = [super init];
  PangoFontDescription *pfd = pango_font_description_new();
  _fontData = (void *)pfd;
  return self;
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- initWithFamily:(OFString *)family
{
  self = [super init];
  PangoFontDescription *pfd = pango_font_description_new();
  @autoreleasepool  //"[family UTF8String]" allocs a new AR object to hold data
  {
    pango_font_description_set_family(pfd, [family UTF8String]);
  }
  _fontData = (void *)pfd;
  return self;
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- initWithDescription:(OFString *)description
{
  self = [super init];
  @autoreleasepool  //"[description UTF8String]" allocs a new AR object to hold data
  {
    _fontData = (void *)pango_font_description_from_string([description UTF8String]);
  }
  return self;
}
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- initWithFontData:(void *)FontData
{
  self = [super init];
  _fontData = FontData;
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc
{
  if(_fontData != NULL)
    pango_font_description_free(PFDESCRIPTION);
}
//----------------------------------------------------------------------------------------------------------------------------------
+ (BOOL)isFamilyMonospaced:(OFString *)familyName
{
  #ifdef _WIN32
    PangoContext *ctx = pango_font_map_create_context(pango_win32_font_map_for_display());
  #elif defined __APPLE__
    PangoContext *ctx = pango_font_map_create_context((PangoFontMap *)pango_cairo_font_map_get_default());
  #elif defined __linux__
    PangoContext *ctx = pango_font_map_create_context((PangoFontMap *)pango_cairo_font_map_get_default());
  #endif
  BOOL ret = NO;
  BOOL hit = NO;
  PangoFontFamily **families = NULL;
  PangoFontFamily  *family   = NULL;
  int i, familyCount = 0;
  pango_context_list_families(ctx, &families, &familyCount);
  
  @autoreleasepool  //make sure we clean up all the "comparer" strings we create here...
  {
    for(i=0; i<familyCount; i++)
    {
      //result of pango_font_family_get_name(family) is owned/cleaned by specified family
      OFString *comparer = [OFString stringWithUTF8String:pango_font_family_get_name(families[i])];
      if([familyName caseInsensitiveCompare:comparer] == OF_ORDERED_SAME)
      {
        hit = YES;
        ret = pango_font_family_is_monospace(families[i]);
        break;
      }
    }
  }
  
  //can't find anything about if we should be free()ing each element in families array or not...
  //maybe they're statically owned & cleaned by the context?
  g_free(families);
  g_object_unref(ctx);
  if(hit == NO)
    @throw [OMFontNotFoundException exceptionWithClass:self fontName:familyName];
  return ret;
}
//----------------------------------------------------------------------------------------------------------------------------------
+ (OFList *)listFontFamilies
{
  #ifdef _WIN32
    PangoContext *ctx = pango_font_map_create_context(pango_win32_font_map_for_display());
  #elif defined __APPLE__
    PangoContext *ctx = pango_font_map_create_context((PangoFontMap *)pango_cairo_font_map_get_default());
  #elif defined __linux__
    PangoContext *ctx = pango_font_map_create_context((PangoFontMap *)pango_cairo_font_map_get_default());
  #endif
  OFList *lst = [OFList list];
  PangoFontFamily **families = NULL;
  PangoFontFamily  *family   = NULL;
  int i, familyCount = 0;
  pango_context_list_families(ctx, &families, &familyCount);
  for(i=0; i<familyCount; i++)
    [lst appendObject:[OFString stringWithUTF8String:pango_font_family_get_name(families[i])]];
  g_free(families);
  g_object_unref(ctx);
  return lst; //an AR list + a set of AR strings
}
//----------------------------------------------------------------------------------------------------------------------------------
- (OFString *)toString
{
  char *descr = pango_font_description_to_string(PFDESCRIPTION);
  OFString *ret = [OFString stringWithUTF8String:descr];
  g_free(descr);
  return ret;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)isEqualTo:(OMFont *)font
{
  return pango_font_description_equal(PFDESCRIPTION, (const PangoFontDescription *)(font.fontData));
}
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setFamily : (OFString *)inFamily
{
  @autoreleasepool  //free "[inFamily UTF8String]" container object
  {
    pango_font_description_set_family(PFDESCRIPTION, [inFamily UTF8String]);
  }
}
- (OFString *)family                     { return [OFString stringWithUTF8String:pango_font_description_get_family(PFDESCRIPTION)]; /*does Not need free()d*/ }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setSize : (float)inSize {               pango_font_description_set_absolute_size(PFDESCRIPTION, inSize * PANGO_SCALE); }
- (float)size                   { return (float)pango_font_description_get_size(PFDESCRIPTION);                                }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setWeight : (OMFontWeight)inWeight {                      pango_font_description_set_weight(PFDESCRIPTION, (PangoWeight)inWeight); }
- (OMFontWeight)weight                     { return (OMFontWeight)pango_font_description_get_weight(PFDESCRIPTION);                        }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setStyle : (OMFontStyle)inStyle {                     pango_font_description_set_style(PFDESCRIPTION, (PangoStyle)inStyle); }
- (OMFontStyle)style                    { return (OMFontStyle)pango_font_description_get_style(PFDESCRIPTION);                      }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setVariant : (OMFontVariant)inVariant {                       pango_font_description_set_variant(PFDESCRIPTION, (PangoVariant)inVariant); }
- (OMFontVariant)variant                      { return (OMFontVariant)pango_font_description_get_variant(PFDESCRIPTION);                          }
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setGravity : (OMFontGravity)inGravity {                       pango_font_description_set_gravity(PFDESCRIPTION, (PangoGravity)inGravity); }
- (OMFontGravity)gravity                      { return (OMFontGravity)pango_font_description_get_gravity(PFDESCRIPTION);                          }
//----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)isValid      { return (_fontData != NULL); }
- (BOOL)isMonospaced
{
  BOOL result;
  @autoreleasepool { result = [OMFont isFamilyMonospaced:self.family]; }
  return result;
}
//----------------------------------------------------------------------------------------------------------------------------------
@end
//==================================================================================================================================
