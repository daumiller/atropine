//==================================================================================================================================
// OMRectangle.h
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
