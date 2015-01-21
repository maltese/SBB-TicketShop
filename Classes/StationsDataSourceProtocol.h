//
//  StationsDataSourceProtocol.h
//  iTicket
//
//  Created by Matteo Cortonesi on 20/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Station.h"

@protocol StationsDataSource

// Standardized way of asking a data source for a station object
- (Station *)stationForIndexPath:(NSIndexPath *)indexPath;

@end
