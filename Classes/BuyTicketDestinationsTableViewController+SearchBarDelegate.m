//
//  BuyTicketDestinationsTableViewController+SearchBarDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDestinationsTableViewController+SearchBarDelegate.h"

#import "SearchableTableViewController.h"
#import "Stations.h"
#import "Station.h"

@implementation BuyTicketDestinationsTableViewController (SearchBarDelegate)

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	// Add the done button to the navigation item
	[self.navigationItem setRightBarButtonItem:doneButton animated:YES];
	
	// Setup animation
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:SEARCH_BAR_ANIMATION_DURATION_SECONDS];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)]; 
	
	// Push up the searchable table view
	UIView *tempView = [searchableTableViewController view];
	tempView.frame = CGRectOffset(tempView.frame, 0, -kToolbarHeight);
	
	[UIView commitAnimations];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	// Remove the done button to the navigation item
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
	
	// Setup animation
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:SEARCH_BAR_ANIMATION_DURATION_SECONDS];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)]; 
	
	// Push down the searchable table view
	UIView *tempView = [searchableTableViewController view];
	tempView.frame = CGRectOffset(tempView.frame, 0, kToolbarHeight);
	
	[UIView commitAnimations];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	// If the user typed at least one character in the search bar
	if (![searchText isEqualToString:@""]) {
		self.searchResults = nil;
		self.searchResults = [NSMutableArray array];
		// For each station
		for (Station *station in [[Stations sharedStations] stationsArray]) {
			// If searchText is a case insensitive prefix of the station's name
			if ([station.name compare:searchText
				 options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch
				 range:NSMakeRange(0, [searchText length])] == NSOrderedSame) { 
				// Add the station to the search results 
				[(NSMutableArray *)self.searchResults addObject:station];
			}
		}
		// Reload the data of the search results table view
		[searchableTableViewController.searchResultsTableView reloadData];
	}
}

@end
