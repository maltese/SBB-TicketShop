//
//  BuyTicketDestinationsTableViewController+SearchResultsDataSource.m
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDestinationsTableViewController+SearchResultsDataSource.h"


@implementation BuyTicketDestinationsTableViewController (SearchResultsDataSource)

// UITableViewDataSource protocol:

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [searchResults count];
}

// SearchResultsDataSource protocol:

- (id)searchResultForRow:(NSUInteger)row {
	return [searchResults objectAtIndex:row];
}

@end
