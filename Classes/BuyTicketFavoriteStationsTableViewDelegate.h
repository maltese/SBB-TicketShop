//
//  BuyTicketFavoriteStationsTableViewDelegate.h
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BuyTicketFavoriteStationsTableViewDelegate : NSObject <UITableViewDelegate> {
	UIViewController *viewController;
}

@property (nonatomic, assign) UIViewController *viewController;

@end
