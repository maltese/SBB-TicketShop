//
//  BuyTicketOptionsTableViewController+Events.h
//  iTicket
//
//  Created by Matteo Cortonesi on 30/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BuyTicketOptionsTableViewController.h"

@interface BuyTicketOptionsTableViewController (Events)

- (IBAction)checkoutButtonTouchUpInside:(id)sender;
- (IBAction)pickerViewDoneButtonTouchUpInside:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;

@end
