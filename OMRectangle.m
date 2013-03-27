//==================================================================================================================================
// OMRectangle.m
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
#import "OMRectangle.h"
//==================================================================================================================================
OMRectangle OMMakeRectangle(OMCoordinate topLeft, OMCoordinate bottomRight)
{
  OMRectangle rectangle;
  rectangle.topLeft     = topLeft;
  rectangle.bottomRight = bottomRight;
  return rectangle;
}
//----------------------------------------------------------------------------------------------------------------------------------
OMDimension OMMakeDimension(OMCoordinate origin, OMSize size)
{
  OMDimension dimension;
  dimension.origin = origin;
  dimension.size   = size;
  return dimension;
}
//==================================================================================================================================
OMRectangle OMMakeRectangleFloats(float left, float top, float right, float bottom)
{
  OMRectangle rectangle;
  rectangle.topLeft.x     = left;
  rectangle.topLeft.y     = top;
  rectangle.bottomRight.x = right;
  rectangle.bottomRight.y = bottom;
  return rectangle;
}
//----------------------------------------------------------------------------------------------------------------------------------
OMDimension OMMakeDimensionFloats(float x, float y, float width, float height)
{
  OMDimension dimension;
  dimension.origin.x    = x;
  dimension.origin.y    = y;
  dimension.size.width  = width;
  dimension.size.height = height;;
  return dimension;
}
//==================================================================================================================================
OMRectangle OMRectangleFromDimension(OMDimension dimension)
{
  OMRectangle rectangle;
  rectangle.topLeft.x     = dimension.origin.x;
  rectangle.topLeft.y     = dimension.origin.y;
  rectangle.bottomRight.x = dimension.origin.x + dimension.size.width;
  rectangle.bottomRight.y = dimension.origin.y + dimension.size.height;
  return rectangle;
}
//----------------------------------------------------------------------------------------------------------------------------------
OMDimension OMDimensionFromRectangle(OMRectangle rectangle)
{
  OMDimension dimension;
  dimension.origin.x    = rectangle.topLeft.x;
  dimension.origin.y    = rectangle.topLeft.y;
  dimension.size.width  = rectangle.bottomRight.x - rectangle.topLeft.x;
  dimension.size.height = rectangle.bottomRight.y - rectangle.topLeft.y;
  return dimension;
}
//==================================================================================================================================
void OMRectangleToDimension(OMRectangle *rectangle)
{
  //after this call, you can directly cast your OMRectangle to a OMDimension
  rectangle->bottomRight.x -= rectangle->topLeft.x;
  rectangle->bottomRight.y -= rectangle->topLeft.y;
}
//----------------------------------------------------------------------------------------------------------------------------------
void OMDimensionToRectangle(OMDimension *dimension)
{
  //after this call, you can directly cast your OMDimension to a OMRectangle
  dimension->size.width  += dimension->origin.x;
  dimension->size.height += dimension->origin.y;
}
//==================================================================================================================================
