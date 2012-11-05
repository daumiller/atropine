//==================================================================================================================================
#define UNICODE
#define WINVER       0x0601 /*WIN7*/
#define _WIN32_WINNT 0x0601 /*WIN7*/
//----------------------------------------------------------------------------------------------------------------------------------
#include <windows.h>
#import "atropine.h"
//==================================================================================================================================
void _WinInit();
void _WinCreate();
void _WinLoop();
LRESULT CALLBACK _WinProc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam);
void _WinPaint(HWND hwnd);
void BufferInit();
//==================================================================================================================================
OMBufferSurface *buff;
//==================================================================================================================================
int main(int argc, char **argv)
{
  @autoreleasepool
  {
    _WinInit();
    _WinCreate();
    BufferInit();
    _WinLoop();
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
void _WinInit()
{
  //register a single, default, window class
  WNDCLASSEX wcx;
  wchar_t *clsName  = L"atropineClass";
  HINSTANCE hInst   = (HINSTANCE)GetModuleHandle(NULL);
  wcx.cbSize        = sizeof(wcx);
  wcx.style         = CS_VREDRAW | CS_HREDRAW;
  wcx.lpfnWndProc   = (WNDPROC)_WinProc;
  wcx.cbClsExtra    = 0;
  wcx.cbWndExtra    = 0;
  wcx.hInstance     = hInst;
  wcx.hIcon         = LoadIcon(NULL, IDI_APPLICATION);
  wcx.hCursor       = LoadCursor(NULL, IDC_ARROW);
  wcx.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);
  wcx.lpszMenuName  = NULL;
  wcx.lpszClassName = clsName;
  wcx.hIconSm       = NULL;
  RegisterClassEx(&wcx);
}
//----------------------------------------------------------------------------------------------------------------------------------
void _WinCreate()
{
  HINSTANCE hInst = (HINSTANCE)GetModuleHandle(NULL);
  HWND hwnd = CreateWindowEx(WS_EX_LEFT, L"atropineClass", L"atropine Test", WS_OVERLAPPEDWINDOW,
                             CW_USEDEFAULT, CW_USEDEFAULT, 640, 480, NULL, NULL, hInst, NULL);
  ShowWindow(hwnd, SW_SHOWNORMAL);
  InvalidateRect(hwnd, NULL, TRUE);
}
//----------------------------------------------------------------------------------------------------------------------------------
void _WinLoop()
{
  MSG msg; int msgCode;
  while((msgCode = GetMessage(&msg, NULL, 0, 0)) != 0)
  {
    if(msgCode == -1) return;
    else
    {
      TranslateMessage(&msg);
      DispatchMessage(&msg);
    }
  }
}
//----------------------------------------------------------------------------------------------------------------------------------
LRESULT CALLBACK _WinProc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
  PAINTSTRUCT ps;
  int width, height;
  
  switch(msg)
  {
    case WM_CLOSE:
      DestroyWindow(hwnd);
      return 0;
    
    case WM_DESTROY:
      PostQuitMessage(0);
      return 0;
    
    case WM_ERASEBKGND:
      return FALSE;
    
    case WM_PAINT:
      BeginPaint(hwnd, &ps);
      width  = ps.rcPaint.right  - ps.rcPaint.left;
      height = ps.rcPaint.bottom - ps.rcPaint.top;
      EndPaint(hwnd, &ps);
      if((width > 0) || (height > 0))
        _WinPaint(hwnd);
      return 0;
  }
  
  return DefWindowProc(hwnd, msg, wparam, lparam);
}
//==================================================================================================================================
void _WinPaint(HWND hwnd)
{
  @autoreleasepool
  {
    //blit buffer
    OMNativeSurface *winSurf = [OMNativeSurface nativeSurfaceWithData:hwnd];
    [buff copyToSurface:winSurf DestinationX:0.0f DestinationY:0.0f];
  }
}
//==================================================================================================================================
