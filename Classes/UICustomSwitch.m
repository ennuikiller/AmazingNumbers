//
//  UICustomSwitch.m
//  AmazingNumbers
//
//  Created by Steven Hirsch on 6/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#include "time.h"


@interface _UISwitchSlider : UIView
@end

@interface UICustomSwitch : UISwitch
- (void) setLeftLabelText: (NSString *) labelText;
- (void) setRightLabelText: (NSString *) labelText;
@end

@implementation UICustomSwitch
- (_UISwitchSlider *) slider { 
	return [[self subviews] lastObject]; 
}
- (UIView *) textHolder { 
	return [[[self slider] subviews] objectAtIndex:2]; 
}
- (UILabel *) leftLabel { 
	return [[[self textHolder] subviews] objectAtIndex:0]; 
}
- (UILabel *) rightLabel { 
	return [[[self textHolder] subviews] objectAtIndex:1]; 
}
- (void) setLeftLabelText: (NSString *) labelText { 
	[[self leftLabel] setText:labelText]; 
}
- (void) setRightLabelText: (NSString *) labelText { 
	[[self rightLabel] setText:labelText]; 
}
@end
