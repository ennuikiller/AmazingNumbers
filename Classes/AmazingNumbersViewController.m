//
//  AmazingNumbersViewController.m
//  AmazingNumbers
//
//  Created by Steven Hirsch on 5/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AmazingNumbersViewController.h"
#import "AmazingNumbersAppDelegate.h"
#import "NSMutableArray+Shuffle.h"
#import "ModalViewController.h"
#import "PreferencesViewController.h"


@implementation AmazingNumbersViewController

@synthesize numberFactsPicker, numberFacts, numbers, facts, displayText, selectedView, oldView, oldViews, nullValue, whyModalViewController, preferencesViewController, explain;
@synthesize mainView, preferencesView, frontViewIsVisible, navigationController, sortedNumbers, randomFacts;

- (id)init {
	if (self = [super init]) {
		preferencesView = nil;
		self.frontViewIsVisible=YES;
		
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




// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	
 UIView *mview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
 self.mainView = mview;
	
 UIPickerView *numberFactsPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	
 //creating the picker view
 numberFactsPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
 numberFactsPickerView.showsSelectionIndicator=NO; 
 numberFactsPickerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"numbers.png"]];
 numberFactsPickerView.alpha = 0.65;
	
 UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 210, 320, 215)];

 numberFactsPicker = numberFactsPickerView;
 numberFactsPicker.delegate = self;
 numberFactsPicker.dataSource = self;
		
	
 displayText = webView;
 [displayText setBackgroundColor:[UIColor blackColor]];	
 [displayText setOpaque:NO];
 displayText.userInteractionEnabled = YES;
 displayText.dataDetectorTypes = UIDataDetectorTypeNone;
	
	
	
 [mainView addSubview:numberFactsPicker];
	
    self.title =@"Amazing Number Facts!!";
	NSString *html = @"<html><head><style>body{background-color:transparent;}</style></head><body><p><br><br><font size=24 color='fffff0'>...really is 2\u2074</font><hr><b>42</b>!</body></html>";
	[displayText loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.hitchhiker.com/message"]]; 
	[mainView addSubview:displayText];
	
	 self.view = mainView;
	[numberFactsPickerView release];
	[webView release];
	[mview release];
}
 



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	NSBundle *bundle = [ NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:@"numbers" ofType:@"plist"];
	
	
	NSUserDefaults *myDefaults = [ NSUserDefaults standardUserDefaults];
	NSInteger numbersToDisplay = [myDefaults integerForKey:kNumbersToDisplay];
	NSLog(@"numbers to display = %d",numbersToDisplay);
	
	
	//NSLog(@"%@", [[[NSDictionary alloc] initWithContentsOfFile:plistPath] autorelease]);	
	NSDictionary *dictionary = [ [ NSDictionary alloc ] initWithContentsOfFile:plistPath ];
	self.numberFacts = dictionary;
	NSLog(@"Total Number of Facts = %d",[self.numberFacts count]);
	[dictionary release];
	
	NSEnumerator *enumerator = [numberFacts keyEnumerator];
	NSString  *key;
	
	NSMutableArray *numberSort =[[NSMutableArray alloc] init];
	
	while ((key = [enumerator nextObject])) {
		//(NSNumber *)integer = [key integerValue];
		[numberSort  addObject:[NSNumber numberWithInt:[key intValue]]];
		// code that uses the returned key 
	}
	
	
	NSArray *stringSort = [numberSort sortedArrayUsingSelector:@selector(compare:)];
	enumerator = [stringSort objectEnumerator];
	NSNumber  *intKey;
	
	NSMutableArray *backToString =[[NSMutableArray alloc] init];
	
	while ((intKey = [enumerator nextObject])) {
		//(NSNumber *)integer = [key integerValue];
		[backToString  addObject:[intKey stringValue]];
		// code that uses the returned key 
	}
	//NSArray *components =  [self.numberFacts allKeys];
	NSArray *components = backToString;
	NSArray *sorted = components;
	//NSArray *sorted = [components sortedArrayUsingSelector:@selector(compare:)];
	//NSArray *sorted = [components sortedArrayUsingFunction:integerCompare context:NULL];
	
	
	//NSUInteger selectedNumbers = numbersToDisplay + 1;
	//NSRange range = NSMakeRange(0,selectedNumbers);
	//self.numbers = [sorted subarrayWithRange:range];
	self.sortedNumbers = sorted;
	
	NSInteger numberOfItems = [self.sortedNumbers count];
	NSLog(@"number of items is: %d",numberOfItems);
	
	[self setPreferences];
	
	
	NSString *selectedNumber = [self.numbers objectAtIndex:0];
	NSArray *array = [numberFacts objectForKey:selectedNumber];
	
	
	self.facts = (NSMutableArray *) array;
	
	NSInteger totalNumberOfFacts = 0;
	
	for (int i=0;i<([self.numbers count]);i++) {
		totalNumberOfFacts += [[numberFacts objectForKey:[self.numbers objectAtIndex:i]] count];
	}
	
	NSLog(@"Total number of facts = %d",totalNumberOfFacts);
	
	self.nullValue = [NSNull null];
	
	NSMutableArray *marray = [ [ NSMutableArray alloc] initWithObjects:self.nullValue,self.nullValue, nil];
	
	self.oldViews = marray;
	
	selectedView = [numberFactsPicker viewForRow:0 forComponent:kNumberComponent];
	
