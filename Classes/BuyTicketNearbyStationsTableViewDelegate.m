//
//  BuyTicketNearbyStationsTableViewDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 20/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketNearbyStationsTableViewDelegate.h"

#import "StationsDataSourceProtocol.h"
#import "UIFactory.h"
#import "NearbyStationCell.h"
#import "Station.h"
#import "BuyTicketNavigationController.h"
#import "BuyTicketDestinationsTableViewController.h"
#import "Ticket.h"

NSString *kDeparturesNearbyStationsCellIdentifier = @"DeparturesNearbyStationsCellIdentifier";
NSString *kNearbyStationCellNib = @"NearbyStationCell";

@implementation BuyTicketNearbyStationsTableViewDelegate

@synthesize viewController;

- (id)initWithViewController:(UIViewController *)aViewController {
	if (self = [self init]) {
		self.viewController = aViewController;
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NearbyStationCell *cell = (NearbyStationCell *)[tableView dequeueReusableCellWithIdentifier:kDeparturesNearbyStationsCellIdentifier];
	if (cell == nil) {
		// We auto release the cell beacause we are the owner and we don't need it anymore
		cell = (NearbyStationCell *) [[UIFactory newUIObjectFromNib:kNearbyStationCellNib] autorelease];
	}
	
	cell.station = [(id <StationsDataSource>)tableView.dataSource stationForIndexPath:indexPath];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BuyTicketNavigationController *navigationController = (BuyTicketNavigationController *)[self.viewController navigationController];
	
	// Create a new ticket
	Ticket *ticket = [[Ticket alloc] init];
	ticket.departureStation = [(id <StationsDataSource>)tableView.dataSource stationForIndexPath:indexPath];
	navigationController.ticket = ticket;
	[ticket release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	BuyTicketDestinationsTableViewController *destinationsController = [[BuyTicketDestinationsTableViewController alloc]
																		initWithNibName:kBuyTicketDestinationsNib bundle:nil];
	
	[navigationController pushViewController:destinationsController animated:YES];
	[destinationsController release];
}

@end
