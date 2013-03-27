//==================================================================================================================================
// OMRectangle.h
//==================================================================================================================================
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
