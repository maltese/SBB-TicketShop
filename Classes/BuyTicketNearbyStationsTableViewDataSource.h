//
//  BuyTicketNearbyStationsTableViewDataSource.h
//  iTicket
//
//  Created by Matteo Cortonesi on 20/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StationsDataSourceProtocol.h"

@interface BuyTicketNearbyStationsTableViewDataSource : NSObject <UITableViewDataSource, StationsDataSource> {

}

@end
