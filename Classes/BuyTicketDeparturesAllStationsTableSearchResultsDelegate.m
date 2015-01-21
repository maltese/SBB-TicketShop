//
//  BuyTicketDeparturesAllStationsTableSearchResultsDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 19/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDeparturesAllStationsTableSearchResultsDelegate.h"

#import "SearchResultsDataSourceProtocol.h"

#import "Station.h"

#import "BuyTicketNavigationController.h"
#import "Ticket.h"
#import "AllStationsDataSource.h"
#import "BuyTicketDestinationsTableViewController.h"
#import "BuyTicketDeparturesTableViewController.h"
#import "SearchableTableViewController.h"

NSString *kDeparturesSearchResultsCellIdentifier = @"DeparturesSearchResultsCellIdentifier";

@implementation BuyTicketDeparturesAllStationsTableSearchResultsDelegate

@synthesize viewController;

- (id)initWithViewController:(UIViewController *)aViewController {
	if (self = [self init]) {
		self.viewController = aViewController;
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDeparturesSearchResultsCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kDeparturesSearchResultsCellIdentifier];
	}
	
	cell.text = ((Station *)[(id <SearchResultsDataSource>)tableView.dataSource searchResultForRow:indexPath.row]).name;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
	[((BuyTicketDeparturesTableViewController *)viewController).searchableTableViewController dismissSearch];
	
	BuyTicketNavigationController *navigationController = (BuyTicketNavigationController *)[self.viewController navigationController];
	
	// Create a new ticket
	Ticket *ticket = [[Ticket alloc] init];
	ticket.departureStation = [(id <SearchResultsDataSource>)tableView.dataSource searchResultForRow:indexPath.row];
	navigationController.ticket = ticket;
	[ticket release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	BuyTicketDestinationsTableViewController *destinationsController = [[BuyTicketDestinationsTableViewController alloc]
																		initWithNibName:kBuyTicketDestinationsNib bundle:nil];
	
	[navigationController pushViewController:destinationsController animated:YES];
	[destinationsController release];
}

@end
