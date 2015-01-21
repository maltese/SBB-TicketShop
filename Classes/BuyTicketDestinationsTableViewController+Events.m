//
//  BuyTicketDestinationsTableViewController+Events.m
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDestinationsTableViewController+Events.h"

#import "SearchableTableViewController.h"

#import "AllStationsDataSource.h"
#import "BuyTicketDestinationsAllStationsTableViewDelegate.h"
#import "BuyTicketFavoriteStationsTableViewDataSource.h"
#import "BuyTicketFavoriteStationsTableViewDelegate.h"

#import "iTicketAppDelegate.h"

@implementation BuyTicketDestinationsTableViewController (Events)

- (IBAction)doneButtonTouchUpInside:(id)sender {
	[searchableTableViewController dismissSearch];
}

- (IBAction)segmentedControlValueChanged:(id)sender {
	switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
		case allStationsSelected:
			searchableTableViewController.tableViewDataSource = allStationsDataSource;
			searchableTableViewController.tableViewDelegate = allStationsTableViewDelegate;
			searchableTableViewController.showSearchBar = YES;
			self.editingToolbar.hidden = YES;
			[searchableTableViewController.tableView reloadData];
			
			// Save new default
			[[NSUserDefaults standardUserDefaults] setInteger:allStationsSelected forKey:kDestinationsTablesSwitchSelectionIndexKey];
			break;
		case favoriteStationsSelected:
			searchableTableViewController.tableViewDataSource = favoriteStationsTableViewDataSource;
			searchableTableViewController.tableViewDelegate = favoriteStationsTableViewDelegate;
			searchableTableViewController.showSearchBar = NO;
			self.editingToolbar.hidden = NO;
			[searchableTableViewController.tableView reloadData];
			
			// Save new default
			[[NSUserDefaults standardUserDefaults] setInteger:favoriteStationsSelected forKey:kDestinationsTablesSwitchSelectionIndexKey];
			break;
		default:
			break;
	}
}

- (IBAction)addButtonTouchUpInside:(id)sender {
	// Reset the favourite station view controller before displaying it
	[addFavoriteStationViewController prepare];
	
	[self presentModalViewController:addFavoriteStationViewController animated:YES];
}

- (IBAction)cancelAddFavoriteStationButtonTouchUpInside:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

@end