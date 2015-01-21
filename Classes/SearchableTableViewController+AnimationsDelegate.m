//
//  SearchableTableViewController+AnimationsDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 18/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "SearchableTableViewController+AnimationsDelegate.h"


@implementation SearchableTableViewController (AnimationsDelegate)

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	if ([animationID isEqualToString:kHideBlackLayerAnimation]) {
		// Hide the black layer
		blackLayerButton.hidden = YES;
	}
}

@end
