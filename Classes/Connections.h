//
//  Connections.h
//  iTicket
//
//  Created by Matteo Cortonesi on 13/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Connections : NSObject {
	NSMutableArray *connectionsArray;
}

@property (nonatomic, retain) NSMutableArray *connectionsArray;

// Shared instance of connections
+ (Connections *)sharedConnections;

- (void)loadData;

@end
