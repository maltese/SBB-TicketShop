//
//  OneTapTicketsViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 18/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "OneTapTicketsViewController.h"

#import "Ticket.h"
#import "iTicketAppDelegate.h"

@implementation OneTapTicketsViewController

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationItem.title = NSLocalizedString(@"1-Tap Tickets",@"Title of the 1-Tap navigation item");

	[self.navigationItem setRightBarButtonItem:[self editButtonItem]];
}

- (void)dealloc {
	[tableView release];
	
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
	[tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	
	// Put the table in editing mode
	[tableView setEditing:editing animated:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

@end
