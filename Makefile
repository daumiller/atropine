linux   : lin
win32   : win
windows : win
mac     : osx
macosx  : osx

lin : libatropine.so
win : atropine.dll
osx : libatropine.dylib

libatropine.so : objects
	clang -shared *.o -o libatropine.so `objfw-config --libs` `pkg-config --libs gdk-3.0 pango`

atropine.dll : objects
	clang -shared *.o -o atropine.dll `objfw-config --libs` `pkg-config --libs gdk-3.0 pango`

libatropine.dylib : objects
	clang -dynamiclib *.o -o libatropine.dylib `objfw-config --libs` /STATIC-LIB-PATH/cairo/_bin/lib/*.a /STATIC-LIB-PATH/pango/1.6.0/modules/pango-basic-coretext.a -L/usr/X11/lib -lz -lfreetype -framework Cocoa -liconv -lffi

objects : OMColor.o OMCoordinate.o OMRectangle.o OMFont.o OMFontNotFoundException.o OMTextLayout.o OMSurface.o OMBufferSurface.o OMNativeSurface.o

%.o : %.m
	clang -c $^ -o $@ `objfw-config --cppflags --objcflags` `pkg-config --cflags gdk-3.0 pango` -fPIC

clean :
	rm -f *.o
	rm -f *.a
	rm -f *.so
	rm -f *.dll
	rm -f *.dylib
