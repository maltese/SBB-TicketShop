//
//  OneTapCell.m
//  iTicket
//
//  Created by Matteo Cortonesi on 18/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "OneTapCell.h"

#import "Station.h"
#import "Ticket.h"

@implementation OneTapCell

@synthesize departureStationLabel;
@synthesize destinationStationLabel;
@synthesize journeyImageView;
@synthesize classImageView;
@synthesize fareImageView;
@synthesize fareLabel;
@synthesize classLabel;
@synthesize ticket;

- (void)setTicket:(Ticket *)aTicket {
	if (aTicket != ticket) {
		[ticket release];
		ticket = [aTicket retain];
	}
	departureStationLabel.text = aTicket.departureStation.name;
	destinationStationLabel.text = aTicket.destinationStation.name;
	if (aTicket.ticketDirection == TicketDirectionOneWay) {
		journeyImageView.image = [UIImage imageNamed:@"OneWayVertical.png"];
	} else { // TicketDirectionRoundTrip
		journeyImageView.image = [UIImage imageNamed:@"RoundTripVertical.png"];
	}
	if (aTicket.ticketClass == TicketClassFirst) {
		classImageView.image = [UIImage imageNamed:@"FirstClass.png"];
	} else { // TicketClassSecond
		classImageView.image = [UIImage imageNamed:@"SecondClass.png"];
	}
	if (aTicket.ticketFare == TicketFareFull) {
		fareImageView.image = [UIImage imageNamed:@"FullFare.png"];
	} else { // TicketFareHalf
		fareImageView.image = [UIImage imageNamed:@"HalfFare.png"];
	}
}

- (void)dealloc {
	[departureStationLabel release];
	[destinationStationLabel release];
	[journeyImageView release];
	[classImageView release];
	[fareImageView release];
	[ticket release];
	[fareLabel release];
	[classLabel release];
	
    [super dealloc];
}


@end
