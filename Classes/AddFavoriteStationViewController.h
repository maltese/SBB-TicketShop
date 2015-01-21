//
//  AddFavoriteStationViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 28/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchResultsDataSourceProtocol.h"

@class AddFavoriteStationDelegate;
@class AllStationsDataSource;
@class SearchableTableViewController;
@class BuyTicketDestinationsTableViewController;

@interface AddFavoriteStationViewController : UINavigationController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SearchResultsDataSource> {
	SearchableTableViewController *searchableTableViewController;
	AddFavoriteStationDelegate *addFavoriteStationDelegate;
	AllStationsDataSource *allStationsDataSource;
	BuyTicketDestinationsTableViewController *viewController;
	
	NSArray *searchResults;
}

@property (nonatomic, retain) SearchableTableViewController *searchableTableViewController;
@property (nonatomic, retain) NSArray *searchResults;
@property (nonatomic, retain) AddFavoriteStationDelegate *addFavoriteStationDelegate;
@property (nonatomic, retain) AllStationsDataSource *allStationsDataSource;
@property (nonatomic, assign) IBOutlet BuyTicketDestinationsTableViewController *viewController;

// You must call this before displaying the view controller
- (void)prepare;

@end
