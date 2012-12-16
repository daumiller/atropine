//==================================================================================================================================
#include <gtk/gtk.h>
#import "atropine.h"
//==================================================================================================================================
void _LinInit();
void _LinCreate();
void _LinLoop();
void _LinPaint(GtkWidget *widget);
void BufferInit();
//==================================================================================================================================
void atropineDraw(GtkWidget *widget, cairo_t *cr, gpointer data)
{
  _LinPaint(widget);
}
//----------------------------------------------------------------------------------------------------------------------------------
void atropineDestroy(GtkWidget *widget, gpointer data)
{
  gtk_main_quit();
}
//==================================================================================================================================
OMBufferSurface *buff;
//==================================================================================================================================
int main(int argc, char **argv)
{
  _LinInit();
  _LinCreate();
  BufferInit();
  _LinLoop();
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
    OMFont *font = [OMFont fontWithFamily:@"segoe ui"];
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
    [buff writeToPNG:@"buffTest.png"];
  }
}
//==================================================================================================================================
void _LinInit()
{
  gtk_init(NULL, NULL);
}
//----------------------------------------------------------------------------------------------------------------------------------
void _LinCreate()
{
  GtkWindow *window;
  GtkWidget *drawer;
  
  window = (GtkWindow *)gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_decorated(window, TRUE);
  gtk_widget_show((GtkWidget *)window);
  gtk_window_set_title(window, "atropine test");
  gtk_window_resize(window, 640, 480);
  gtk_window_set_position(window, GTK_WIN_POS_CENTER);
  g_signal_connect(window, "destroy", G_CALLBACK(atropineDestroy), NULL);
  
  drawer = gtk_drawing_area_new();
  g_signal_connect(drawer, "draw", G_CALLBACK(atropineExpose), NULL);
  gtk_container_add((GtkContainer *)window, drawer);
  gtk_widget_show(drawer);
}
//----------------------------------------------------------------------------------------------------------------------------------
void _LinLoop()
{
  gtk_main();
}
//==================================================================================================================================
void _LinPaint(GtkWidget *widget)
{
  @autoreleasepool
  {
    OMNativeSurface   *linSurf = [OMNativeSurface nativeSurfaceWithData:(void *)widget];
    
    //blit buffer
    [buff copyToSurface:linSurf DestinationX:0.0f DestinationY:0.0f];
  }
}
//==================================================================================================================================
