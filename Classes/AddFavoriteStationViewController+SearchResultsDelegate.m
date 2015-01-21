//
//  AddFavoriteStationViewController+SearchResultsDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 28/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "AddFavoriteStationViewController+SearchResultsDelegate.h"

#import "SearchResultsDataSourceProtocol.h"

#import "Station.h"
#import "iTicketAppDelegate.h"
#import "StationsDataSourceProtocol.h"
#import "BuyTicketDestinationsTableViewController.h"
#import "SearchableTableViewController.h"

NSString *kAddFavoriteSearchResultsCellIdentifier = @"AddFavoriteSearchResultsCellIdentifier";

@implementation AddFavoriteStationViewController (SearchResultsDelegate)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAddFavoriteSearchResultsCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kAddFavoriteSearchResultsCellIdentifier];
	}
	
	cell.text = ((Station *)[(id <SearchResultsDataSource>)tableView.dataSource searchResultForRow:indexPath.row]).name;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSMutableArray *favouriteStationIdentifiers = [[[NSUserDefaults standardUserDefaults]
													objectForKey:kFavouriteDestinationsKey] mutableCopy];
	
	[favouriteStationIdentifiers addObject:((Station *)[(id <SearchResultsDataSource>)tableView.dataSource searchResultForRow:indexPath.row]).identifier];
	[[NSUserDefaults standardUserDefaults] setObject:favouriteStationIdentifiers forKey:kFavouriteDestinationsKey];
	[favouriteStationIdentifiers release];
	
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
	[viewController.searchableTableViewController.tableView reloadData];
}

@end
