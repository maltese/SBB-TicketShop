//
//  NearbyStationCell.m
//  iTicket
//
//  Created by Matteo Cortonesi on 24/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "NearbyStationCell.h"

#import "Station.h"

@implementation NearbyStationCell

@synthesize stationNameLabel;
@synthesize distanceLabel;
@synthesize station;

- (void)dealloc {
	[stationNameLabel release];
	[distanceLabel release];
	[station release];
	
    [super dealloc];
}

- (void)setStation:(Station *)aStation {
	if (station != aStation) {
		[station release];
		station = [aStation retain];
	}
	stationNameLabel.text = station.name;
	
	// Just for demo purposes
	if ([aStation.name isEqualToString:@"Bern"]) {
		distanceLabel.text = @"1.7";
	} else if ([aStation.name isEqualToString:@"Bern Wankdorf"]) {
		distanceLabel.text = @"2.4";
	} else if ([aStation.name isEqualToString:@"Bern Ausserholligen"]) {
		distanceLabel.text = @"2.6";
	} else if ([aStation.name isEqualToString:@"Bern Stöckacker"]) {
		distanceLabel.text = @"2.8";
	} else if ([aStation.name isEqualToString:@"Bern Weissenbühl"]) {
		distanceLabel.text = @"2.9";
	} else if ([aStation.name isEqualToString:@"Wabern bei Bern"]) {
		distanceLabel.text = @"3.1";
	}
}

@end
