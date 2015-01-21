//
//  MyTicketsPageViewController+Events.m
//  iTicket
//
//  Created by Matteo Cortonesi on 6/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "MyTicketsPageViewController+Events.h"

#import "MyTicketsViewController.h"

@implementation MyTicketsPageViewController (Events)

- (IBAction)deleteTicketButtonTouchUpInside:(id)sender {
	[(MyTicketsViewController *)viewController deleteTicketWithViewController:self];
}

@end
