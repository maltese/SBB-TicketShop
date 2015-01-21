//
//  TimetableOverviewController+Delegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 12/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "TimetableOverviewController+Delegate.h"

#import "TimetableCellEmpty.h"
#import "Connections.h"
#import "TimetableDetailedViewController.h"

@implementation TimetableOverviewController (Delegate)

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = indexPath.row;
	NSUInteger loadedConnectionsCount = [loadedConnections count];
	
	if (row == 0) { // First row
		TimetableCellEmpty *cell = (TimetableCellEmpty *)[theTableView cellForRowAtIndexPath:indexPath];
		cell.activityIndicator.hidden = NO;
		// Scroll the tableview to the top (unelegant but effective)
		[theTableView scrollRectToVisible:CGRectMake(0, 0, 320, 1) animated:NO];
		tableView.userInteractionEnabled = NO;
		NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:2.5
															 target:self
														   selector:@selector(previousConnectionsLoaded:)
														   userInfo:cell
															repeats:NO];
	} else if (row == loadedConnectionsCount + 1) { // Next to last row
		TimetableCellEmpty *cell = (TimetableCellEmpty *)[theTableView cellForRowAtIndexPath:indexPath];
		cell.activityIndicator.hidden = NO;
		tableView.userInteractionEnabled = NO;
		NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:2.5
															 target:self
														   selector:@selector(nextConnectionsLoaded:)
														   userInfo:cell
															repeats:NO];
	} else { // A row displaying a connection
		TimetableDetailedViewController *controller = [[TimetableDetailedViewController alloc] initWithNibName:kTimetableDetailedNib
																										bundle:nil];
		[[self navigationController] pushViewController:controller animated:YES];
		[controller release];
	}
	
	[theTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)previousConnectionsLoaded:(NSTimer *)aTimer {
	TimetableCellEmpty *cell = (TimetableCellEmpty *)[aTimer userInfo];
	cell.activityIndicator.hidden = YES;
	tableView.userInteractionEnabled = YES;
	
	id connectionsCArray[5];
	NSRange range = NSMakeRange(0, 5);
	[[Connections sharedConnections].connectionsArray getObjects:connectionsCArray range:range];
	NSArray *connectionsArray = [NSArray arrayWithObjects:connectionsCArray count:5];
	[loadedConnections insertObjects:connectionsArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
	
	NSMutableArray *indexPaths = [NSMutableArray array];
	for(NSUInteger i = 1; i < 6; i++) {
		[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
	}
	
	[tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
}

- (void)nextConnectionsLoaded:(NSTimer *)aTimer {
	TimetableCellEmpty *cell = (TimetableCellEmpty *)[aTimer userInfo];
	cell.activityIndicator.hidden = YES;
	tableView.userInteractionEnabled = YES;
	
	id connectionsCArray[5];
	NSRange range = NSMakeRange(10, 5);
	[[Connections sharedConnections].connectionsArray getObjects:connectionsCArray range:range];
	NSArray *connectionsArray = [NSArray arrayWithObjects:connectionsCArray count:5];
	[loadedConnections addObjectsFromArray:connectionsArray];
	
	NSMutableArray *indexPaths = [NSMutableArray array];
	for(NSUInteger i = [loadedConnections count]-4; i < [loadedConnections count]+1; i++) {
		[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
	}
	
	[tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
}

@end
