//
//  BuyTicketOptionsTableViewController+Events.m
//  iTicket
//
//  Created by Matteo Cortonesi on 30/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketOptionsTableViewController+Events.h"

#import "BuyTicketNavigationController.h"
#import "Ticket.h"
#import "BuyTicketCheckoutViewController.h"
#import "iTicketAppDelegate.h"

@interface BuyTicketOptionsTableViewController (PrivateMethods)

- (void)bringDownDatePicker;

@end


@implementation BuyTicketOptionsTableViewController (Events)

- (IBAction)checkoutButtonTouchUpInside:(id)sender {
	BuyTicketNavigationController *navigationController = (BuyTicketNavigationController *)[self navigationController];
		
	// Create the checkout view controller
	BuyTicketCheckoutViewController *checkoutViewController = [[BuyTicketCheckoutViewController alloc]
															   initWithNibName:kBuyTicketCheckoutNib bundle:nil];
	
	[navigationController pushViewController:checkoutViewController animated:YES];
	[checkoutViewController release];
}

- (IBAction)pickerViewDoneButtonTouchUpInside:(id)sender {
	[self bringDownDatePicker];
}

- (IBAction)datePickerValueChanged:(id)sender {
	((BuyTicketNavigationController *)[self navigationController]).ticket.validityDate = ((UIDatePicker *)sender).date;
	[tableView reloadData];
}

@end