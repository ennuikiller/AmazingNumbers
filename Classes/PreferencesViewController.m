//
//  PreferencesViewController.m
//  AmazingNumbers
//
//  Created by Steven Hirsch on 6/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//  

#import "PreferencesViewController.h"

@implementation PreferencesViewController

@synthesize preferencesView, webView, delegate, navController, numbersLabel;

-(id)init {
	self = [ super initWithStyle:UITableViewStyleGrouped ];
	//self = [super init];
	if (self != nil) {
		self.title = @"Game Settings";
	}
		
	return self;
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
- (id)initWithAppDelegate:(id)appDelegate {
	
	self = [ super init ];
	if (self != nil) {
		NSLog(@"inside preferences initwithappdelegate");
		
		//UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(180, 250, 100, 100) ];
		//UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		//[button addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
		//NSString *title = @"<- Back";
		//button.backgroundColor = [UIColor clearColor];
		//[button setTitle: title forState:UIControlStateNormal];
		//dismissButton = button;
		//CGRect buttonFrame = CGRectMake(0, 420, 75, 25);
		//CGRect buttonFrame = RoundedRectView(180, 250, 100, 100);
		
		//dismissButton.frame = buttonFrame;
		
		
		
		//UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:self];
		//navController = controller;
		//self.title = @"Preferences";
		//UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		//navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		//UINavigationItem *preferencesTitle = [[UINavigationItem alloc ] initWithTitle:@"Preferences"];
		//self.navigationItem.title = preferencesTitle;
		
		/*
		UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
		self.navigationItem.rightBarButtonItem = done;
		self.navigationItem.title = @"Preferences";
		navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
		*/
		
		
		//[done release];
		//UIView *mview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
		//preferencesView = mview;
		//self.navigationItem.leftBarButtonItem = done;
		//[self.navigationController.view setNeedsDisplay];
		
		//webView  = [[UIWebView alloc] initWithFrame:CGRectMake(0, 140, 320, 415)];
		
		//[webView setBackgroundColor:[UIColor redColor]];
		//[webView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed: @"numbers.png"]]];
		//webView.alpha = 0.;
		
		//[webView setOpaque:NO];
		//webView.userInteractionEnabled = YES;
		
		webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 215)];
		webView.dataDetectorTypes = UIDataDetectorTypeNone;
		[self.view addSubview:webView];
		//[self.view addSubview:navBar];
		////[preferencesView addSubview:webView];
		//[self.view addSubview:[navController view]];
		//self.view = preferencesView;
		//self.navigationItem.title = @"Preferences";

		//[self.view addSubview:self.navigationController.view];
				//[self.navigationController.view setNeedsLayout];
		//[self.navigationController.view setNeedsDisplay];
		//[controller release];
		//[self.view addSubview:webView];
		
		//[self.view addSubview:dismissButton];
	}
	
	return self;
}

 - (id)initWithStyle:(UITableViewStyle)style {
 if (self = [super initWithStyle:style]) {
 
 NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];		
 
NSArray *settingsList = [NSArray arrayWithObjects:
 [NSMutableDictionary dictionaryWithObjectsAndKeys:
 @"Sounds",@"titleValue",	
 @"switch",@"accessoryValue",
 [NSNumber numberWithBool:[myDefaults boolForKey:@"soundsValue"]],@"prefValue",
 @"setSounds:",@"targetValue",nil],
 [NSMutableDictionary dictionaryWithObjectsAndKeys:
 @"Music",@"titleValue",	
 @"switch",@"accessoryValue",
 [NSNumber numberWithBool:[myDefaults boolForKey:@"musicValue"]],@"prefValue",
 @"setMusic:",@"targetValue",nil],nil];
 
 
 [settingsList retain];
 
 CGPoint tableCenter = self.view.center;
 self.view.center = CGPointMake(tableCenter.x,tableCenter.y+22);
 
NSMutableArray *switchList = [NSMutableArray arrayWithCapacity:settingsList.count];
 for (int i = 0 ; i < [settingsList count] ; i++) {
 if ([[[settingsList objectAtIndex:i] objectForKey:@"accessoryValue"] compare:@"switch"] == NSOrderedSame) {
 UISwitch *mySwitch = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
 mySwitch.on = [[[settingsList objectAtIndex:i] objectForKey:@"prefValue"] boolValue];
 [mySwitch addTarget:self action:NSSelectorFromString([[settingsList objectAtIndex:i] objectForKey:@"targetValue"]) forControlEvents:UIControlEventValueChanged];
 [switchList insertObject:mySwitch atIndex:i];
 } else {
 [switchList insertObject:@"" atIndex:i];
 }
 }
 
 [switchList retain];
 }
 
 return self;
 }
 

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
[super loadView];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults];
	myDefaults = defaults;
	//randomizeNumbersControl.on = ([[defaults objectForKey:kRandomizeNumbers] isEqualToString:@"Randomize"]) ? YES : NO;
	randomizeNumbersControl.on = [defaults boolForKey:kRandomizeNumbers] ? YES : NO;
	randomizeFactsControl.on = [myDefaults boolForKey:kRandomizeFacts] ? YES: NO;
	numbersSlider.value = [myDefaults integerForKey:kNumbersToDisplay];
	self.numbersLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(50.0, 5.0, 180, 30) ];
	int progressAsInt = [myDefaults integerForKey:kNumbersToDisplay];
	NSString *newText = [ [ NSString alloc] initWithFormat:@"%d", progressAsInt];
	self.numbersLabel.text = newText;
	UIFont *numbersLabelFont = [UIFont fontWithName:@"DB LCD TEmp" size:32];
	self.numbersLabel.font = numbersLabelFont;
	self.numbersLabel.textAlignment = UITextAlignmentCenter;
	
	
	
	//NSLog(@"kRandomizeNumbers are %@", [defaults boolForKey:kRandomizeNumbers]);


}

