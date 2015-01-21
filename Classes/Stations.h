//
//  Stations.h
//  iTicket
//
//  Created by Matteo Cortonesi on 19/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Stations : NSObject {
	// key: station's ID, value: station object
	NSMutableDictionary *stationsDictionary;
	
	// key: first letter of station's name, value: array of all station
	// objects starting with that first letter.
	NSMutableDictionary *indexedStationsDictionary;
	
	// Array of all the first letters of stations' names
	NSMutableArray *stationsFirstLetterArray;
	
	// An array containing all stations
	NSMutableArray *stationsArray;
}

@property (nonatomic, retain) NSMutableDictionary *stationsDictionary;
@property (nonatomic, retain) NSMutableDictionary *indexedStationsDictionary;
@property (nonatomic, retain) NSMutableArray *stationsFirstLetterArray;
@property (nonatomic, retain) NSMutableArray *stationsArray;

// Shared instance of stations
+ (Stations *)sharedStations;

@end
