//
//  AmazingNumbersAppDelegate.m
//  AmazingNumbers
//
//  Created by Steven Hirsch on 5/20/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//
#import <sqlite3.h>
#import "AmazingNumbersAppDelegate.h"
#import "AmazingNumbersViewController.h"
#import "ModalViewController.h"

@implementation AmazingNumbersAppDelegate

@synthesize window, navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application { 
	
	UIImage* backImage = [UIImage imageNamed:@"Default.png"];
	UIView* backView = [[UIImageView alloc] initWithImage:backImage];
	backView.frame = window.bounds;
	[window addSubview:backView];
	[UIView beginAnimations:@"CWFadeIn" context:(void*)backView];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:
	 @selector(animationDidStop:finished:context:)];
	[UIView setAnimationDuration:0.5f];
	backView.alpha = 0;
	[UIView commitAnimations];

    // Override point for customization after application launch
	AmazingNumbersViewController *amazingNumbersViewController = [ [ AmazingNumbersViewController alloc ] init ];
	navigationController = [ [ UINavigationController alloc ] initWithRootViewController:amazingNumbersViewController];
	
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque; 
	window.backgroundColor = [UIColor blackColor];
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

-(void)animationDidStop:(NSString*)animationID finished:(NSNumber*)finished
context:(void*)context
{
	UIView* backView = (UIView*)context;
	[backView removeFromSuperview];
	[backView release];
}

- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
