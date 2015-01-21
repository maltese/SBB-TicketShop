//
//  iTicketAppDelegate.h
//  iTicket
//
//  Created by Matteo Cortonesi on 16/8/08.
//  Copyright Ambra 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kDefaultsFileName;

// User defaults keys
extern NSString *kTabBarSelectionIndexKey;
extern NSString *kDeparturesTablesSwitchSelectionIndexKey;
extern NSString *kDestinationsTablesSwitchSelectionIndexKey;
extern NSString *kFavouriteDestinationsKey;
extern NSString *kOptionsTicketDirectionKey;
extern NSString *kOptionsTicketClassKey;
extern NSString *kOptionsTicketFareKey;
extern NSString *kUsernameKey;
extern NSString *kPasswordKey;
extern NSString *kMyTicketsKey;
extern NSString *k1TapTicketsKey;

// Plist keys
extern NSString *kContentKey;
extern NSString *kSectionNameKey;
extern NSString *kIdKey;

@interface iTicketAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end