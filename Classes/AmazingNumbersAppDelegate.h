//
//  AmazingNumbersAppDelegate.h
//  AmazingNumbers
//
//  Created by Steven Hirsch on 5/20/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmazingNumbersViewController.h"

@interface AmazingNumbersAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigationController;
	//UIImageView *backgroundImage;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
//@property (nonatomic, retain) UIImageView *backgroundImage;


@end