UIColor * lightBlue = [UIColor colorWithHue:.58 saturation:.99 brightness:.99 alpha:0.7];
		[self setColorOnView:selectedView forComponent:kNumberComponent withColor:lightBlue];

	selectedView = [numberFactsPicker viewForRow:0 forComponent:kFactComponent];
	[self setColorOnView:selectedView forComponent:kFactComponent withColor:lightBlue];
	
	
	NSString *selectedFact = [facts objectAtIndex: [numberFactsPicker selectedRowInComponent:kFactComponent]];
	//[displayText scrollRangeToVisible:[displayText selectedRange]];
	
	if ([selectedFact isKindOfClass:[NSDictionary class]])
		selectedFact = @"";
	NSScanner *scanPickerText = [NSScanner scannerWithString:selectedFact];
	[scanPickerText setCaseSensitive:YES];
	NSString *textToDisplay = [[[NSString alloc] init] autorelease];
	[scanPickerText scanUpToString:@"<" intoString:&textToDisplay];
	self.navigationItem.title = textToDisplay;
	[scanPickerText scanUpToString:@"END" intoString:&textToDisplay];
	self.explain = textToDisplay;
	[self populateDisplayTextWith:textToDisplay];
	if ([scanPickerText scanUpToString:@"BUTTON" intoString:&textToDisplay]) {
		NSLog(@"SCANNED BUTTON");
		self.explain = textToDisplay;
		UIBarButtonItem *credits = [ [ [ UIBarButtonItem alloc ] 
									  initWithTitle:@"More"
									  //  initWithCustomView:testLabel
									  style: UIBarButtonItemStylePlain
									  target: self 
									  action:@selector(credits) 
									  ]
									autorelease ];
		
		self.navigationItem.rightBarButtonItem = credits;
		
		//self.title = textToDisplay;
		NSLog(@"title = %@",textToDisplay);
		//[self.navigationController.view setNeedsLayout];
		//self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
		[self.navigationController.view setNeedsDisplay];
	}
	
	UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[leftBarButton addTarget:self action:@selector(preferences) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *info = [ [ [ UIBarButtonItem alloc ] initWithCustomView:leftBarButton] autorelease];
	//info.target = self;
	//info.action = @selector(flipView:);
	self.navigationItem.leftBarButtonItem = info;
	
	/* Initialize Navigation Back Bar Button 
	UIBarButtonItem *back = [ [ [ UIBarButtonItem alloc ] 
							   initWithTitle:@"Back" 
							   style: UIBarButtonItemStylePlain
							   target: self 
							   action: @selector(back) ]
							 autorelease ];
	self.navigationItem.backBarButtonItem = back;
	 Initialize Navigation Back Bar Button */
		
	//[array release];
	//[info release];
	[numberSort release];
	[backToString release];
	[marray release];
	
    [super viewDidLoad];

	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Number Collage.png"]];
	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackboard.png"]];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
/*
-(void)viewWillAppear:(BOOL)animated {
	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[self.view addSubview:spinner];
	[spinner startAnimating];

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
	[numberFacts release];
	[facts release];
	[numbers release];
    [super dealloc];
}


#pragma mark -
#pragma mark Class Methods

-(void)setPreferences {
	
	NSUserDefaults *myDefaults = [ NSUserDefaults standardUserDefaults];
	NSInteger numbersToDisplay = [myDefaults integerForKey:kNumbersToDisplay];
	NSLog(@"numbers to display = %d",numbersToDisplay);
	
	BOOL randomizeNumbers = [myDefaults boolForKey:kRandomizeNumbers] ? YES : NO;
	BOOL randomizeFacts = [myDefaults boolForKey:kRandomizeFacts] ? YES : NO;
	
	self.randomFacts = randomizeFacts;

	
	NSUInteger selectedNumbers = numbersToDisplay + 1;
	NSLog(@"number to display = %d",selectedNumbers);
	NSRange range = NSMakeRange(0,selectedNumbers);
	
	NSMutableArray *updateNumbersDisplay = [ [ NSMutableArray alloc ] initWithArray: [self.sortedNumbers subarrayWithRange:range] ];
	
	self.numbers = updateNumbersDisplay;
	
	if (selectedNumbers == 101) {
		[self.numbers addObject:[self.sortedNumbers objectAtIndex:101]];
	}
	
	if (randomizeNumbers) {
		[self.numbers shuffle];
	}
	
	[self.numberFactsPicker reloadAllComponents];
	
	[updateNumbersDisplay release];
}

#pragma mark -
#pragma mark Instance Methods

 
-(void)preferences {
	NSLog(@"Selected info button");
	
	PreferencesViewController *controller = [[[PreferencesViewController alloc] init] autorelease];
	//PreferencesViewController *controller = [[[PreferencesViewController alloc] initWithAppDelegate:self] autorelease];

	//PreferencesViewController *controller = [[PreferencesViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *secondNavigationController =
    [[UINavigationController alloc] initWithRootViewController:controller];
	secondNavigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	
	secondNavigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

	//controller.delegate = self;
	//navigationController = [ [ UINavigationController alloc] initWithRootViewController:controller];
	//navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	
	//UIBarButtonItem *done = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)] autorelease];
	//self.navigationItem.rightBarButtonItem = done;

	//controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	//controller.delegate = self;
	UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(done)];
	//done.style = UIBarButtonItemStyleDone;
	
	controller.navigationItem.rightBarButtonItem = done;
	controller.navigationItem.title = @"Preferences";
	[self  presentModalViewController:secondNavigationController animated:YES];
	[secondNavigationController release];
	//controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	//[self presentModalViewController:controller animated:YES];
	
	
	
}

- (void)preferencesViewControllerDidFinish:(PreferencesViewController *)controller {
    
	
	[self dismissModalViewControllerAnimated:YES];
	
	
}

- (void)transitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	// re-enable user interaction when the flip is completed.
	mainView.userInteractionEnabled = YES;
	
}


-(void)populateDisplayTextWith:(NSString *)textToDispley {
 
	NSString *html = [ [ NSString alloc ] initWithFormat:@"%@", textToDispley];
	NSLog(@"%@",html);
	
	NSString *imagePath = [[NSBundle mainBundle] resourcePath];
	NSLog(@"imagePath = %@ ",imagePath);
	imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
	imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	
	 
	[displayText loadHTMLString:html baseURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//",imagePath]]];
//	[displayText loadHTMLString:@"www.youtube.com"  baseURL:@"http://"];

	[html release];
	
	
}


-(void)setColorOnView:(UIView *)view forComponent:(NSInteger)component withColor:(UIColor *)color {
	self.oldView = [self.oldViews objectAtIndex:component];
	NSLog(@"old view = %@",self.oldView);
	if (self.oldView != (UIView *)nullValue) {
		UILabel *labelView = (UILabel *)oldView;
		labelView.textColor = [UIColor blackColor];
		oldView = labelView;
		self.oldView.backgroundColor = [UIColor clearColor];
		
		
		//[self.oldView setNeedsDisplay];
	} 
	/* else {
		self.oldView = [self.oldViews objectAtIndex:component];
	}
*/
	
	UILabel *labelView = (UILabel *)selectedView;
	labelView.textColor = [UIColor redColor];
	selectedView = labelView;
	
	self.selectedView = view;
	self.selectedView.backgroundColor = color;
	
	[self.selectedView setNeedsLayout];
	[self.selectedView setNeedsDisplay];
	
	[self.oldViews replaceObjectAtIndex:component withObject:self.selectedView];
	//self.oldView = [self.oldViews objectAtIndex:component];
	
}

