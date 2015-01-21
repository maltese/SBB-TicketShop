//
//  UIFactory.m
//  iTicket
//
//  Created by Matteo Cortonesi on 21/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "UIFactory.h"


@implementation UIFactory

+ (id)newUIObjectFromNib:(NSString *)nibName {
	// Load the nib file that contains the ui object
	NSArray *contents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
	// Return the second object which should correspond the object
	// We need to retain it (see documentation of loadNibNamed)
	return [[contents objectAtIndex:0] retain];
}

@end
