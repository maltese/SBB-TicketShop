//
//  SearchableTableViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 18/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "SearchableTableViewController.h"

NSString *kHideBlackLayerAnimation = @"kHideBlackLayerAnimation";

@implementation SearchableTableViewController

@synthesize tableView;
@synthesize searchResultsTableView;
@synthesize searchResultsView;
@synthesize searchView;
@synthesize searchBar;
@synthesize blackLayerButton;
@synthesize showSearchBar;

@dynamic tableViewDataSource;
@dynamic tableViewDelegate;

@dynamic searchResultsDelegate;
@dynamic searchResultsDataSource;

@synthesize searchBarDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Disable the text auto correction for the search bar
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
		
	// By default, show the search bar at the top of the table view
	self.showSearchBar = YES;
}

- (void)dealloc {
	[tableView release];
	[searchResultsTableView release];
	[searchResultsView release];
	[searchView release];
	[searchBar release];
	[blackLayerButton release];
	
    [super dealloc];
}

// Getters
- (id <UITableViewDataSource>)tableViewDataSource {
	return tableView.dataSource;
}

- (id <UITableViewDelegate>)tableViewDelegate {
	return tableView.delegate;
}

- (id <UITableViewDataSource, SearchResultsDataSource>)searchResultsDataSource {
	return (id <UITableViewDataSource, SearchResultsDataSource>)searchResultsTableView.dataSource;
}

- (id <UITableViewDelegate>)searchResultsDelegate {
	return searchResultsTableView.delegate;
}

// Setters
- (void)setTableViewDataSource:(id <UITableViewDataSource>)aDataSource {
	tableView.dataSource = aDataSource;
}

- (void)setTableViewDelegate:(id <UITableViewDelegate>)aDelegate {
	tableView.delegate = aDelegate;
}

- (void)setSearchResultsDataSource:(id <UITableViewDataSource, SearchResultsDataSource>)aDataSource {
	searchResultsTableView.dataSource = (id <UITableViewDataSource>)aDataSource;
}

- (void)setSearchResultsDelegate:(id <UITableViewDelegate>)aDelegate {
	searchResultsTableView.delegate = aDelegate;
}

// Overwrite the synthetized setter
- (void)setShowSearchBar:(BOOL)show {
	if (showSearchBar = show) {
		tableView.tableHeaderView = searchView;
	} else {
		tableView.tableHeaderView = nil;
	}
}

- (void)dismissSearch {
	// Show the table index
	tableView.sectionIndexMinimumDisplayRowCount = 0;
	[tableView reloadData];
	// Re-enable scrolling of the table view
	tableView.scrollEnabled = YES;
	// Scale the search bar
	CGRect searchBarFrame = self.searchBar.frame;
	searchBarFrame.size.width = [[UIScreen mainScreen] applicationFrame].size.width-27;
	self.searchBar.frame = searchBarFrame;
	// Reset the search text of the search bar
	searchBar.text = @"";
	// Dismiss the keyboard
	[searchBar resignFirstResponder];
	
	// Setup animation
	[UIView beginAnimations:kHideBlackLayerAnimation context:nil];
	[UIView setAnimationDuration:SEARCH_BAR_ANIMATION_DURATION_SECONDS];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)]; 
	
	// Hide the black layer
	blackLayerButton.alpha = 0.0;
	
	[UIView commitAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

@end
