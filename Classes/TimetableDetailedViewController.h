//
//  TimetableDetailedViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 16/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kTimetableDetailedNib;

enum TableSections {
	StationsStopsSection,
	DurationSection,
	ShowIntermediateStops
};

enum CellType {
	DepartureCell,
	TrackCell,
	IntermediateArrivalCell,
	IntermediateDepartureCell,
	ArrivalCell,
	TrackWithStopCell
};

@interface TimetableDetailedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView *tableView;
	UIActivityIndicatorView *activityIndicator;
	UIView *headerView;
	
	NSArray *sections;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UIView *headerView;
@property (nonatomic, retain) NSArray *sections;

@end
