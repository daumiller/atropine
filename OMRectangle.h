//==================================================================================================================================
// OMRectangle.h
/*==================================================================================================================================
Copyright � 2013, Dillon Aumiller <dillonaumiller@gmail.com>
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
#import "OMCoordinate.h"
//==================================================================================================================================
typedef struct
{
  OMCoordinate topLeft;
  OMCoordinate bottomRight;
} OMRectangle;
//----------------------------------------------------------------------------------------------------------------------------------
typedef struct
{
  OMCoordinate origin;
  OMSize       size;
} OMDimension;
//==================================================================================================================================
OMRectangle OMMakeRectangle(OMCoordinate topLeft, OMCoordinate bottomRight);
OMDimension OMMakeDimension(OMCoordinate origin , OMSize       size       );
//----------------------------------------------------------------------------------------------------------------------------------
OMRectangle OMMakeRectangleFloats(float left, float top, float right, float bottom);
OMDimension OMMakeDimensionFloats(float x   , float y  , float width, float height);
//----------------------------------------------------------------------------------------------------------------------------------
OMRectangle OMRectangleFromDimension(OMDimension dimension);
OMDimension OMDimensionFromRectangle(OMRectangle rectangle);
//----------------------------------------------------------------------------------------------------------------------------------
void        OMRectangleToDimension(OMRectangle *rectangle);
void        OMDimensionToRectangle(OMDimension *dimension);
//==================================================================================================================================
