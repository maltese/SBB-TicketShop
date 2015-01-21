//
//  BuyTicketDeparturesTableViewController+SearchResultsDataSource.m
//  iTicket
//
//  Created by Matteo Cortonesi on 20/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDeparturesTableViewController+SearchResultsDataSource.h"


@implementation BuyTicketDeparturesTableViewController (SearchResultsDataSource)

// UITableViewDataSource protocol:

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [searchResults count];
}

// SearchResultsDataSource protocol:

- (id)searchResultForRow:(NSUInteger)row {
	return [searchResults objectAtIndex:row];
}

@end
