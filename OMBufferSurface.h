//==================================================================================================================================
// OMBufferSurface.h
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
