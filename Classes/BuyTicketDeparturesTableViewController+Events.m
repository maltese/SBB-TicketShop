//
//  BuyTicketDeparturesTableViewController+Events.m
//  iTicket
//
//  Created by Matteo Cortonesi on 17/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDeparturesTableViewController+Events.h"

#import "SearchableTableViewController.h"

#import "AllStationsDataSource.h"
#import "BuyTicketDeparturesAllStationsTableViewDelegate.h"
#import "BuyTicketNearbyStationsTableViewDataSource.h"
#import "BuyTicketNearbyStationsTableViewDelegate.h"

#import "iTicketAppDelegate.h"

@implementation BuyTicketDeparturesTableViewController (Events)

- (IBAction)doneButtonTouchUpInside:(id)sender {
	[searchableTableViewController dismissSearch];
}

- (IBAction)segmentedControlValueChanged:(id)sender {
	switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
		case allStationsSelected:
			searchableTableViewController.tableViewDataSource = allStationsDataSource;
			searchableTableViewController.tableViewDelegate = allStationsTableViewDelegate;
			searchableTableViewController.showSearchBar = YES;
			[searchableTableViewController.tableView reloadData];
			
			// Save new default
			[[NSUserDefaults standardUserDefaults] setInteger:allStationsSelected forKey:kDeparturesTablesSwitchSelectionIndexKey];
			break;
		case nearbyStationsSelected:
			searchableTableViewController.tableViewDataSource = nearbyStationsTableViewDataSource;
			searchableTableViewController.tableViewDelegate = nearbyStationsTableViewDelegate;
			searchableTableViewController.showSearchBar = NO;
			[searchableTableViewController.tableView reloadData];
			
			// Save new default
			[[NSUserDefaults standardUserDefaults] setInteger:nearbyStationsSelected forKey:kDeparturesTablesSwitchSelectionIndexKey];
			break;
		default:
			break;
	}
}

@end
