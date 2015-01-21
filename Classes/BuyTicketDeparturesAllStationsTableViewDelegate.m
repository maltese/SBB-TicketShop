//
//  BuyTicketDeparturesAllStationsTableViewDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 17/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDeparturesAllStationsTableViewDelegate.h"

#import "StationsDataSourceProtocol.h"
#import "AllStationsDataSource.h"

#import "Station.h"
#import "Ticket.h"

#import "BuyTicketNavigationController.h"

#import "BuyTicketDestinationsTableViewController.h"

NSString *kDeparturesAllStationsCellIdentifier = @"DeparturesAllStationsCellIdentifier";

@implementation BuyTicketDeparturesAllStationsTableViewDelegate

@synthesize viewController;

- (id)initWithViewController:(UIViewController *)aViewController {
	if (self = [self init]) {
		self.viewController = aViewController;
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDeparturesAllStationsCellIdentifier];
	if (cell == nil) {
		// We auto release the cell beacause we are the owner and we don't need it anymore
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kDeparturesAllStationsCellIdentifier] autorelease];
	}
		
	cell.text = [(id <StationsDataSource>)tableView.dataSource stationForIndexPath:indexPath].name;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BuyTicketNavigationController *navigationController = (BuyTicketNavigationController *)[self.viewController navigationController];
	
	// Create a new ticket
	Ticket *ticket = [[Ticket alloc] init];
	ticket.departureStation = [(AllStationsDataSource *)tableView.dataSource stationForIndexPath:indexPath];
	navigationController.ticket = ticket;
	[ticket release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	BuyTicketDestinationsTableViewController *destinationsController = [[BuyTicketDestinationsTableViewController alloc]
																		initWithNibName:kBuyTicketDestinationsNib bundle:nil];
	
	[navigationController pushViewController:destinationsController animated:YES];
	[destinationsController release];
}

@end
