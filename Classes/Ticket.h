//
//  Ticket.h
//  iTicket
//
//  Created by Matteo Cortonesi on 27/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Station;

typedef enum {
	TicketClassFirst,
	TicketClassSecond
} TicketClass;

typedef enum {
	TicketFareFull,
	TicketFareHalf
} TicketFare;

typedef enum {
	TicketDirectionOneWay,
	TicketDirectionRoundTrip
} TicketDirection;

@interface Ticket : NSObject {
	Station *departureStation;
	Station *destinationStation;
	NSDate *validityDate;
	TicketClass ticketClass;
	TicketFare ticketFare;
	TicketDirection ticketDirection;
	NSNumber *ticketPrice;
	// The qrCode image data
	NSData *qrCode;
}

@property (nonatomic, retain) Station *departureStation;
@property (nonatomic, retain) Station *destinationStation;
@property (nonatomic, retain) NSDate *validityDate;
@property (nonatomic, assign) TicketClass ticketClass;
@property (nonatomic, assign) TicketFare ticketFare;
@property (nonatomic, assign) TicketDirection ticketDirection;
@property (nonatomic, retain) NSNumber *ticketPrice;
@property (nonatomic, retain) NSData *qrCode;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)encode;

@end
