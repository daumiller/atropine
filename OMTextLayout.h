//==================================================================================================================================
// OMTextLayout.h
//==================================================================================================================================
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
