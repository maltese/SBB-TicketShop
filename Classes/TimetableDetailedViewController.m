//
//  TimetableDetailedViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 16/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "TimetableDetailedViewController.h"

#import "iTicketAppDelegate.h"
#import "UIFactory.h"
#import "DetailedViewCell.h"

NSString *kTimetableDetailedNib = @"TimetableDetailed";
NSString *kTimetableDetailedViewFileName = @"TimetableDetailedView";
NSString *kTimetableDetailedView2FileName = @"TimetableDetailedView2";
NSString *kTimetableDetailedView3FileName = @"TimetableDetailedView3";

NSString *kTimetableDetailedViewNormalCell = @"normalCell";
NSString *kDepartureCellIdentifier = @"DepartureCell";
NSString *kDepartureCellNib = @"DepartureCell";
NSString *kArrivalCellIdentifier = @"ArrivalCell";
NSString *kArrivalCellNib = @"ArrivalCell";
NSString *kTrackCellIdentifier = @"TrackCell";
NSString *kTrackCellNib = @"TrackCell";
NSString *kTrackWithStopCellIdentifier = @"TrackWithStopCell";
NSString *kTrackWithStopCellNib = @"TrackWithStopCell";

// Keys
NSString *kTypeKey = @"type";
NSString *kStationNameKey = @"stationName";
NSString *kTimeKey = @"time";
NSString *kTrackKey = @"track";
NSString *kCommentsKey = @"comments";


@interface TimetableDetailedViewController (PrivateMethods)

- (void)loadTableStructure:(NSString *)fileName;
- (NSUInteger)getIdFromSection:(NSUInteger)section;

@end


@implementation TimetableDetailedViewController

@synthesize tableView;
@synthesize sections;
@synthesize activityIndicator;
@synthesize headerView;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = NSLocalizedString(@"Details",@"Title for the details of a connection");
	
	[self loadTableStructure:kTimetableDetailedViewFileName];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
			
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2
													  target:self
													selector:@selector(stationsLoaded:)
													userInfo:nil
													 repeats:NO];
}

- (void)dealloc {
	[tableView release];
	[sections release];
	[activityIndicator release];
	[headerView release];
	
    [super dealloc];
}

- (void)loadTableStructure:(NSString *)fileName {
	NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
	self.sections = [NSArray arrayWithContentsOfFile:path];
}

- (void)stationsLoaded:(NSTimer *)aTimer {
	activityIndicator.hidden = YES;
	
	[self loadTableStructure:kTimetableDetailedView2FileName];
	
	NSUInteger count = [[[sections objectAtIndex:StationsStopsSection] objectForKey:kContentKey] count];
	NSMutableArray *indexPaths = [NSMutableArray array];
	
	for(NSUInteger i = 0; i < count; i++) {
		[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:StationsStopsSection]];
	}
	[tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
}

// UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	return [sections count];
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	return [[[sections objectAtIndex:section] objectForKey:kContentKey] count];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
	return [[sections objectAtIndex:section] objectForKey:kSectionNameKey];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger section = indexPath.section;
	NSUInteger sectionId = [self getIdFromSection:section];
	UITableViewCell *cell;
	
	if (sectionId == StationsStopsSection) {				
		NSDictionary *cellData = [[[sections objectAtIndex:section] objectForKey:kContentKey]
								  objectAtIndex:indexPath.row];
		
		NSUInteger type = [[cellData objectForKey:kTypeKey] unsignedIntValue];
		
		switch (type) {
			case DepartureCell:
				cell = [aTableView dequeueReusableCellWithIdentifier:kDepartureCellIdentifier];
				if (cell == nil) {
					cell = [[UIFactory newUIObjectFromNib:kDepartureCellNib] autorelease];
				}					
				((DetailedViewCell *)cell).trackImage.image = [UIImage imageNamed:@"Departure.png"];
				((DetailedViewCell *)cell).stationNameLabel.text = [cellData objectForKey:kStationNameKey];
				((DetailedViewCell *)cell).timeLabel.text = [cellData objectForKey:kTimeKey];
				((DetailedViewCell *)cell).trackLabel.text = [cellData objectForKey:kTrackKey];
				break;
			case TrackCell:
				cell = [aTableView dequeueReusableCellWithIdentifier:kTrackCellIdentifier];
				if (cell == nil) {
					cell = [[UIFactory newUIObjectFromNib:kTrackCellNib] autorelease];
				}					
				((DetailedViewCell *)cell).trackImage.image = [UIImage imageNamed:@"Track.png"];
				((DetailedViewCell *)cell).commentsLabel.text = [cellData objectForKey:kCommentsKey];
				break;
			case IntermediateArrivalCell:
				cell = [aTableView dequeueReusableCellWithIdentifier:kArrivalCellIdentifier];
				if (cell == nil) {
					cell = [[UIFactory newUIObjectFromNib:kArrivalCellNib] autorelease];
				}
				((DetailedViewCell *)cell).trackImage.image = [UIImage imageNamed:@"IntermediateArrival.png"];
				((DetailedViewCell *)cell).stationNameLabel.text = [cellData objectForKey:kStationNameKey];
				((DetailedViewCell *)cell).timeLabel.text = [cellData objectForKey:kTimeKey];
				((DetailedViewCell *)cell).trackLabel.text = [cellData objectForKey:kTrackKey];
				break;
			case IntermediateDepartureCell:
				cell = [aTableView dequeueReusableCellWithIdentifier:kDepartureCellIdentifier];
				if (cell == nil) {
					cell = [[UIFactory newUIObjectFromNib:kDepartureCellNib] autorelease];
				}
				((DetailedViewCell *)cell).trackImage.image = [UIImage imageNamed:@"IntermediateDeparture.png"];
				((DetailedViewCell *)cell).stationNameLabel.text = [cellData objectForKey:kStationNameKey];
				((DetailedViewCell *)cell).timeLabel.text = [cellData objectForKey:kTimeKey];
				((DetailedViewCell *)cell).trackLabel.text = [cellData objectForKey:kTrackKey];
				break;
			case ArrivalCell:
				cell = [aTableView dequeueReusableCellWithIdentifier:kArrivalCellIdentifier];
				if (cell == nil) {
					cell = [[UIFactory newUIObjectFromNib:kArrivalCellNib] autorelease];
				}
				((DetailedViewCell *)cell).trackImage.image = [UIImage imageNamed:@"Arrival.png"];
				((DetailedViewCell *)cell).stationNameLabel.text = [cellData objectForKey:kStationNameKey];
				((DetailedViewCell *)cell).timeLabel.text = [cellData objectForKey:kTimeKey];
				((DetailedViewCell *)cell).trackLabel.text = [cellData objectForKey:kTrackKey];
				break;
			case TrackWithStopCell:
				cell = [aTableView dequeueReusableCellWithIdentifier:kTrackWithStopCellIdentifier];
				if (cell == nil) {
					cell = [[UIFactory newUIObjectFromNib:kTrackWithStopCellNib] autorelease];
				}
				((DetailedViewCell *)cell).trackImage.image = [UIImage imageNamed:@"TrackWithStop.png"];
				((DetailedViewCell *)cell).stationNameLabel.text = [cellData objectForKey:kStationNameKey];
				((DetailedViewCell *)cell).timeLabel.text = [cellData objectForKey:kTimeKey];
				break;
			default:
				break;
		}
	} else if (sectionId == ShowIntermediateStops) {
		cell = [aTableView dequeueReusableCellWithIdentifier:kTimetableDetailedViewNormalCell];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kTimetableDetailedViewNormalCell] autorelease];
		}
		
		cell.text = [[[sections objectAtIndex:section] objectForKey:kContentKey] objectAtIndex:indexPath.row];		
	} else if (sectionId == DurationSection) {
		cell = [aTableView dequeueReusableCellWithIdentifier:kTimetableDetailedViewNormalCell];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kTimetableDetailedViewNormalCell] autorelease];
		}
	
		cell.text = [[[sections objectAtIndex:section] objectForKey:kContentKey] objectAtIndex:indexPath.row];
	}
	
	return cell;
}

// UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([self getIdFromSection:indexPath.section] == ShowIntermediateStops) {
		return indexPath;
	} else {
		return nil;
	}
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger section = indexPath.section;
	NSUInteger sectionId = [self getIdFromSection:section];
	
	if (sectionId == ShowIntermediateStops) {
		activityIndicator.hidden = NO;
		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2
														  target:self
														selector:@selector(intermediateStationsLoaded:)
														userInfo:nil
														 repeats:NO];
	}
	
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)intermediateStationsLoaded:(NSTimer *)aTimer {
	activityIndicator.hidden = YES;
	
	[self loadTableStructure:kTimetableDetailedView3FileName];
	
	NSUInteger count = [[[sections objectAtIndex:StationsStopsSection] objectForKey:kContentKey] count];
	NSMutableArray *indexPaths = [NSMutableArray array];
	
	for(NSUInteger i = 0; i < 1; i++) {
		[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:StationsStopsSection]];
	}
//	[tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if ([self getIdFromSection:section] == StationsStopsSection) {
		return headerView;
	} else {
		return nil;	
	}
}

// Private Methods:

- (NSUInteger)getIdFromSection:(NSUInteger)section {
	return [[[sections objectAtIndex:section] objectForKey:kIdKey] unsignedIntValue];
}

@end
