//
//  TimetableOverviewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 9/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kTimetableOverviewNib;
extern NSString *kTimetableLabelNib;

@class TimeButton;

@interface TimetableOverviewController : UIViewController {	
	// View
	TimeButton *timeButton;
	UIToolbar *toolbar;
	UIView *blackLayer;
	UIView *tableBlackLayer;
	UIDatePicker *datePicker;
	UIView *pickerView;
	UITableView *tableView;
	
	// Model
	NSDate *time;
	NSMutableArray *loadedConnections;
}

@property (nonatomic, retain) IBOutlet TimeButton *timeButton;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIView *blackLayer;
@property (nonatomic, retain) IBOutlet UIView *tableBlackLayer;
@property (nonatomic, retain) IBOutlet UIView *pickerView;
@property (nonatomic, retain) NSDate *time;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) NSMutableArray *loadedConnections;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
