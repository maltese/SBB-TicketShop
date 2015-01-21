//
//  TimetableOverviewController+Events.h
//  iTicket
//
//  Created by Matteo Cortonesi on 11/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TimetableOverviewController.h"

@interface TimetableOverviewController (Events)

- (IBAction)timeButtonTouchUpInside:(id)sender;

- (IBAction)datePickerValueChanged:(id)sender;

- (IBAction)doneButtonTouchUpInside:(id)sender;

@end
