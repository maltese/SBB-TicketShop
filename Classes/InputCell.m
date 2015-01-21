//
//  InputCell.m
//  iTicket
//
//  Created by Matteo Cortonesi on 3/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "InputCell.h"


@implementation InputCell

@synthesize textField;

- (void)dealloc {
	[textField release];
	
    [super dealloc];
}


@end
