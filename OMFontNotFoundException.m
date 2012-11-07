//==================================================================================================================================
// OMFontNotFoundException.m
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
#import "OMFontNotFoundException.h"
//==================================================================================================================================
@implementation OMFontNotFoundException
//----------------------------------------------------------------------------------------------------------------------------------
+ exceptionWithClass:(Class)exClass fontName:(OFString *)fontName
{
  return [[[self alloc] initWithClass:exClass fontName:fontName] autorelease];
}
//----------------------------------------------------------------------------------------------------------------------------------
- initWithClass:(Class)exClass fontName:(OFString *)fontName
{
  self = [super initWithClass: exClass];
  _fontName = [fontName copy];
  return self;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (OFString *)fontName
{
  return _fontName;
}
//----------------------------------------------------------------------------------------------------------------------------------
- (OFString *)description
{
  if(description != nil) return description;
  return @"Font Family Not Found";
}
//----------------------------------------------------------------------------------------------------------------------------------
@end
//==================================================================================================================================
