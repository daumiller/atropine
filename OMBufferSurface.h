//==================================================================================================================================
// OMBufferSurface.h
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
