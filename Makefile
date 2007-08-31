CC=arm-apple-darwin-cc
LD=$(CC)
LDFLAGS=-lobjc -framework CoreFoundation -framework Foundation -framework UIKit -framework LayerKit

all:	Preview package

Preview:	source/main.o source/MobilePreview.o source/MobileStudio/MSAppLauncher.o
	$(LD) $(LDFLAGS) -o $@ $^

%.o:	%.m
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

%.o:	%.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

%.o:	%.cpp
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

package:
	rm -rf build
	mkdir build
	cp -r ./source/Preview.app ./build
	mv Preview ./build/Preview.app

clean:
	rm -f source/*.o Preview
	rm -f source/MobileStudio/*.o
	rm -rf ./build