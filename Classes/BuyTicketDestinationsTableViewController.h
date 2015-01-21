//
//  BuyTicketDestinationsTableViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchResultsDataSourceProtocol.h"
#import "AddFavoriteStationViewController.h"

// The height of the toolbar (it must correspond to the height of the search bar)
#define kToolbarHeight 44.0

@class SearchableTableViewController;
@class BuyTicketDestinationsAllStationsTableViewDelegate;
@class AllStationsDataSource;
@class BuyTicketFavoriteStationsTableViewDelegate;
@class BuyTicketFavoriteStationsTableViewDataSource;
@class BuyTicketDestinationsAllStationsTableSearchResultsDelegate;

@interface BuyTicketDestinationsTableViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, SearchResultsDataSource> {
	UIBarButtonItem *doneButton;
	UISegmentedControl *tablesSwitch;
	UIToolbar *editingToolbar;
	UIBarButtonItem *addButton;
	UIBarButtonItem *flexibleSpace;
	
	SearchableTableViewController *searchableTableViewController;
	AddFavoriteStationViewController *addFavoriteStationViewController;
	
	BuyTicketDestinationsAllStationsTableViewDelegate *allStationsTableViewDelegate;
	AllStationsDataSource *allStationsDataSource;
	
	BuyTicketFavoriteStationsTableViewDelegate *favoriteStationsTableViewDelegate;
	BuyTicketFavoriteStationsTableViewDataSource *favoriteStationsTableViewDataSource;
	
	BuyTicketDestinationsAllStationsTableSearchResultsDelegate *allStationsTableSearchResultsDelegate;
	
	NSArray *searchResults;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UISegmentedControl *tablesSwitch;
@property (nonatomic, retain) IBOutlet UIToolbar *editingToolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *flexibleSpace;

@property (nonatomic, retain) SearchableTableViewController *searchableTableViewController;
@property (nonatomic, retain) IBOutlet AddFavoriteStationViewController *addFavoriteStationViewController;

@property (nonatomic, retain) BuyTicketDestinationsAllStationsTableViewDelegate *allStationsTableViewDelegate;
@property (nonatomic, retain) AllStationsDataSource *allStationsDataSource;

@property (nonatomic, retain) BuyTicketFavoriteStationsTableViewDelegate *favoriteStationsTableViewDelegate;
@property (nonatomic, retain) BuyTicketFavoriteStationsTableViewDataSource *favoriteStationsTableViewDataSource;

@property (nonatomic, retain) BuyTicketDestinationsAllStationsTableSearchResultsDelegate *allStationsTableSearchResultsDelegate;

@property (nonatomic, retain) NSArray *searchResults;


@end
