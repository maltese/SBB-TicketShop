//
//  AllStationsDataSource.h
//  iTicket
//
//  Created by Matteo Cortonesi on 17/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StationsDataSourceProtocol.h"

@class Station;

@interface AllStationsDataSource : NSObject <UITableViewDataSource, StationsDataSource> {
	
}

@end