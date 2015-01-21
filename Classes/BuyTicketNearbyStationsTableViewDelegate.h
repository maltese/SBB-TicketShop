//
//  BuyTicketNearbyStationsTableViewDelegate.h
//  iTicket
//
//  Created by Matteo Cortonesi on 20/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BuyTicketNearbyStationsTableViewDelegate : NSObject <UITableViewDelegate> {
	UIViewController *viewController;
}

@property (nonatomic, assign) UIViewController *viewController;

- (id)initWithViewController:(UIViewController *)aViewController;

@end
