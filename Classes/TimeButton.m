//
//  TimeButton.m
//  iTicket
//
//  Created by Matteo Cortonesi on 11/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "TimeButton.h"


@implementation TimeButton

- (void)awakeFromNib {
	UIImage *background = [[UIImage imageNamed:@"TimeButton.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:0];
	[self setBackgroundImage:background forState:UIControlStateNormal];
}

- (void)dealloc {
	
	[super dealloc];
}

- (void)setTime:(NSDate *)theTime {
	NSString *timeButtonTitle = NSLocalizedString(@"Departure",@"Prefix of the button displayed in the timetable section");
	timeButtonTitle = [timeButtonTitle stringByAppendingString:@": "];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	timeButtonTitle = [timeButtonTitle stringByAppendingString:[dateFormatter stringFromDate:theTime]];
	[self setTitle:timeButtonTitle forState:UIControlStateNormal];
	[self setTitle:timeButtonTitle forState:UIControlStateDisabled];
	[self setTitle:timeButtonTitle forState:UIControlStateHighlighted];
	[dateFormatter release];	
}

@end
