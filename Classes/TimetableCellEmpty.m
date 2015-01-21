//
//  TimetableCellEmpty.m
//  iTicket
//
//  Created by Matteo Cortonesi on 14/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "TimetableCellEmpty.h"


@implementation TimetableCellEmpty

@synthesize textLabel;
@synthesize text;
@synthesize activityIndicator;

- (void)setText:(NSString *)someText {
	if (![text isEqualToString:someText]) {
		[text release];
		text = [someText copy];
		
		textLabel.text = text;
	}
}

- (void)dealloc {
	[textLabel release];
	[activityIndicator release];
	[text release];
	
    [super dealloc];
}

@end
