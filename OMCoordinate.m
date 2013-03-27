//==================================================================================================================================
// OMCoordinate.m
//==================================================================================================================================
#import "OMCoordinate.h"
//==================================================================================================================================
OMCoordinate OMMakeCoordinate(float x, float y)
{
  OMCoordinate coordinate;
  coordinate.x = x;
  coordinate.y = y;
  return coordinate;
}
//----------------------------------------------------------------------------------------------------------------------------------
OMSize OMMakeSize(float width, float height)
{
  OMSize size;
  size.width  = width;
  size.height = height;
  return size;
}
//==================================================================================================================================
void OMOffsetCoordinate(OMCoordinate *coordinate, float x, float y)
{
  coordinate->x += x;
  coordinate->y += y;
}
//----------------------------------------------------------------------------------------------------------------------------------
void OMGrowSize(OMSize *size, float width, float height)
{
  size->width  += width;
  size->height += height;
}
//==================================================================================================================================