-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//NSString *prefValue = (randomizeNumbersControl.on) ? @"Randomize" : @"Ordered";
	BOOL prefValue = randomizeNumbersControl.on ? YES : NO;
	NSLog(@"prefValue = %d",prefValue);

	[defaults setBool:prefValue forKey:kRandomizeNumbers];
	prefValue = randomizeFactsControl.on ? YES : NO;
	[defaults setBool:prefValue forKey:kRandomizeFacts];
	[defaults setInteger:numbersSlider.value forKey:kNumbersToDisplay];
	NSLog(@"numbersSlider = %d",numbersSlider.value);
	[super viewWillDisappear:animated];
	
	
}


- (IBAction)done {
	//[self dismissModalViewControllerAnimated:YES];
	[self.delegate preferencesViewControllerDidFinish:self];	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[numbersSlider release];
	[gameVolumeControl release];
	[difficultyControl release];
	[shipStabilityControl release];
	[randomizeFactsControl release];
	[randomizeNumbersControl release];
	[versionControl release];
	[navController release];
    [super dealloc];
}


#pragma mark -
#pragma mark Instance Methods
-(void)sliderChanged:(id)sender {
	UISlider *slider = (UISlider *)sender;
	int progressAsInt = (int)(slider.value + 0.5f);
	NSString *newText = [ [ NSString alloc] initWithFormat:@"%d", progressAsInt];
	numbersLabel.text = newText;
	UIFont *numbersLabelFont = [UIFont fontWithName:@"DB LCD TEmp" size:32];
	numbersLabel.font = numbersLabelFont;
	numbersLabel.textAlignment = UITextAlignmentCenter;
	
	[newText release];
}
#pragma mark -
#pragma mark DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case (0):
			return 3;
			break;
		case (1):
			return 2;
			break;
		case (2):
			return 1;
			break;
	}
	return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case (0):
			return @"Numbers";
			break;
		case (1):
			return @"Randomize";
			break;
		case (2):
			return @"About";
			break;
	}
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *CellIdentifier = [ NSString stringWithFormat: @"%d:%d", [ indexPath indexAtPosition: 0 ],
								[ indexPath indexAtPosition:1 ] ];
	
    UITableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier: CellIdentifier ];
    if (cell == nil) {
        //cell = [ [ [ UITableViewCell alloc ] initWithFrame: CGRectZero reuseIdentifier: CellIdentifier ] autorelease ];
		cell = [ [ [ UITableViewCell alloc ] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier: CellIdentifier ] autorelease ];

		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		switch ([ indexPath indexAtPosition: 0]) {
			case(0):
				switch([ indexPath indexAtPosition: 1]) {
					case(1):
						numbersSlider = [ [ UISlider alloc ] initWithFrame: CGRectMake(10, 0.0, 300.0, 50.0) ];
						
						numbersSlider.minimumValue = 0.0;
						numbersSlider.maximumValue = 100.0;
						numbersSlider.value = [myDefaults integerForKey:kNumbersToDisplay];
						[numbersSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventTouchUpInside];
						
						//[cell setText:@"Numbers to Display"];
						[ cell addSubview: numbersSlider ];
						//cell.text = @"Music Volume";
						break;
					case(0):
						//gameVolumeControl = [ [ UISlider alloc ] initWithFrame: CGRectMake(170.0, 0.0, 125.0, 50.0) ];
						//gameVolumeControl.minimumValue = 0.0;
						//gameVolumeControl.maximumValue = 10.0;
						//gameVolumeControl.value = 3.5;
						//numbersLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(50.0, 5.0, 180, 30) ];
						//numbersLabel.text = @"Numbers To Display";
						cell.text = @"Numbers To Display";
						cell.textAlignment = UITextAlignmentCenter;
						//[ cell addSubview:numbersLabel ];
						//[ cell addSubview: gameVolumeControl ];
						//cell.text = @"Game Volume";
						break;
					case(2):
						
						
						 numbersLabel = self.numbersLabel;
						//difficultyControl = [ [ UISegmentedControl alloc ] initWithFrame: CGRectMake(170.0, 5.0, 125.0, 35.0) ];
						//[ difficultyControl insertSegmentWithTitle: @"Easy" atIndex: 0 animated: NO ];
						//[ difficultyControl insertSegmentWithTitle: @"Hard" atIndex: 1 animated: NO ];
					    //difficultyControl.selectedSegmentIndex = 0;
						//[ cell addSubview: difficultyControl ];
						[cell addSubview:numbersLabel];
						//[numbersLabel release];
						//cell.text = @"Difficulty";
						break;
				}
				break;
			case(1):
				switch ([ indexPath indexAtPosition: 1 ]) {
					
					case(0):
						randomizeNumbersControl = [ [ UISwitch alloc ] initWithFrame: CGRectMake(200.0, 10.0, 0.0, 0.0) ];
						randomizeNumbersControl.on = [myDefaults boolForKey:kRandomizeNumbers] ? YES : NO;
						[ cell addSubview: randomizeNumbersControl ];
						cell.text = @"Numbers";
						break;
					case(1):
						randomizeFactsControl = [ [ UISwitch alloc ] initWithFrame: CGRectMake(200.0, 10.0, 0.0, 0.0) ];
						randomizeFactsControl.on = [myDefaults boolForKey:kRandomizeFacts] ? YES : NO;
						[ cell addSubview: randomizeFactsControl ];
						cell.text = @"Facts";
						break;	
				}
				break;
			case(2):
				versionControl = [ [ UITextField alloc ] initWithFrame: CGRectMake(170.0, 10.0, 125.0, 38.0) ];
				versionControl.text = @"1.0";
				[ cell addSubview: versionControl ];
				[ versionControl setEnabled: NO ];
				cell.text = @"Version";
				break;
		}
	}
	
    return cell;
}

@end
