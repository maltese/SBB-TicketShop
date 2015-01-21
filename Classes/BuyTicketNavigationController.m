//
//  BuyTicketNavigationController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 27/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketNavigationController.h"

NSString *kBuyTicketDestinationsNib = @"BuyTicketDestinations";
NSString *kBuyTicketOptionsNib = @"BuyTicketOptions";
NSString *kBuyTicketCheckoutNib = @"BuyTicketCheckout";
NSString *kBuyTicketLoginNib = @"BuyTicketLogin";


@implementation BuyTicketNavigationController

@synthesize ticket;

- (void)dealloc {
	[ticket release];
	
	[super dealloc];
}

@end
