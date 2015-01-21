//
//  BuyTicketDeparturesAllStationsTableViewDelegate.h
//  iTicket
//
//  Created by Matteo Cortonesi on 17/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BuyTicketDeparturesAllStationsTableViewDelegate : NSObject <UITableViewDelegate> {
	UIViewController *viewController;
}

@property (nonatomic, assign) UIViewController *viewController;

- (id)initWithViewController:(UIViewController *)aViewController;

@end
