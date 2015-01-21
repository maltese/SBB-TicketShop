//
//  TimetableCell.m
//  iTicket
//
//  Created by Matteo Cortonesi on 12/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "TimetableCell.h"

#import "Connections.h"
#import "Connection.h"

@implementation TimetableCell

@synthesize departureHourLabel;
@synthesize departureMinuteLabel;
@synthesize arrivalHourLabel;
@synthesize arrivalMinuteLabel;
@synthesize changesLabel;
@synthesize connection;

- (void)dealloc {
	[departureHourLabel release];
	[departureMinuteLabel release];
	[arrivalHourLabel release];
	[arrivalMinuteLabel release];
	[changesLabel release];
	
    [super dealloc];
}

- (void)setConnection:(Connection*)aConnection {
	if (connection != aConnection) {
		[connection release];
		connection = [aConnection retain];
		
		departureHourLabel.text = aConnection.departureHour;
		departureMinuteLabel.text = aConnection.departureMinute;
		
		arrivalHourLabel.text = aConnection.arrivalHour;
		arrivalMinuteLabel.text = aConnection.arrivalMinute;
		
		changesLabel.text = aConnection.changes;
	}
}


@end
