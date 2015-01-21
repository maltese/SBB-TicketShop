//
//  DetailedViewCell.m
//  iTicket
//
//  Created by Matteo Cortonesi on 17/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "DetailedViewCell.h"


@implementation DetailedViewCell

@synthesize stationNameLabel;
@synthesize timeLabel;
@synthesize trackLabel;
@synthesize commentsLabel;
@synthesize trackImage;

- (void)dealloc {
	[stationNameLabel release];
	[timeLabel release];
	[trackLabel release];
	[commentsLabel release];
	[trackImage release];
	
    [super dealloc];
}


@end
