//
//  TimetableOverviewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 9/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "TimetableOverviewController.h"

#import "UIFactory.h"
#import "TimeButton.h"
#import "Connection.h"
#import "Connections.h"

NSString *kTimetableOverviewNib = @"TimetableOverview";

@interface TimetableOverviewController (PrivateMethods)

//- (void)loadConnectionsWithTime:(NSDate *)aDate;
- (void)loadConnectionsWithTime:(NSUInteger)aSection;

@end


@implementation TimetableOverviewController

@synthesize timeButton;
@synthesize toolbar;
@synthesize blackLayer;
@synthesize pickerView;
@synthesize time;
@synthesize datePicker;
@synthesize loadedConnections;
@synthesize tableBlackLayer;
@synthesize tableView;

- (void)viewDidLoad {
	[super viewDidLoad];

	self.navigationItem.title = NSLocalizedString(@"Timetable",@"Title of the timetable navigation item");
	
	// Set the time
	self.time = [NSDate date];
	[datePicker setDate:time animated:NO];
	[timeButton setTime:time];
	
	self.loadedConnections = [NSMutableArray array];
	
	[self loadConnectionsWithTime:1];
}

- (void)dealloc {
	[timeButton release];
	[toolbar release];
	[blackLayer release];
	[pickerView release];
	[time release];
	[datePicker release];
	[loadedConnections release];
	[tableBlackLayer release];
	[tableView release];
	
    [super dealloc];
}

// Private Methods

//- (void)loadConnectionsWithTime:(NSDate *)aDate;
- (void)loadConnectionsWithTime:(NSUInteger)aSection {
	tableBlackLayer.hidden = NO;
	
	NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:2
														 target:self
													   selector:@selector(connectionsLoaded:)
													   userInfo:[NSNumber numberWithInt:aSection]
														repeats:NO];
}

- (void)connectionsLoaded:(NSTimer *)aTimer {
	tableBlackLayer.hidden = YES;
	
	NSUInteger baseIndex = [[aTimer userInfo] unsignedIntegerValue] * 5;
	[loadedConnections addObject:[[Connections sharedConnections].connectionsArray objectAtIndex:baseIndex]];
	[loadedConnections addObject:[[Connections sharedConnections].connectionsArray objectAtIndex:baseIndex+1]];
	[loadedConnections addObject:[[Connections sharedConnections].connectionsArray objectAtIndex:baseIndex+2]];
	[loadedConnections addObject:[[Connections sharedConnections].connectionsArray objectAtIndex:baseIndex+3]];
	[loadedConnections addObject:[[Connections sharedConnections].connectionsArray objectAtIndex:baseIndex+4]];
	
	[tableView reloadData];
	[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

@end
