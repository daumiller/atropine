//==================================================================================================================================
// OMTextLayout.h
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
#import "OMFont.h"
#import "OMCoordinate.h"
#import "OMRectangle.h"
#import "OMSurface.h"
//==================================================================================================================================
typedef enum
{
  OMTEXTLAYOUT_WRAP_WORD     = 0,
  OMTEXTLAYOUT_WRAP_CHAR     = 1,
  OMTEXTLAYOUT_WRAP_WORDCHAR = 2
} OMTextLayoutWrap;
//----------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
  OMTEXTLAYOUT_ELLIPSIS_NONE   = 0,
  OMTEXTLAYOUT_ELLIPSIS_START  = 1,
  OMTEXTLAYOUT_ELLIPSIS_MIDDLE = 2,
  OMTEXTLAYOUT_ELLIPSIS_END    = 3
} OMTextLayoutEllipsis;
//----------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
  OMTEXTLAYOUT_ALIGNMENT_LEFT   = 0,
  OMTEXTLAYOUT_ALIGNMENT_CENTER = 1,
  OMTEXTLAYOUT_ALIGNMENT_RIGHT  = 2
} OMTextLayoutAlignment;
//==================================================================================================================================
@interface OMTextLayout : OFObject
{
  @protected void *_layoutData;
}
//----------------------------------------------------------------------------------------------------------------------------------
@property (assign)   OMFont               *font;
@property (assign)   OFString             *text;
@property (assign)   OMTextLayoutEllipsis  ellipsis;
@property (assign)   OMTextLayoutWrap      wrap;
@property (assign)   OMTextLayoutAlignment alignment;
@property (assign)   float                 wrapWidth;
@property (assign)   float                 wrapHeight;
@property (assign)   OMSize                wrapSize;
@property (assign)   float                 indent;
@property (assign)   float                 lineSpacing;
@property (readonly) OMSize                extents;
@property (readonly) float                 extentWidth;
@property (readonly) float                 extentHeight;
@property (readonly) float                 baseLine;
@property (readonly) int                   lineCount;
@property (readonly) BOOL                  isWrapped;
//----------------------------------------------------------------------------------------------------------------------------------
+ layoutWithSurface:(OMSurface *)Surface;
+ layoutWithSurface:(OMSurface *)Surface Text:(OFString *)Text;
+ layoutWithSurface:(OMSurface *)Surface Text:(OFString *)Text Font:(OMFont *)Font;
+ layoutWithSurface:(OMSurface *)Surface Text:(OFString *)Text Font:(OMFont *)Font WrapSize:(OMSize)WrapSize;
+ layoutWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup;
+ layoutWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup Accelerator:(OFString *)Accelerator;
+ layoutWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup WrapSize:(OMSize)WrapSize;
+ layoutWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup Accelerator:(OFString *)Accelerator WrapSize:(OMSize)WrapSize;
- initWithSurface:(OMSurface *)Surface;
- initWithSurface:(OMSurface *)Surface Text:(OFString *)Text;
- initWithSurface:(OMSurface *)Surface Text:(OFString *)Text Font:(OMFont *)Font;
- initWithSurface:(OMSurface *)Surface Text:(OFString *)Text Font:(OMFont *)Font WrapSize:(OMSize)WrapSize;
- initWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup;
- initWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup Accelerator:(OFString *)Accelerator;
- initWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup WrapSize:(OMSize)WrapSize;
- initWithSurface:(OMSurface *)Surface Markup:(OFString *)Markup Accelerator:(OFString *)Accelerator WrapSize:(OMSize)WrapSize;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)setTextAsMarkup:(OFString *)Markup;
- (void)setTextAsMarkup:(OFString *)Markup Accelerator:(OFString *)Accelerator;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)pathToSurface:(OMSurface *)Surface;
- (void)pathToSurface:(OMSurface *)Surface X:(float)X Y:(float)Y;
- (void)pathToSurface:(OMSurface *)Surface Coordinate:(OMCoordinate)Coordinate;
- (void)pathToSurface:(OMSurface *)Surface Rectangle:(OMRectangle)Rectangle;
- (void)pathToSurface:(OMSurface *)Surface Dimension:(OMDimension)Dimension;
//----------------------------------------------------------------------------------------------------------------------------------
@end
//==================================================================================================================================
