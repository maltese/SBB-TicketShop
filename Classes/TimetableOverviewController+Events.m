//
//  TimetableOverviewController+Events.m
//  iTicket
//
//  Created by Matteo Cortonesi on 11/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "TimetableOverviewController+Events.h"

#import "TimeButton.h"

#define kToolbarSlideUpAnimationDuration 0.35

NSString *kDoneSettingTimeAnimation = @"DoneSettingTime";

@implementation TimetableOverviewController (Events)

- (IBAction)timeButtonTouchUpInside:(id)sender {
#define kPickerViewYOffsetWhenActive 108
	
	// Disable the buttons
	timeButton.userInteractionEnabled = NO;
	
	// Show the black layer
	blackLayer.hidden = NO;
	
	// Bring to front the layers
	[self.view bringSubviewToFront:blackLayer];
	[self.view bringSubviewToFront:pickerView];
	[self.view bringSubviewToFront:toolbar];
	
	// Start animation
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kToolbarSlideUpAnimationDuration];
	
	// Slide up the toolbar
	CGRect frame = toolbar.frame;
	frame.origin = CGPointMake(0, -1);
	toolbar.frame = frame;
	
	// Slide up the picker view
	frame = pickerView.frame;
	frame.origin = CGPointMake(0,kPickerViewYOffsetWhenActive);
	pickerView.frame = frame;
	
	// Make the black layer visible
	blackLayer.alpha = 0.8;
	
	[UIView commitAnimations];
}

- (IBAction)datePickerValueChanged:(id)sender {
	self.time = datePicker.date;
	[timeButton setTime:time];
}

- (IBAction)doneButtonTouchUpInside:(id)sender {
#define kToolbarYOffsetBottom 324
#define kPickerViewYOffsetWhenUnactive 367
		
	// Start animation
	[UIView beginAnimations:kDoneSettingTimeAnimation context:NULL];
	[UIView setAnimationDuration:kToolbarSlideUpAnimationDuration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	// Slide down the toolbar
	CGRect frame = toolbar.frame;
	frame.origin = CGPointMake(0, kToolbarYOffsetBottom);
	toolbar.frame = frame;
	
	// Slide down the picker view
	frame = pickerView.frame;
	frame.origin = CGPointMake(0,kPickerViewYOffsetWhenUnactive);
	pickerView.frame = frame;
	
	// Make the black layer invisible
	blackLayer.alpha = 0.0;
	
	[UIView commitAnimations];
	
	self.loadedConnections = [NSMutableArray array];
	[self loadConnectionsWithTime:3];
}

- (void)animationDidStop:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
	if ([animationID isEqualToString:kDoneSettingTimeAnimation]) {
		// Re-enable the buttons
		timeButton.userInteractionEnabled = YES;
		
		// Hide the black layer
		blackLayer.hidden = YES;
	}
}

@end
