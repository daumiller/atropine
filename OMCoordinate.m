//==================================================================================================================================
// OMCoordinate.m
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
