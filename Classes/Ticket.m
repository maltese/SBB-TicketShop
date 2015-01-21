//
//  Ticket.m
//  iTicket
//
//  Created by Matteo Cortonesi on 27/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "Ticket.h"

#import "Station.h"

@implementation Ticket

@synthesize departureStation;
@synthesize destinationStation;
@synthesize validityDate;
@synthesize ticketClass;
@synthesize ticketFare;
@synthesize ticketDirection;
@synthesize ticketPrice;
@synthesize qrCode;

NSString *kDepartureStationKey = @"departureStation";
NSString *kDestinationStationKey = @"destinationStation";
NSString *kValidityDateKey = @"validityDate";
NSString *kTicketClassKey = @"ticketClass";
NSString *kTicketFareKey = @"ticketFare";
NSString *kTicketDirectionKey = @"ticketDirection";
NSString *kTicketPriceKey = @"ticketPrice";
NSString *kQrCodeKey = @"qrCode";

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (self = [self init]) {
		self.departureStation = [Station stationWithDictionary:
							[dictionary objectForKey:kDepartureStationKey]];
		self.destinationStation = [Station stationWithDictionary:
							[dictionary objectForKey:kDestinationStationKey]];
		self.validityDate = [dictionary objectForKey:kValidityDateKey];
		self.ticketClass = [[dictionary objectForKey:kTicketClassKey] integerValue];
		self.ticketFare = [[dictionary objectForKey:kTicketFareKey] integerValue];
		self.ticketDirection = [[dictionary objectForKey:kTicketDirectionKey] integerValue];
		self.ticketPrice = [NSNumber numberWithFloat:[[dictionary objectForKey:kTicketPriceKey] floatValue]];
//		self.qrCode = [dictionary objectForKey:kQrCodeKey]; // TEMPORARY
	}
	return self;
}

- (NSDictionary *)encode {
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setObject:[departureStation encode] forKey:kDepartureStationKey];
	[dictionary setObject:[destinationStation encode] forKey:kDestinationStationKey];
	[dictionary setObject:validityDate forKey:kValidityDateKey];
	[dictionary setObject:[NSNumber numberWithInt:ticketClass]
				   forKey:kTicketClassKey];
	[dictionary setObject:[NSNumber numberWithInt:ticketFare]
				   forKey:kTicketFareKey];
	[dictionary setObject:[NSNumber numberWithInt:ticketDirection]
				   forKey:kTicketDirectionKey];
	[dictionary setObject:[NSNumber numberWithFloat:[ticketPrice floatValue]]
				   forKey:kTicketPriceKey];
//	[dictionary setObject:qrCode forKey:qrCode]; // TEMPORARY
	
	return dictionary;
}

- (void)dealloc {
	[departureStation release];
	[destinationStation release];
	[validityDate release];
	[ticketPrice release];
	[qrCode release];
	
	[super dealloc];
}

@end
