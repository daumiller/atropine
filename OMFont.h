//==================================================================================================================================
// OMFont.h
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
