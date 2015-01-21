//
//  BuyTicketDestinationsAllStationsTableViewDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDestinationsAllStationsTableViewDelegate.h"

#import "StationsDataSourceProtocol.h"

#import "Stations.h"
#import "Station.h"
#import "BuyTicketNavigationController.h"
#import "AllStationsDataSource.h"
#import "Ticket.h"
#import "BuyTicketOptionsTableViewController.h"

NSString *kDestinationsAllStationsCellIdentifier = @"DestinationsAllStationsCellIdentifier";

@implementation BuyTicketDestinationsAllStationsTableViewDelegate

@synthesize viewController;

- (id)initWithViewController:(UIViewController *)aViewController {
	if (self = [self init]) {
		self.viewController = aViewController;
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDestinationsAllStationsCellIdentifier];
	if (cell == nil) {
		// We auto release the cell beacause we are the owner and we don't need it anymore
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kDestinationsAllStationsCellIdentifier] autorelease];
	}
	
	cell.text = [(id <StationsDataSource>)tableView.dataSource stationForIndexPath:indexPath].name;
	
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

@end
