//
//  NearbyStationCell.h
//  iTicket
//
//  Created by Matteo Cortonesi on 24/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Station;

@interface NearbyStationCell : UITableViewCell {
	// Model
	Station *station;
	
	// User Interface
	UILabel *stationNameLabel;
	UILabel *distanceLabel;
}

@property (nonatomic, retain, readonly) IBOutlet UILabel *stationNameLabel;
@property (nonatomic, retain, readonly) IBOutlet UILabel *distanceLabel;

@property (nonatomic, retain) Station *station;

@end
