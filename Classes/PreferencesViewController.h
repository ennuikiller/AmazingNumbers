//
//  PreferencesViewController.h
//  AmazingNumbers
//
//  Created by Steven Hirsch on 6/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRandomizeNumbers		@"randomizeNumbers"
#define kNumbersToDisplay		@"numbersToDisplay"
#define kRandomizeFacts			@"randomizeFacts"

@protocol PreferencesViewControllerDelegate;


@interface PreferencesViewController : UITableViewController {
	UISlider *numbersSlider;
	UILabel *numbersLabel;
	UILabel *numberToDisplay;
	UISlider *gameVolumeControl;
	UISegmentedControl *difficultyControl;
	
	UISlider *shipStabilityControl;
	UISwitch *randomizeFactsControl;
	UISwitch *randomizeNumbersControl;
	
	UITextField *versionControl;
	UIView *preferencesView;
	UIWebView *webView;
	UINavigationController *navController;
	NSUserDefaults *myDefaults;
	id <PreferencesViewControllerDelegate> delegate;
}

@property (nonatomic, retain) UIView *preferencesView;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) UILabel *numbersLabel;
@property (nonatomic, assign) id <PreferencesViewControllerDelegate> delegate;

/* Preferences Table Methods */
-(id)init;
-( void)loadView;
-(void)dealloc;

/* DataSource Methods */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
-(IBAction)done;

@end

@protocol PrefenecesViewControllerDelegate
- (void)preferencesViewControllerDidFinish:(PreferencesViewController *)controller;
@end

