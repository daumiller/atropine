//==================================================================================================================================
// OMFontNotFoundException.h
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
#import <ObjFW/ObjFW.h>
//==================================================================================================================================
@interface OMFontNotFoundException : OFException
{
  @protected OFString *fontName;
}
//----------------------------------------------------------------------------------------------------------------------------------
+ exceptionWithClass:(Class)class_ fontName:(OFString *)fontName_;
- initWithClass:(Class)class_ fontName:(OFString *)fontName_;
//----------------------------------------------------------------------------------------------------------------------------------
- (OFString *)fontName;
//----------------------------------------------------------------------------------------------------------------------------------
@end
//==================================================================================================================================
