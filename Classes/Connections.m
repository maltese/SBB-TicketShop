//
//  Connections.m
//  iTicket
//
//  Created by Matteo Cortonesi on 13/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "Connections.h"

#import "Connection.h"

@interface Connections (PrivateMethods)

- (void)loadData;

@end

NSString *kConnectionsFileName = @"Connections";

@implementation Connections

@synthesize connectionsArray;

static Connections *sharedConnectionsInstance = nil;

+ (Connections *)sharedConnections {
	// Lock this section of code for use by a single thread
	// This avoids creating multiple instances of sharedConnections
	@synchronized(self) {
		if (sharedConnectionsInstance == nil) {
			// Assignment not done here
			[[self alloc] init];
		}
	}
	return sharedConnectionsInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedConnectionsInstance == nil) {
			sharedConnectionsInstance = [super allocWithZone:zone];
			return sharedConnectionsInstance; // Assignment and return on first allocation
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
	[connectionsArray release];
	
	[super dealloc];
}

- (void)loadData {
	// Create the empty data structure
	self.connectionsArray = [NSMutableArray array];
	
	// Get the path of the stations file
	NSString *path = [[NSBundle mainBundle] pathForResource:kConnectionsFileName ofType:@"plist"];
	// Load it into an array
	NSArray *connections = [[NSArray alloc] initWithContentsOfFile:path];
	
	// For each entry in the array
	for (NSDictionary *connectionDictionary in connections) {
		// Create a connection
		Connection *connection = [[Connection alloc] initWithDictionary:connectionDictionary];
		// Store the connection in the connections array
		[connectionsArray addObject:connection];
				
		// Release connection beacause it is retained by the array
		[connection release];
	}
	// Release connections because we don't need it anymore
	[connections release];
}

@end