-(void)credits {
	if (self.whyModalViewController == nil)
        self.whyModalViewController = [[[ModalViewController alloc] initWithAppDelegate:self ] autorelease];
	//whyModalViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"numbers.png"]];
	//whyModalViewController.view.alpha = 0.65;

		NSLog(@"self.explian =",self.explain);
	NSString *html = [ [ NSString alloc ] initWithFormat:@"%@", self.explain];
	
	NSString *imagePath = [[NSBundle mainBundle] resourcePath];
	NSLog(@"imagePath = %@ ",imagePath);
	imagePath = [imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
	imagePath = [imagePath stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	
	
	[self.whyModalViewController.webView loadHTMLString:html baseURL:[NSURL URLWithString: [NSString stringWithFormat:@"file:/%@//",imagePath]]];
	
	
	//NSString *html = [ [ NSString alloc ] initWithFormat:@"%@", self.explain];
   // [self.whyModalViewController.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.hitchhiker.com/message"]]; 
	//[self.whyModalViewController.webView loadHTMLString:html baseURL:nil]; 
	
	//whyModalViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	/* Initialize Navigation Buttons 
	UIBarButtonItem *back = [ [ [ UIBarButtonItem alloc ] 
							   initWithTitle:@"Back" 
							   style: UIBarButtonItemStylePlain
							   target: self
							   action: @selector(back) ]
							 autorelease ];
	self.navigationItem.backBarButtonItem = back;
	[self.navigationController pushViewController:whyModalViewController animated:YES];	
	 */
	[self presentModalViewController:whyModalViewController animated:YES];
	
	//[self.navigationController presentModalViewController:self.whyModalViewController animated:YES];
	NSLog(@"put the button up");
	
	//[ navigationController pushViewController: creditsViewController animated: YES ];
	[html release];
}

-(void)hidden {
	NSLog(@"hidden");
}

-(void)setBarButtonWithText:(NSString *)fact
{

if ([fact isKindOfClass:[NSDictionary class]])
fact = @"";

NSScanner *scanPickerText = [NSScanner scannerWithString:fact];
	[scanPickerText setCaseSensitive:YES];
	
NSString *textToDisplay = [[[NSString alloc] init] autorelease];
[scanPickerText scanUpToString:@"<" intoString:&textToDisplay];
self.navigationItem.title = textToDisplay;
self.explain = @"<font color=\"fffff0\" >fuck no!!</font>";
[scanPickerText scanUpToString:@"END" intoString:&textToDisplay];
	NSString *text = textToDisplay;
/// refactor!!!!!
if ([scanPickerText scanUpToString:@"BUTTON" intoString:&textToDisplay]) {
	
	NSLog(@"SCANNED BUTTON");
	//[scanPickerText scanUpToString:@"BUTTON" intoString:&textToDisplay];
	self.explain = textToDisplay;
	NSLog(@"from within setBarButtonWithText, self.explain = ", self.explain);
	UIBarButtonItem *credits = [ [ [ UIBarButtonItem alloc ] 
								  initWithTitle:@"More" 
								  style: UIBarButtonItemStylePlain
								  target: self 
								  action:@selector(credits) ]
								autorelease ];
	self.navigationItem.rightBarButtonItem = credits;
	//self.title = textToDisplay;
	NSLog(@"title = %@",textToDisplay);
	//[self.navigationController.view setNeedsLayout];
	//self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	[self.navigationController.view setNeedsDisplay];
	//self.navigationItem.rightBarButtonItem.style 
	//self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	[self.navigationController.view setNeedsDisplay];
} else {
	UIView *blankView = [[UIView alloc] init];
	UIBarButtonItem *hidden = [ [ [ UIBarButtonItem alloc ] 
								 initWithCustomView: blankView ]
							   // style: UIBarButtonItemStylePlain
							   // target: self 
							   //  action:@selector(hidden) ]
							   autorelease ];
	
	self.navigationItem.rightBarButtonItem = hidden;
	self.navigationItem.rightBarButtonItem.width = 0;
	
	[self.navigationController.view setNeedsLayout];
	[self.navigationController.view setNeedsDisplay];
	
}
////refactor!!		


[self populateDisplayTextWith:text];
}

- (IBAction)done {
	
	[self dismissModalViewControllerAnimated:YES];
	[self setPreferences];
	
	//[self.delegate preferencesViewControllerDidFinish:self];	
}

#pragma mark -
#pragma mark Picker Delegae Methods

- (CGFloat)pickerView:(UIPickerView *)numberFactsPicker widthForComponent:(NSInteger)component {
    switch(component) {
		case 0: return 75;
		case 1: return 225;
		default: return 22;
	}
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
	
	if (component == kNumberComponent) {
		
		
#define PICKER_LABEL_FONT_SIZE 24
#define PICKER_LABEL_ALPHA 1.0
		// UIFont *font = [UIFont boldSystemFontOfSize:PICKER_LABEL_FONT_SIZE];
		UIFont *font = [ UIFont fontWithName:@"TrebuchetMS-Bold"  size:24];
		UILabel *carsLabel =[ [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 48) ]autorelease];
		//[picker selectRow:row inComponent:component animated:YES];
		NSString *pickerText = [self.numbers objectAtIndex:(int)row];
		
		
		carsLabel.text = pickerText;
		carsLabel.textAlignment = UITextAlignmentCenter;
		//carsLabel.highlightedTextColor = [ UIColor redColor];
		carsLabel.backgroundColor = [UIColor clearColor];
		carsLabel.highlighted = YES;
		NSLog(@"carsLabel = %@",carsLabel.text);
		//carsLabel.text = @"maybe because the string isn't long enough";
		carsLabel.textColor = [UIColor blackColor];
		carsLabel.font = font;
		//NSInteger selectedRow =  [numberFactsPicker selectedRowInComponent:kNumberComponent];
		//NSLog(@"selected row = %@ and row = %@",selectedRow, row);
		//	carsLabel.backgroundColor = [UIColor redColor] ;
		
		
		
		
		
		carsLabel.opaque = YES;
		//UIColor *redColor = redColor;
		//[view setBackgroundColor:(UIColor *) redColor];
		
		[view addSubview:carsLabel];
		//[picker reloadComponent:kFactComponent];
		return carsLabel;	
	} else {
		UIFont *font = [ UIFont fontWithName:@"TrebuchetMS-Bold"  size:24];
		
	
		UILabel *carsLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 225, 48)] autorelease];
		//[picker selectRow:row inComponent:component animated:YES];
		id fact = [self.facts objectAtIndex:(int)row];
		NSString *pickerText = @"Dictionary Entry";
		if ( [fact isKindOfClass:[NSString class]]) {
			
			
			pickerText = [self.facts objectAtIndex:(int)row];
			
		} /* else  {
		 
		 // try aading the factNavController
		 UIViewController *tempViewController = [ [ [ UIViewController alloc ] init ] autorelease ];
		 tempViewController.title = @"Fact Navigation Controller";
		 tempViewController.view.backgroundColor = [ UIColor greenColor ];
		 UINavigationController *tempNavigationController =  [ [ UINavigationController alloc ] initWithRootViewController:tempViewController];
		 
		 self.factNavController = tempNavigationController;
		 [tempNavigationController release ];
		 
		 UIWindow *tempWindow = [ [ UIWindow alloc ] initWithFrame:[[UIScreen mainScreen] bounds ]];
		 tempWindow.backgroundColor = [UIColor redColor];
		 self.window = tempWindow;
		 [tempWindow release];
		 [self.window addSubview:[self.factNavController view];
		 [self.window makeKeyAndVisible];
		 }
		 */
		NSScanner *scanPickerText = [NSScanner scannerWithString:pickerText];
		[scanPickerText setCaseSensitive:YES];
		NSString *title = [[[NSString alloc] init] autorelease];
		[scanPickerText scanUpToString:@"<" intoString:&title];
		carsLabel.text = title;
		
