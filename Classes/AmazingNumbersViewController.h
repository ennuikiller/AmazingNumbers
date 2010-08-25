//
//  AmazingNumbersViewController.h
//  AmazingNumbers
//
//  Created by Steven Hirsch on 5/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#define kRandomizeNumbers		@"randomizeNumbers"
#define kNumbersToDisplay		@"numbersToDisplay"
#define kRandomizeFacts			@"randomizeFacts"

#import <UIKit/UIKit.h>

#import "PreferencesViewController.h"

//#import "ModalViewController.h"

#define kNumberComponent 0
#define kFactComponent	1

//@class PreferencesViewController;
@class ModalViewController;

@interface AmazingNumbersViewController : UIViewController <UINavigationBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, PreferencesViewControllerDelegate> {
	BOOL frontViewIsVisible, randomFacts;
	UIPickerView *numberFactsPicker;
	NSDictionary *numberFacts;
	NSArray  *sortedNumbers;
	NSMutableArray *oldViews, *facts, *numbers;
	UIWebView *displayText;
	UIView *selectedView;
	UIView *oldView;
	UIView *mainView;
	UIView *preferencesView;
	NSNull *nullValue;
	NSString *explain;
	ModalViewController *whyModalViewController;
	PreferencesViewController *preferencesViewController;
	UINavigationController *navigationController;
}

@property (assign) BOOL frontViewIsVisible;
@property (assign) BOOL randomFacts;

@property (nonatomic, retain) UIPickerView *numberFactsPicker;
@property (nonatomic, retain) NSDictionary *numberFacts;
@property (nonatomic, retain) NSMutableArray *numbers;
@property (nonatomic, retain) NSArray *sortedNumbers;
@property (nonatomic, retain) NSMutableArray *facts; 
//@property (nonatomic, retain) IBOutlet UIWebView *displayText;
@property (nonatomic, retain) IBOutlet UIWebView *displayText;
@property (nonatomic, retain) UIView *selectedView;
@property (nonatomic, retain) UIView *oldView;
@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, retain) UIView *preferencesView;
@property (nonatomic, retain) NSMutableArray *oldViews;
@property (nonatomic, retain) NSNull *nullValue;
@property (nonatomic, retain) IBOutlet ModalViewController *whyModalViewController;
@property (nonatomic, retain) IBOutlet PreferencesViewController *preferencesViewController;
@property (nonatomic, retain) NSString *explain;
@property (nonatomic, retain) UINavigationController *navigationController;

-(void)populateDisplayTextWith:(NSString *)textToDisplay;
-(void)setColorOnView:(UIView *)view forComponent:(NSInteger)componrnt withColor:(UIColor *)color;
-(void)setBarButtonWithText:(NSString *)text;

-(void)setPreferences;


@end
