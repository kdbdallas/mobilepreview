#import "MobilePreview.h"

@implementation MobilePreview

- (void) navigationBar: (UINavigationBar*)navbar buttonClicked: (int)button 
{
	switch (button) 
	{
		case 0:
			//
		break;

		case 1:	//Open
			[self launchApplicationWithIdentifier:@"com.googlecode.MobileFinder" suspended:NO];
		break;
	}
}

- (void) applicationDidFinishLaunching: (id) unused
{	
	//Initialize window
	_window = [[UIWindow alloc] initWithContentRect: [UIHardware fullScreenApplicationContentRect]];
    [_window orderFront: self];
    [_window makeKey: self];
    [_window _setHidden: NO];

	//Setup main view
    struct CGRect rect = [UIHardware fullScreenApplicationContentRect];
    rect.origin.x = rect.origin.y = 0.0f;
    _mainView = [[UIView alloc] initWithFrame: rect];
    [_window setContentView: _mainView];

	//Setup navigation var
	_navBar = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
	[_navBar showButtonsWithLeftTitle: @"NothingYet" rightTitle: @"Open" leftBack: NO];
    [_navBar setBarStyle: 5];
	[_navBar setDelegate: self];

	[_mainView addSubview: _navBar];

	NSArray *myArgs = [[NSProcessInfo processInfo] arguments];

	if ([myArgs count] > 1)
	{
  		path = [myArgs objectAtIndex: 1];

		_imageView = [UIImage imageAtPath: path];

		UIImageView *imgSubView = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 40.0f, 320.0f, 445.0f - 40.0f)];
		
		[imgSubView setImage: _imageView];

		[_mainView addSubview: imgSubView];
	}
	else
	{
		//
	}
}

- (void) applicationWillSuspend
{
   //
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {
 NSLog(@"Requested method for selector: %@", NSStringFromSelector(selector));
 return [super methodSignatureForSelector:selector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
NSLog(@"Request for selector: %@", NSStringFromSelector(aSelector));
return [super respondsToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
 NSLog(@"Called from: %@", NSStringFromSelector([anInvocation selector]));
[super forwardInvocation:anInvocation];
}

/*- (void)deviceOrientationChanged:(GSEvent *)event {
	textView = [[UITextView alloc] initWithFrame: CGRectMake(0.0f, 40.0f, 320.0f, 245.0f - 40.0f)];
	[_mainView addSubview:textView];
	
	[textView setText: test];
}*/

@end