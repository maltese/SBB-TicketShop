//
//  Connection.m
//  iTicket
//
//  Created by Matteo Cortonesi on 13/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "Connection.h"

NSString *kDepartureTimeKey = @"departureTime";
NSString *kArrivalTimeKey = @"arrivalTime";
NSString *kChangesKey = @"changes";

@implementation Connection

@synthesize departureHour;
@synthesize departureMinute;
@synthesize arrivalHour;
@synthesize arrivalMinute;
@synthesize changes;

- (id)initWithDictionary:(NSDictionary *)aDictionary {
	if (self = [self init]) {
		NSString *departureTime = [aDictionary objectForKey:kDepartureTimeKey];
		NSString *arrivalTime = [aDictionary objectForKey:kArrivalTimeKey];
		self.changes = [aDictionary objectForKey:kChangesKey];

		NSArray *departureFields = [departureTime componentsSeparatedByString:@":"];
		NSArray *arrivalFields = [arrivalTime componentsSeparatedByString:@":"];
		
		self.departureHour = [[departureFields objectAtIndex:0] stringByAppendingString:@"."];
		self.departureMinute = [departureFields objectAtIndex:1];
		
		self.arrivalHour = [[arrivalFields objectAtIndex:0] stringByAppendingString:@"."];
		self.arrivalMinute = [arrivalFields objectAtIndex:1];
	}
	return self;
}

- (void)dealloc {
	[departureHour release];
	[departureMinute release];
	[arrivalHour release];
	[arrivalMinute release];
	[changes release];
	
	[super dealloc];
}

@end
