//
//  BuyTicketNearbyStationsTableViewDataSource.m
//  iTicket
//
//  Created by Matteo Cortonesi on 20/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketNearbyStationsTableViewDataSource.h"

#import "Stations.h"
#import "Station.h"


@implementation BuyTicketNearbyStationsTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Just for demo purposes
	return 6;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return NSLocalizedString(@"Stations within 5 km",@"Displayed in the departures screen of buy ticket section");
}

// StationsDataSource protocol:
- (Station *)stationForIndexPath:(NSIndexPath *)indexPath {
	// Just for demo purposes
	NSArray *stationsArray = [[Stations sharedStations] stationsArray];
	switch (indexPath.row) {
		case 0:
			return [stationsArray objectAtIndex:8];
			break;
		case 1:
			return [stationsArray objectAtIndex:95];
			break;
		case 2:
			return [stationsArray objectAtIndex:96];
			break;
		case 3:
			return [stationsArray objectAtIndex:97];
			break;
		case 4:
			return [stationsArray objectAtIndex:98];
			break;
		case 5:
			return [stationsArray objectAtIndex:99];
			break;
	}
	return nil;
}

@end
