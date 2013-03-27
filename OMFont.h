//==================================================================================================================================
// OMFont.h
//==================================================================================================================================
#import <ObjFW/ObjFW.h>
//==================================================================================================================================
typedef enum
{
  OMFONT_WEIGHT_THIN       =  100,
  OMFONT_WEIGHT_ULTRALIGHT =  200,
  OMFONT_WEIGHT_LIGHT      =  300,
  OMFONT_WEIGHT_BOOK       =  380,
  OMFONT_WEIGHT_NORMAL     =  400,
  OMFONT_WEIGHT_MEDIUM     =  500,
  OMFONT_WEIGHT_SEMIBOLD   =  600,
  OMFONT_WEIGHT_BOLD       =  700,
  OMFONT_WEIGHT_ULTRABOLD  =  800,
  OMFONT_WEIGHT_HEAVY      =  900,
  OMFONT_WEIGHT_ULTRAHEAVY = 1000
} OMFontWeight;
//----------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
  OMFONT_STYLE_NORMAL  = 0,
  OMFONT_STYLE_OBLIQUE = 1,
  OMFONT_STYLE_ITALIC  = 2
} OMFontStyle;
//----------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
  OMFONT_VARIANT_NORMAL    = 0,
  OMFONT_VARIANT_SMALLCAPS = 1
} OMFontVariant;
//----------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
  OMFONT_STRETCH_ULTRACONDENSED = 0,
  OMFONT_STRETCH_EXTRACONDENSED = 1,
  OMFONT_STRETCH_CONDENSED      = 2,
  OMFONT_STRETCH_SEMICONDENSED  = 3,
  OMFONT_STRETCH_NORMAL         = 4,
  OMFONT_STRETCH_SEMIEXPANDED   = 5,
  OMFONT_STRETCH_EXPANDED       = 6,
  OMFONT_STRETCH_EXTRAEXPANDED  = 7,
  OMFONT_STRETCH_ULTRAEXPANDED  = 8
} OMFontStretch;
//----------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
  OMFONT_GRAVITY_SOUTH = 0,
  OMFONT_GRAVITY_EAST  = 1,
  OMFONT_GRAVITY_NORTH = 2,
  OMFONT_GRAVITY_WEST  = 3,
  OMFONT_GRAVITY_AUTO  = 4
} OMFontGravity;
//==================================================================================================================================
@interface OMFont : OFObject <OFCopying>
{
  @protected void *_fontData;
}
//----------------------------------------------------------------------------------------------------------------------------------
@property (copy)     OFString     *family;
@property (assign)   float         size;
@property (assign)   OMFontWeight  weight;
@property (assign)   OMFontStyle   style;
@property (assign)   OMFontVariant variant;
@property (assign)   OMFontGravity gravity;
@property (readonly) BOOL          isValid;
@property (readonly) BOOL          isMonospaced;
@property (readonly) void         *fontData;
//----------------------------------------------------------------------------------------------------------------------------------
+ font;
+ fontWithFamily:(OFString *)family;
+ fontWithDescription:(OFString *)description;
+ fontWithFontData:(void *)FontData;
- copy;
- initWithFamily:(OFString *)family;
- initWithDescription:(OFString *)description;
- initWithFontData:(void *)FontData;
//----------------------------------------------------------------------------------------------------------------------------------
+ (BOOL)isFamilyMonospaced:(OFString *)familyName;
+ (OFList *)listFontFamilies;
- (OFString *)toString;
- (BOOL)isEqualTo:(OMFont *)font;
//----------------------------------------------------------------------------------------------------------------------------------
@end
//==================================================================================================================================
