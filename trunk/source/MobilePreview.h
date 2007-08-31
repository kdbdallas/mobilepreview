/*
	MobilePreview.h
	
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

#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIWindow.h>
#import <UIKit/UIView.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIImageView.h>
#import <GraphicsServices/GraphicsServices.h>

@interface MobilePreview : UIApplication 
{
	NSString* _applicationID;
	NSString* _finderApplicationID;
	UIWindow* _window;
	UIView* _mainView;
	UINavigationBar* _navBar;
	UIImageView* _imageView;		
}

//- (void)deviceOrientationChanged:(GSEvent *)event;

@end