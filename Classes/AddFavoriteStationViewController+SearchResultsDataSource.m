//
//  AddFavoriteStationViewController+SearchResultsDataSource.m
//  iTicket
//
//  Created by Matteo Cortonesi on 28/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "AddFavoriteStationViewController+SearchResultsDataSource.h"


@implementation AddFavoriteStationViewController (SearchResultsDataSource)

// UITableViewDataSource protocol:

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [searchResults count];
}

// SearchResultsDataSource protocol:

- (id)searchResultForRow:(NSUInteger)row {
	return [searchResults objectAtIndex:row];
}

@end
