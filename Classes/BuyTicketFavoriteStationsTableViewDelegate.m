//
//  BuyTicketFavoriteStationsTableViewDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketFavoriteStationsTableViewDelegate.h"

#import "StationsDataSourceProtocol.h"
#import "Station.h"
#import "BuyTicketNavigationController.h"
#import "AllStationsDataSource.h"
#import "Ticket.h"
#import "BuyTicketOptionsTableViewController.h"

NSString *kDestinationsFavoriteStationsCellIdentifier = @"DestinationsFavoriteStationsCellIdentifier";

@implementation BuyTicketFavoriteStationsTableViewDelegate

@synthesize viewController;

- (id)initWithViewController:(UIViewController *)aViewController {
	if (self = [self init]) {
		self.viewController = aViewController;
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDestinationsFavoriteStationsCellIdentifier];
	if (cell == nil) {
		// We auto release the cell beacause we are the owner and we don't need it anymore
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kDestinationsFavoriteStationsCellIdentifier];
	}
	
	// If it is the last row
	if (indexPath.row == [tableView.dataSource tableView:tableView numberOfRowsInSection:1] - 1) {
		cell.text = @"";
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	} else {
		cell.text = [(id <StationsDataSource>)tableView.dataSource stationForIndexPath:indexPath].name;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BuyTicketNavigationController *navigationController = (BuyTicketNavigationController *)[self.viewController navigationController];
	
	navigationController.ticket.destinationStation = [(AllStationsDataSource *)tableView.dataSource stationForIndexPath:indexPath];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	BuyTicketOptionsTableViewController *optionsController = [[BuyTicketOptionsTableViewController alloc]
															  initWithNibName:kBuyTicketOptionsNib bundle:nil];
	
	[navigationController pushViewController:optionsController animated:YES];
	[optionsController release];
}


// Can't select the last row
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == [tableView.dataSource tableView:tableView numberOfRowsInSection:1] - 1) {
		return nil;
	} else {
		return indexPath;
	}
}

// Can't move a row past the last row
- (NSIndexPath *)tableView:(UITableView *)tableView
	targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
	   toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
	if (proposedDestinationIndexPath.row == [tableView.dataSource tableView:tableView numberOfRowsInSection:1] - 1) {
		return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row-1
								  inSection:proposedDestinationIndexPath.section];
	} else {
		return proposedDestinationIndexPath;
	}
	
}

@end
