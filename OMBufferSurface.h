//==================================================================================================================================
// OMBufferSurface.h
//==================================================================================================================================
#import "OMSurface.h"
#import "OMCoordinate.h"
#import "OMRectangle.h"
#import "OMColor.h"
//==================================================================================================================================
@interface OMBufferSurface : OMSurface <OFCopying>
//----------------------------------------------------------------------------------------------------------------------------------
+ bufferSurfaceWithSize:(OMSize)Size;
+ bufferSurfaceWithWidth:(int)Width Height:(int)Height;
+ bufferSurfaceWithPNG:(OFString *)Filename;
- copy;
- initWithWidth:(int)Width Height:(int)Height;
- initWithSize:(OMSize)Size;
- initWithPNG:(OFString *)Filename;
- (void)bufferRelease;
//----------------------------------------------------------------------------------------------------------------------------------
@property (readonly) unsigned char *rawData;
@property (readonly) int            rawStride;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)resize:(OMSize)Size;
- (void)resizeWidth:(int)Width Height:(int)Height;
- (void)resizePreserve:(OMSize)Size;
- (void)resizePreserveWidth:(int)Width Height:(int)Height;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)copyToSurface:(OMSurface *)surface DestinationX:(float)X DestinationY:(float)Y;
- (void)copyToSurface:(OMSurface *)surface DestinationCoordinate:(OMCoordinate)Coordinate;
- (void)copyToSurface:(OMSurface *)surface DestinationCoordinate:(OMCoordinate)Coordinate SourceRectangle:(OMRectangle)Rectangle;
- (void)copyToSurface:(OMSurface *)surface DestinationCoordinate:(OMCoordinate)Coordinate SourceDimension:(OMDimension)Dimension;
//----------------------------------------------------------------------------------------------------------------------------------
- (void)writeToPNG:(OFString *)Filename;
//----------------------------------------------------------------------------------------------------------------------------------
@end
//==================================================================================================================================
