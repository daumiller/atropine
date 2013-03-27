//==================================================================================================================================
// OMRectangle.m
//==================================================================================================================================
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
