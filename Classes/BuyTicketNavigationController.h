//
//  BuyTicketNavigationController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 27/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kBuyTicketDestinationsNib;
extern NSString *kBuyTicketOptionsNib;
extern NSString *kBuyTicketCheckoutNib;
extern NSString *kBuyTicketLoginNib;

@class Ticket;

@interface BuyTicketNavigationController : UINavigationController {
	Ticket *ticket;
}

@property (nonatomic, retain) Ticket *ticket;

@end
