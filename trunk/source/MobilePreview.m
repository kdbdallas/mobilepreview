/*
	MobilePreview.m
	
	MobileStudio image viewer
	
	Copyright 2007 Dallas Brown, Matt Stoker
	
	Thanks: iPhone Dev Team for Compilation Toolchain
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; version 2
	of the License.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/

#import <UIKit/UIHardware.h>
#import <UIKit/UIView-Hierarchy.h>
#import <UIKit/UIView-Geometry.h>
#import <UIKit/UINavigationBar.h>
#import "MobilePreview.h"
#import "MobileStudio/MSAppLauncher.h"

@implementation MobilePreview

- (void) applicationDidFinishLaunching: (id) unused
{	
	//Set application id
	_applicationID = [[NSString alloc] initWithString: @"com.google.code.MobilePreview"];
	_finderApplicationID = [[NSString alloc] initWithString: @"com.googlecode.MobileFinder"];
	
	//Initialize window
	_window = [[UIWindow alloc] initWithContentRect: [UIHardware fullScreenApplicationContentRect]];
    [_window orderFront: self];
    [_window makeKey: self];
    [_window _setHidden: NO];
	
	//Define UI control positions
	struct CGRect mainViewRect = [UIHardware fullScreenApplicationContentRect];
    mainViewRect.origin.x = 0.0f;
	mainViewRect.origin.y = 0.0f;
    CGRect navBarRect = [UIHardware fullScreenApplicationContentRect];
	navBarRect.origin.x = 0.0f;
	navBarRect.origin.y = 0.0f;
	navBarRect.size.height = 46.0f;
	CGRect imageViewRect = [UIHardware fullScreenApplicationContentRect];
	imageViewRect.origin.x = 0.0f;
	imageViewRect.origin.y = navBarRect.size.height;
	imageViewRect.size.height = mainViewRect.size.height - navBarRect.size.height;

	//Setup main view
    _mainView = [[UIView alloc] initWithFrame: mainViewRect];
	[_mainView setOpaque: TRUE];
    [_window setContentView: _mainView];	
	
	//Setup navigation var
	_navBar = [[UINavigationBar alloc] initWithFrame: navBarRect];
	[_navBar showButtonsWithLeftTitle: @"Open" rightTitle: @"" leftBack: NO];
    [_navBar setBarStyle: 3];
	[_navBar setDelegate: self];
	[_mainView addSubview: _navBar];
	
	//Setup image viewer
	_imageView = [[UIImageView alloc] initWithImage: nil];
	[_imageView setFrame: imageViewRect];
	[_mainView addSubview: _imageView];
	
	//Read image path from arguments
	NSString* imagePath = [MSAppLauncher readLaunchInfoArgumentForAppID: _applicationID
		withApplication: self
		deletingLaunchPList: TRUE];
	
	//Load the image and display it in the image viewer
	if (imagePath != nil)
	{
		UIImage* image = [UIImage imageAtPath: imagePath];
		if (image != nil)
		{
			[image setOrientation: 0];
			//Recreate the image view, loading the image, and store its size
			[_imageView removeFromSuperview];
			[_imageView release];
			_imageView = [[UIImageView alloc] initWithImage: image];
			CGRect imageRect = [_imageView frame];
			
			//Create viewing rectangle for image that centers the image, and contracts it if needed
			if (imageRect.size.width > imageViewRect.size.width || imageRect.size.height > imageViewRect.size.height)
			{
				float imageAspect = imageRect.size.width / imageRect.size.height;
				
				imageRect.size.height = imageViewRect.size.height;
				imageRect.size.width = imageRect.size.height * imageAspect;
				if (imageRect.size.width > imageViewRect.size.width)
				{
					imageRect.size.width = imageViewRect.size.width;
					imageRect.size.height = imageRect.size.width / imageAspect;					
				}
			}
			imageRect.origin.x = imageViewRect.origin.x + 
				imageViewRect.size.width * 0.5f - imageRect.size.width * 0.5f;
			imageRect.origin.y = imageViewRect.origin.y + 
				imageViewRect.size.height * 0.5f - imageRect.size.height * 0.5f;
			
			//Set the image viewing frame
			[_imageView setFrame: imageRect];
			[_mainView addSubview: _imageView];			
		}
	}
}

- (void) applicationWillSuspend
{
	[_applicationID release];
	[_finderApplicationID release];
	[_window release];
	[_mainView release];
	[_navBar release];
	[_imageView release];
}

- (void) navigationBar: (UINavigationBar*)navbar buttonClicked: (int)button  
{
	switch (button) 
	{
		case 0:	//Right Button
			break;

		case 1:	//Left Button
			[MSAppLauncher launchApplication: _finderApplicationID
				withLaunchingAppID: _applicationID
				withApplication: self];
			NSLog(@"Button pressed!");
			break;
	}
}

/*
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector 
{
	NSLog(@"Requested method for selector: %@", NSStringFromSelector(selector));
	return [super methodSignatureForSelector:selector];
}

- (BOOL)respondsToSelector:(SEL)aSelector 
{
	NSLog(@"Request for selector: %@", NSStringFromSelector(aSelector));
	return [super respondsToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation 
{
	NSLog(@"Called from: %@", NSStringFromSelector([anInvocation selector]));
	[super forwardInvocation:anInvocation];
}
*/
/*
- (void)deviceOrientationChanged:(GSEvent *)event {
	textView = [[UITextView alloc] initWithFrame: CGRectMake(0.0f, 40.0f, 320.0f, 245.0f - 40.0f)];
	[_mainView addSubview:textView];
	
	[textView setText: test];
}
*/

@end