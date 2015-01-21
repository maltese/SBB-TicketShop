//
//  AllStationsDataSource.m
//  iTicket
//
//  Created by Matteo Cortonesi on 17/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "AllStationsDataSource.h"


#import "Stations.h"
#import "Station.h"

@implementation AllStationsDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[[Stations sharedStations] stationsFirstLetterArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSString *firstLetter = [[[Stations sharedStations] stationsFirstLetterArray] objectAtIndex:section];
	return [[[[Stations sharedStations] indexedStationsDictionary] objectForKey:firstLetter] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	return [[Stations sharedStations] stationsFirstLetterArray];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[[Stations sharedStations] stationsFirstLetterArray] objectAtIndex:section];
}


// StationsDataSource protocol:
- (Station *)stationForIndexPath:(NSIndexPath *)indexPath {
	NSString *firstLetter = [[[Stations sharedStations] stationsFirstLetterArray] objectAtIndex:indexPath.section];
	return [[[[Stations sharedStations] indexedStationsDictionary] objectForKey:firstLetter] objectAtIndex:indexPath.row];
}

@end
