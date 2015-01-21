//
//  SearchableTableViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 18/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

/*
 
 An instance of SearchableTableViewController controls a table view and a search bar.
 The search bar is the header of the table view and is used to search the cells of the
 table view by typing instead of scrolling through the table view.
 
 Clicking on the search bar results in the keyboard showing up and a semi-transparent
 black layer appearing on the table's cells.
 
 If the search string isn't empty, a table of the search results is displayed.
 
 Use the initWithNibName:@"SearchableTableView" bundle:nil initializer to create
 a valid instance of SearchableTableViewController.
 
 After initialization you can add the controller's view property to an other
 view in order to show the searchable table view:
 
 [window addSubview:mySearchableTableViewController.view];
 
 After this you should assign the tableview a data source and delegate.
 (The data source must implement the SearchResultsDataSource Protocol)
 
 mySearchableTableViewController.tableViewDataSource = aTableViewDataSource;
 mySearchableTableViewController.tableViewDelegate = aTableViewDelegate;

 You also need to set a data source and delegate for the search results table:
 
 searchableTableViewController.searchResultsDelegate = searchResultsDelegate;
 searchableTableViewController.searchResultsDataSource = searchResultsDataSource;
   
 You may also provide a search bar delegate (see UISearchBarDelegate Protocol) in
 order to respond to the search bar events:
 
 mySearchableTableViewController.searchBarDelegate = aSearchBarDelegate;
 
 You can finish the search at any time and restore the table to its original state
 by sending a dismissSearch message to the controller:
 
 [mySearchableTableViewController dismissSearch];
 
 */

#import <UIKit/UIKit.h>

#import "SearchResultsDataSourceProtocol.h"

#define SEARCH_BAR_ANIMATION_DURATION_SECONDS 0.35

extern NSString *kHideBlackLayerAnimation;

@interface SearchableTableViewController : UIViewController {
	UITableView *tableView;
	UITableView *searchResultsTableView;
	UIView *searchResultsView;
	UIView *searchView;
	UISearchBar *searchBar;
	UIButton *blackLayerButton;
	BOOL showSearchBar;
	
	id <UISearchBarDelegate> searchBarDelegate;
}

@property (nonatomic, retain, readonly) IBOutlet UITableView *tableView;
@property (nonatomic, retain, readonly) IBOutlet UITableView *searchResultsTableView;
@property (nonatomic, retain, readonly) IBOutlet UIView *searchResultsView;
@property (nonatomic, retain, readonly) IBOutlet UIView *searchView;
@property (nonatomic, retain, readonly) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain, readonly) IBOutlet UIButton *blackLayerButton;
@property (nonatomic) BOOL showSearchBar;

// Weak references
@property (nonatomic, assign) id <UITableViewDataSource> tableViewDataSource;
@property (nonatomic, assign) id <UITableViewDelegate> tableViewDelegate;

// Weak references
@property (nonatomic, assign) id <UITableViewDelegate> searchResultsDelegate;
@property (nonatomic, assign) id <UITableViewDataSource, SearchResultsDataSource> searchResultsDataSource;

// Weak reference
@property (nonatomic, assign) id <UISearchBarDelegate> searchBarDelegate;

- (void)dismissSearch;

@end
