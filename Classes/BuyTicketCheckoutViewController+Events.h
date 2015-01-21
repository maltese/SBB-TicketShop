//
//  BuyTicketCheckoutViewController+Events.h
//  iTicket
//
//  Created by Matteo Cortonesi on 1/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "BuyTicketCheckoutViewController.h"

@interface BuyTicketCheckoutViewController (Events)

- (void)amountButtonTouchUpInside:(id)sender;

- (void)buyButtonTouchUpInside:(id)sender;

- (void)buyTicket;

@end