//		carsLabel.text = pickerText;

		carsLabel.textAlignment = UITextAlignmentCenter;
		NSLog(@"carsLabel = %@",carsLabel.text);
		carsLabel.backgroundColor = [UIColor clearColor];
		//carsLabel.text = @"maybe because the string isn't long enough";
		carsLabel.textColor = [UIColor blackColor];
		carsLabel.font = font;
				//carsLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackboard.png"]];;
		carsLabel.opaque = YES;
		
		[view addSubview:carsLabel];
		//[title release];
		return carsLabel;
	}
	
	
	return nil;
}

#pragma mark -
#pragma mark Picker Data Source Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == kNumberComponent) 
		return [self.numbers count];
	return [self.facts count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	//if (self.oldView != nil)
	//	self.oldView.backgroundColor = [UIColor clearColor];
	//[displayText scrollRangeToVisible:[displayText selectedRange]];

	if (component == kNumberComponent) {
		//[numberFactsPicker touchesBegan:UITouchPhaseBegan withEvent:<#(UIEvent *)event#>]
		NSString *selectedNumber = [self.numbers objectAtIndex:row];
		//NSLog(@"selectedNumber = %@",selectedNumber);
		NSMutableArray *array = [[NSMutableArray alloc] initWithArray: [self.numberFacts objectForKey:selectedNumber]];
		self.facts = array;
		[array release];
		
		self.randomFacts ? [ self.facts shuffle] : self.facts;
		[numberFactsPicker selectRow:0 inComponent:kFactComponent animated:YES];
		[numberFactsPicker reloadComponent:kFactComponent];
		selectedView = [numberFactsPicker viewForRow:row forComponent:kNumberComponent];
		UIColor * lightBlue = [UIColor colorWithHue:.58 saturation:.99 brightness:.99 alpha:0.7];
		[self setColorOnView: selectedView forComponent:kNumberComponent withColor: lightBlue];
		selectedView = [numberFactsPicker viewForRow:0 forComponent:kFactComponent];
		if (selectedView != nil)
		[self setColorOnView: selectedView forComponent:kFactComponent withColor: lightBlue];
		

		//[numberFactsPicker reloadComponent:kFactComponent];
		
		//[displayText scrollRangeToVisible:[displayText selectedRange]];
		NSString *fact = (NSString *)[self.facts objectAtIndex:0];
		[self setBarButtonWithText:fact];
			}
	else {
		
		NSInteger numberRow = [numberFactsPicker selectedRowInComponent:kNumberComponent];
		NSInteger factRow = [numberFactsPicker selectedRowInComponent:kFactComponent];
		selectedView = [numberFactsPicker viewForRow:factRow forComponent:kFactComponent];
		UIColor * lightBlue = [UIColor colorWithHue:.58 saturation:.99 brightness:.99 alpha:0.7];
				[self setColorOnView: selectedView forComponent:kFactComponent withColor: lightBlue];
		//NSString *number = [self.numbers objectAtIndex:numberRow];
		//self.facts  = [ self.numberFacts objectForKey:number];
		NSString *fact = (NSString *)[self.facts objectAtIndex:factRow];
		[self setBarButtonWithText:fact];
			}
	
	
}


@end
