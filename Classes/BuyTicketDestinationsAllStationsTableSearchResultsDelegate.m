//
//  BuyTicketDestinationsAllStationsTableSearchResultsDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDestinationsAllStationsTableSearchResultsDelegate.h"

#import "SearchResultsDataSourceProtocol.h"

#import "Station.h"
#import "BuyTicketNavigationController.h"
#import "Ticket.h"
#import "BuyTicketOptionsTableViewController.h"
#import "BuyTicketDestinationsTableViewController.h"
#import "SearchableTableViewController.h"

NSString *kDestinationsSearchResultsCellIdentifier = @"DestinationsSearchResultsCellIdentifier";


@implementation BuyTicketDestinationsAllStationsTableSearchResultsDelegate

@synthesize viewController;

- (id)initWithViewController:(UIViewController *)aViewController {
	if (self = [self init]) {
		self.viewController = aViewController;
	}
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDestinationsSearchResultsCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kDestinationsSearchResultsCellIdentifier];
	}
	
	cell.text = ((Station *)[(id <SearchResultsDataSource>)tableView.dataSource searchResultForRow:indexPath.row]).name;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[((BuyTicketDestinationsTableViewController *)viewController).searchableTableViewController dismissSearch];
	
	BuyTicketNavigationController *navigationController = (BuyTicketNavigationController *)[self.viewController navigationController];
	
	navigationController.ticket.destinationStation = [(id <SearchResultsDataSource>)tableView.dataSource searchResultForRow:indexPath.row];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	BuyTicketOptionsTableViewController *optionsController = [[BuyTicketOptionsTableViewController alloc]
															  initWithNibName:kBuyTicketOptionsNib bundle:nil];
	
	[navigationController pushViewController:optionsController animated:YES];
	[optionsController release];
}

@end
