//==================================================================================================================================
#import <Cocoa/Cocoa.h>
#import "atropine.h"
#include <stdio.h>
//==================================================================================================================================
void _MacInit();
void  _MacCreate();
void _MacLoop();
void _MacPaint(NSView *view);
void BufferInit();
//==================================================================================================================================
@interface atropineView : NSView
@end
@implementation atropineView
- (void) drawRect:(NSRect)frame { _MacPaint(self); }
@end
//----------------------------------------------------------------------------------------------------------------------------------
@interface atropineDelegate : NSObject <NSWindowDelegate>
@end
@implementation atropineDelegate
- (void) windowWillClose:(NSNotification *)notification { [NSApp terminate:self]; }
@end
//----------------------------------------------------------------------------------------------------------------------------------
@interface NSApplication (NeedAppleMenu)
- (void) setAppleMenu:(NSMenu *)aMenu;
@end
//==================================================================================================================================
OMBufferSurface *buff;
//==================================================================================================================================
int main(int argc, char **argv)
{
  @autoreleasepool
  {
    _MacInit();
    BufferInit();
    _MacCreate();
  }
}
//==================================================================================================================================
void roundedRectangle(OMSurface *surface, OMDimension dimension, float radius)
{
  float x = dimension.origin.x;
  float y = dimension.origin.y;
  float w = dimension.size.width;
  float h = dimension.size.height;
  
  [surface newSubPath];
  
  [surface arcCenterX: x + w - radius
              CenterY: y + radius
               Radius: radius
          DegreeStart: -90.0f
            DegreeEnd:   0.0f];
  
  [surface arcCenterX: x + w - radius
              CenterY: y + h - radius
               Radius: radius
          DegreeStart:   0.0f
            DegreeEnd:  90.0f];
  
  [surface arcCenterX: x + radius
              CenterY: y + h - radius
               Radius: radius
          DegreeStart:  90.0f
            DegreeEnd: 180.0f];
  
  [surface arcCenterX: x + radius
              CenterY: y + radius
               Radius: radius
          DegreeStart: 180.0f
            DegreeEnd: 270.0f];
  
  [surface closePath];
}
//----------------------------------------------------------------------------------------------------------------------------------
void BufferInit()
{
  //init
  @autoreleasepool
  {
    //create buffer
    buff = [[OMBufferSurface alloc] initWithWidth:32 Height:32]; //hang on to this guy for the life of our program (not autorelease)
    [buff resizeWidth:640 Height:480];
    
    //create some colors
    OMColor black = OMMakeColorRGBA(0.0f, 0.0f, 0.0f, 1.0f);
    OMColor white = OMMakeColorRGBA(1.0f, 1.0f, 1.0f, 1.0f);
    OMColor blue  = OMMakeColorRGBA(0.0f, 0.0f, 1.0f, 1.0f);
    
    //clear-to-color
    [buff setColor:white];
    [buff paint];
    
    //add rounded-rectangle path
    roundedRectangle(buff, OMMakeDimension(OMMakeCoordinate(32.0f, 32.0f), OMMakeSize(256.0f, 256.0f)), 16.0f);
    
    //fill rounded-rectangle path
    [buff setColor:blue];
    [buff fillPreserve];
    
    //stroke rounded-rectangle path
    buff.lineWidth = 5.0f;
    [buff setColor:black];
    [buff stroke];
    
    //create a text layout
    OMFont *font = [OMFont fontWithFamily:@"MMCedar"];
    font.weight  = OMFONT_WEIGHT_BOLD;
    font.size    = 20.0f;
    
    //create text layout, create path on surface
    OMTextLayout *layout = [OMTextLayout layoutWithSurface:buff Text:@"Hello アトロピン!" Font:font];
    [layout pathToSurface:buff X:96.0f Y:164.0f];
    
    //stroke/fill text layout path
    [buff setColor:black];
    [buff strokePreserve];
    [buff setColor:OMMakeColorRGB(0.2f, 1.0f, 0.4f)];
    [buff fill];
    
    //test writing support
    //[buff writeToPNG:@"buffTest.png"]; <-- this doesn't like to work while inside a bundle / launched from GUI
  }
}
//==================================================================================================================================
void _MacInit()
{
  [NSApplication sharedApplication];
  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
}
//----------------------------------------------------------------------------------------------------------------------------------
void _MacCreate()
{
  NSWindow         *wnd;
  atropineView     *vew;
  atropineDelegate *del;
  NSMenu           *mnu;
  NSMenuItem       *itm;
  NSRect            rec;
  
  //menu
  //some of these NS* UI Items won't accept OFStrings as replacements for NSStrings
  //so we have to explicitly create them as NSStrings (without @"literals")
  NSString *str0 = [NSString stringWithUTF8String:""              ];
  NSString *str1 = [NSString stringWithUTF8String:"Quit OS X Test"];
  NSString *str2 = [NSString stringWithUTF8String:"q"             ];
  NSString *str3 = [NSString stringWithUTF8String:"Apple"         ];
  NSString *str4 = [NSString stringWithUTF8String:"atropine Test" ];
  
  [NSApp setMainMenu:[[NSMenu alloc] init]];
  mnu = [[NSMenu alloc] initWithTitle:str0];
  [mnu addItemWithTitle:str1 action:@selector(terminate:) keyEquivalent:str2];
  itm = [[NSMenuItem alloc] initWithTitle:str3 action:nil keyEquivalent:str0];
  [itm setSubmenu:mnu];
  [[NSApp mainMenu] addItem:itm];
  [NSApp setAppleMenu:mnu];
  
  //window
  rec = NSMakeRect(32.0f, 32.0f, 640.0f, 480.0f);
  wnd = [[NSWindow alloc] initWithContentRect:rec
                                    styleMask:NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask
                                      backing:NSBackingStoreBuffered
                                        defer:NO];
  [wnd setTitle:str4];
  
  vew = [[atropineView     alloc] initWithFrame:rec];
  del = [[atropineDelegate alloc] init             ];
  
  [wnd setContentView:vew];
  [wnd setDelegate   :del];
  [wnd makeKeyAndOrderFront:wnd];
  [NSApp activateIgnoringOtherApps:YES];
  [vew setNeedsDisplay:YES]; //need an initial redraw here (for whatever reason???)
  [NSApp run];
}
//----------------------------------------------------------------------------------------------------------------------------------
void _MacLoop()
{
  return;
}
//==================================================================================================================================
void _MacPaint(NSView *view)
{
  @autoreleasepool
  {
    //blit buffer
    OMNativeSurface   *macSurf = [[OMNativeSurface alloc] initWithData:(void *)view];
    [buff copyToSurface:macSurf DestinationX:0.0f DestinationY:0.0f];
  }
}
//==================================================================================================================================
