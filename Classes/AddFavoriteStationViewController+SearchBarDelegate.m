//
//  AddFavoriteStationViewController+SearchBarDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 28/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "AddFavoriteStationViewController+SearchBarDelegate.h"

#import "SearchableTableViewController.h"
#import "Stations.h"
#import "Station.h"

@implementation AddFavoriteStationViewController (SearchBarDelegate)

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	// Show the cancel button of the search bar
	searchBar.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	// Hide the cancel button of the search bar
	searchBar.showsCancelButton = NO;
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

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchableTableViewController dismissSearch];
}

@end
