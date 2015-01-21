//
//  iTicketAppDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 16/8/08.
//  Copyright Ambra 2008. All rights reserved.
//

#import "iTicketAppDelegate.h"
#import "iTicketTabBarController.h"
#import "MyTicketsViewController.h"
#import "OneTapTicketsViewController.h"
#import "OneTapNavigationController.h"

NSString *kDefaultsFileName = @"Defaults";

// User defaults keys
NSString *kTabBarSelectionIndexKey = @"TabBarSelectionIndex";
NSString *kDeparturesTablesSwitchSelectionIndexKey = @"DeparturesTablesSwitchSelectionIndex";
NSString *kDestinationsTablesSwitchSelectionIndexKey = @"DestinationsTablesSwitchSelectionIndex";
NSString *kFavouriteDestinationsKey = @"FavouriteDestinations";
NSString *kOptionsTicketDirectionKey = @"OptionsTicketDirection";
NSString *kOptionsTicketClassKey = @"OptionsTicketClass";
NSString *kOptionsTicketFareKey = @"OptionsTicketFare";
NSString *kUsernameKey = @"Username";
NSString *kPasswordKey = @"Password";
NSString *kMyTicketsKey = @"MyTickets";
NSString *k1TapTicketsKey = @"1TapTickets";

// Plist keys
NSString *kContentKey = @"content";
NSString *kSectionNameKey = @"sectionName";
NSString *kIdKey = @"id";


@implementation iTicketAppDelegate

@synthesize window;
@synthesize tabBarController;

// Called once by the runtime before the class object is set up
+ (void)initialize {
	// Set up the default defaults (those that are used if the user hasn't launched
	// the application yet)
	NSString *path = [[NSBundle mainBundle] pathForResource:kDefaultsFileName ofType:@"plist"];
	NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:path];
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[window addSubview:tabBarController.view];
}

- (void)dealloc {
    [window release];
	[tabBarController release];
	
    [super dealloc];
}

// UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)aTabBarController didSelectViewController:(UIViewController *)viewController {
	TabBarSection newSectionIndex = aTabBarController.selectedIndex;
		
	// Save new default
	[[NSUserDefaults standardUserDefaults] setInteger:newSectionIndex forKey:kTabBarSelectionIndexKey];
}

@end
