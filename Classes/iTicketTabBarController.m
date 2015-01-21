//
//  iTicketTabBarController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "iTicketTabBarController.h"

#import "iTicketAppDelegate.h"

@implementation iTicketTabBarController

- (void)viewDidLoad {
	// Load default selection
	self.selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:kTabBarSelectionIndexKey];
}

@end
