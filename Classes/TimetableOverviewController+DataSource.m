//
//  TimetableOverviewController+DataSource.m
//  iTicket
//
//  Created by Matteo Cortonesi on 12/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "TimetableOverviewController+DataSource.h"

#import "TimetableCell.h"
#import "TimetableCellEmpty.h"
#import "UIFactory.h"
#import "Connections.h"
#import "Connection.h"

NSString *kTimetableCellBrightIdentifier = @"TimetableCellBright";
NSString *kTimetableCellBrightEmptyIdentifier = @"TimetableCellBrightEmpty";
NSString *kTimetableCellDarkIdentifier = @"TimetableCellDark";
NSString *kNormalCellIdentifier = @"NormalCell";

NSString *kTimetableCellBrightNib = @"TimetableCellBright";
NSString *kTimetableCellBrightEmptyNib = @"TimetableCellBrightEmpty";
NSString *kTimetableCellDarkNib = @"TimetableCellDark";

@implementation TimetableOverviewController (DataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSUInteger count = [loadedConnections count];
	if (count > 0) {
		return count + 3;
	} else {
		return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	
	NSUInteger row = indexPath.row;
	NSUInteger loadedConnectionsCount = [loadedConnections count];
	
	if ((row == 0 || row == loadedConnectionsCount + 1)) { // First row or next to last row
		cell = (TimetableCellEmpty *) [theTableView dequeueReusableCellWithIdentifier:kTimetableCellBrightEmptyIdentifier];
		if (cell == nil) {
			cell = [[UIFactory newUIObjectFromNib:kTimetableCellBrightEmptyNib] autorelease];
		}
		cell.text = row == 0 ? NSLocalizedString(@"Previous Connections...",@"") : NSLocalizedString(@"Next Connections...",@"");
	} else if (row == loadedConnectionsCount + 2) { // Last row
		// Dummy empty row
		cell = [theTableView dequeueReusableCellWithIdentifier:kNormalCellIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kNormalCellIdentifier];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	} else {
		if (!(row % 2)) {
			cell = (TimetableCell *) [theTableView dequeueReusableCellWithIdentifier:kTimetableCellBrightIdentifier];
			if (cell == nil) {
				cell = [[UIFactory newUIObjectFromNib:kTimetableCellBrightNib] autorelease];
			}
		} else {
			cell = (TimetableCell *) [theTableView dequeueReusableCellWithIdentifier:kTimetableCellDarkIdentifier];
			if (cell == nil) {
				cell = [[UIFactory newUIObjectFromNib:kTimetableCellDarkNib] autorelease];
			}
		}
				
		((TimetableCell *)cell).connection = [loadedConnections objectAtIndex:row - 1];
	}
	
	return cell;
}

@end
