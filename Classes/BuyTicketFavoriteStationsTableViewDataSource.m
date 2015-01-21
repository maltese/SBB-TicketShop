//
//  BuyTicketFavouriteStationsTableViewDataSource.m
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketFavoriteStationsTableViewDataSource.h"

#import "Station.h"
#import "Stations.h"
#import "iTicketAppDelegate.h"

@implementation BuyTicketFavoriteStationsTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// One more row because of the translucent tab bar.
	return [[[NSUserDefaults standardUserDefaults] objectForKey:kFavouriteDestinationsKey] count] + 1;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return NSLocalizedString(@"Favourite destinations",@"Displayed in the destinations screen of buy ticket section");
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSMutableArray *favoriteStationIdentifiers = [[[NSUserDefaults standardUserDefaults]
												   objectForKey:kFavouriteDestinationsKey] mutableCopy];
	
	NSNumber *tempStation = [[favoriteStationIdentifiers objectAtIndex:fromIndexPath.row] retain];
	[favoriteStationIdentifiers removeObjectAtIndex:fromIndexPath.row];
	[favoriteStationIdentifiers insertObject:tempStation atIndex:toIndexPath.row];
	[tempStation release];
	
	[[NSUserDefaults standardUserDefaults] setObject:favoriteStationIdentifiers forKey:kFavouriteDestinationsKey];
	[favoriteStationIdentifiers release];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSMutableArray *favoriteStationIdentifiers = [[[NSUserDefaults standardUserDefaults]
													   objectForKey:kFavouriteDestinationsKey] mutableCopy];
		[favoriteStationIdentifiers removeObjectAtIndex:indexPath.row];
		[[NSUserDefaults standardUserDefaults] setObject:favoriteStationIdentifiers forKey:kFavouriteDestinationsKey];
		[favoriteStationIdentifiers release];
		
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
	}
}

// Can't edit the last row
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == [self tableView:tableView numberOfRowsInSection:1] - 1) {
		return NO;
	} else {
		return YES;
	}	
	
}

// StationsDataSource protocol:
- (Station *)stationForIndexPath:(NSIndexPath *)indexPath {
	NSNumber *identifier = [[[NSUserDefaults standardUserDefaults] objectForKey:kFavouriteDestinationsKey]
							objectAtIndex:indexPath.row];
	
	return [[[Stations sharedStations] stationsDictionary] objectForKey:identifier];
}

@end
