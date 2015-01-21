//
//  AddFavoriteStationDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 28/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "AddFavoriteStationDelegate.h"

#import "StationsDataSourceProtocol.h"

#import "Stations.h"
#import "Station.h"

#import "iTicketAppDelegate.h"

#import "BuyTicketDestinationsTableViewController.h"
#import "SearchableTableViewController.h"
#import "AddFavoriteStationViewController.h"

NSString *kAddFavoriteAllStationsCellIdentifier = @"AddFavoriteAllStationsCellIdentifier";

@implementation AddFavoriteStationDelegate

@synthesize viewController;

- (id)initWithViewController:(UIViewController *)aViewController {
	if (self = [self init]) {
		self.viewController = aViewController;
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAddFavoriteAllStationsCellIdentifier];
	if (cell == nil) {
		// We auto release the cell beacause we are the owner and we don't need it anymore
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kAddFavoriteAllStationsCellIdentifier] autorelease];
	}
	
	cell.text = [(id <StationsDataSource>)tableView.dataSource stationForIndexPath:indexPath].name;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSMutableArray *favoriteStationIdentifiers = [[[NSUserDefaults standardUserDefaults]
													objectForKey:kFavouriteDestinationsKey] mutableCopy];
	
	[favoriteStationIdentifiers addObject:[(id <StationsDataSource>)tableView.dataSource stationForIndexPath:indexPath].identifier];
	[[NSUserDefaults standardUserDefaults] setObject:favoriteStationIdentifiers forKey:kFavouriteDestinationsKey];
	[favoriteStationIdentifiers release];
		
	[[viewController parentViewController] dismissModalViewControllerAnimated:YES];
	[[(AddFavoriteStationViewController *)viewController viewController].searchableTableViewController.tableView reloadData];
}

@end