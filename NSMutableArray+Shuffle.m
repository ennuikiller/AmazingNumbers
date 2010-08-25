//
//  NSMutableArray+Shuffle.m
//  AmazingNumbers
//
//  Created by Steven Hirsch on 5/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

// Unbiased random rounding thingy.
static NSUInteger random_below(NSUInteger n) {
    NSUInteger m = 1;
	
    do {
        m <<= 1;
    } while(m < n);
	
    NSUInteger ret;
	
    do {
        ret = random() % m;
    } while(ret >= n);
	
    return ret;
}



@implementation NSMutableArray (ArchUtils_Shuffle)

- (void)shuffle {
    // http://en.wikipedia.org/wiki/Knuth_shuffle
	
    for(NSUInteger i = [self count]; i > 1; i--) {
        NSUInteger j = random_below(i);
        [self exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
}
@end