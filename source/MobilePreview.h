#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIWindow.h>
#import <UIKit/UIView-Hierarchy.h>
#import <UIKit/UIHardware.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIView.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIImageView.h>
#import <GraphicsServices/GraphicsServices.h>
#import <UIKit/UITextView.h>

@interface MobilePreview : UIApplication {
        UIWindow *_window;
		UIView *_mainView;
		UINavigationBar *_navBar;
		UIImage *_imageView;
		NSString *path;
		UITextView  *textView;
}

//- (void)deviceOrientationChanged:(GSEvent *)event;

@end