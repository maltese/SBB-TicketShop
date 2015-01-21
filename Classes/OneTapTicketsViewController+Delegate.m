//
//  OneTapTicketsViewController+Delegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 18/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "OneTapTicketsViewController+Delegate.h"

#import "OneTapCell.h"
#import "BuyTicketCheckoutViewController.h"
#import "BuyTicketNavigationController.h"

@implementation OneTapTicketsViewController (Delegate)

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
	
	[(id)[self navigationController] setTicket:
	 ((OneTapCell *)[aTableView cellForRowAtIndexPath:indexPath]).ticket];
	
	BuyTicketCheckoutViewController *controller = [[BuyTicketCheckoutViewController alloc]
												   initWithNibName:kBuyTicketCheckoutNib bundle:nil];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

@end