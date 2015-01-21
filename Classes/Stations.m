//
//  Stations.m
//  iTicket
//
//  Created by Matteo Cortonesi on 19/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "Stations.h"

#import "Station.h"

@interface Stations (PrivateMethods)

- (void)loadData;

@end

NSString *kStationsFileName = @"Stations";

@implementation Stations

@synthesize stationsDictionary;
@synthesize indexedStationsDictionary;
@synthesize stationsFirstLetterArray;
@synthesize stationsArray;

// Singleton pattern. One collection for the entire application
static Stations *sharedStationsInstance = nil;

+ (Stations *)sharedStations {
	// Lock the section of code for use by a single thread
	// This avoids creating multiple instances of sharedStations
	@synchronized(self) {
		if (sharedStationsInstance == nil) {
			// Assignment not done here
			[[self alloc] init];
		}
	}
	return sharedStationsInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedStationsInstance == nil) {
			sharedStationsInstance = [super allocWithZone:zone];
			return sharedStationsInstance; // Assignment and return on first allocation
		}
	}
	return nil; // On subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

- (id)retain {
	return self;
}

- (unsigned)retainCount {
	return UINT_MAX; // Denotes an object that cannot be released
}

- (void)release {
	// Do nothing
}

- (id)autorelease {
	return self;
}

- (id)init {
	if (self = [super init]) {
		[self loadData];
	}
	return self;
}

- (void)dealloc {
	[stationsDictionary release];
	[indexedStationsDictionary release];
	[stationsFirstLetterArray release];
	[stationsArray release];
	
	[super dealloc];
}

- (void)loadData {
	// Create the empty data structures
	self.stationsDictionary = [NSMutableDictionary dictionary];
	self.indexedStationsDictionary = [NSMutableDictionary dictionary];
	self.stationsArray = [NSMutableArray array];
	
	// Get the path of the stations file
	NSString *path = [[NSBundle mainBundle] pathForResource:kStationsFileName ofType:@"plist"];
	// Load it into an array
	NSArray *stations = [[NSArray alloc] initWithContentsOfFile:path];
	
	// For each entry in the array
	for (NSDictionary *stationDictionary in stations) {
		// Create a station
		Station *station = [[Station alloc] initWithDictionary:stationDictionary];
		// Store it into the stations dictionary
		[stationsDictionary setObject:station forKey:station.identifier];
		// Store the station in the stations array
		[stationsArray addObject:station];
		
		// Create the indexedStationsDictionary, see header file for description
		NSString *firstLetter = [station.name substringToIndex:1];
		NSMutableArray *existingArray;
		if (existingArray = [indexedStationsDictionary objectForKey:firstLetter]) {
			[existingArray addObject:station];
		} else {
			NSMutableArray *tempArray = [NSMutableArray arrayWithObject:station];
			[indexedStationsDictionary setObject:tempArray forKey:firstLetter];
		}
		
		// Release station beacause it is retained by the collections
		[station release];
	}
	// Release stations because we don't need it anymore
	[stations release];
	
	// Create and sort the array that contains the first letter of each station
	// (no duplicates)
	self.stationsFirstLetterArray = (NSMutableArray *) [[indexedStationsDictionary allKeys]
									 sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
	// Sort the indexedStationsDictionary
	for (NSString *key in indexedStationsDictionary) {
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
																	 ascending:YES
																		selector:@selector(localizedCaseInsensitiveCompare:)];
		[[indexedStationsDictionary objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		// release sortDescriptor, we don't need it anymore
		[sortDescriptor release];
	}
}

@end
