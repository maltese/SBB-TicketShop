//
//  BuyTicketDeparturesTableViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 16/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchResultsDataSourceProtocol.h"

// The height of the toolbar (it must correspond to the height of the search bar)
#define kToolbarHeight 44.0

@class SearchableTableViewController;
@class BuyTicketDeparturesAllStationsTableViewDelegate;
@class BuyTicketDeparturesAllStationsTableSearchResultsDelegate;
@class AllStationsDataSource;
@class BuyTicketNearbyStationsTableViewDelegate;
@class BuyTicketNearbyStationsTableViewDataSource;

@interface BuyTicketDeparturesTableViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, SearchResultsDataSource> {
	UIBarButtonItem *doneButton;
	UISegmentedControl *tablesSwitch;
	
	SearchableTableViewController *searchableTableViewController;
	
	BuyTicketDeparturesAllStationsTableViewDelegate *allStationsTableViewDelegate;
	AllStationsDataSource *allStationsDataSource;
	
	BuyTicketNearbyStationsTableViewDelegate *nearbyStationsTableViewDelegate;
	BuyTicketNearbyStationsTableViewDataSource *nearbyStationsTableViewDataSource;
	
	BuyTicketDeparturesAllStationsTableSearchResultsDelegate *allStationsTableSearchResultsDelegate;
	
	NSArray *searchResults;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UISegmentedControl *tablesSwitch;

@property (nonatomic, retain) SearchableTableViewController *searchableTableViewController;

@property (nonatomic, retain) BuyTicketDeparturesAllStationsTableViewDelegate *allStationsTableViewDelegate;
@property (nonatomic, retain) AllStationsDataSource *allStationsDataSource;

@property (nonatomic, retain) BuyTicketNearbyStationsTableViewDelegate *nearbyStationsTableViewDelegate;
@property (nonatomic, retain) BuyTicketNearbyStationsTableViewDataSource *nearbyStationsTableViewDataSource;

@property (nonatomic, retain) BuyTicketDeparturesAllStationsTableSearchResultsDelegate *allStationsTableSearchResultsDelegate;

@property (nonatomic, retain) NSArray *searchResults;

@end
