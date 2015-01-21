//
//  AddFavoriteStationViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 28/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "AddFavoriteStationViewController.h"

#import "SearchableTableViewController.h"
#import "BuyTicketDeparturesTableViewController.h"
#import "AllStationsDataSource.h"
#import "AddFavoriteStationDelegate.h"


@implementation AddFavoriteStationViewController

@synthesize searchableTableViewController;
@synthesize searchResults;
@synthesize addFavoriteStationDelegate;
@synthesize allStationsDataSource;
@synthesize viewController;

- (id)initWithViewController:(BuyTicketDestinationsTableViewController *)aViewController {
	if (self = [self init]) {
		self.viewController = aViewController;
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Instanciate the data sources and delegates
	allStationsDataSource = [[AllStationsDataSource alloc] init];
	addFavoriteStationDelegate = [[AddFavoriteStationDelegate alloc] initWithViewController:self];
}

- (void)dealloc {
	[searchableTableViewController release];
	[searchResults release];
	[addFavoriteStationDelegate release];
	[allStationsDataSource release];
	
    [super dealloc];
}

- (void)prepare {
	// If the view of the searchable table view controller has already
	// been added to the view of self, remove it
	[searchableTableViewController.view removeFromSuperview];
	
	// Create the searchable table view controller
	searchableTableViewController = [[SearchableTableViewController alloc] initWithNibName:@"SearchableTableView" bundle:nil];

	// Add the searchable table view controller's view to the current view and set its position
	[self.view addSubview:searchableTableViewController.view];
	
	searchableTableViewController.view.frame = CGRectOffset(searchableTableViewController.view.frame, 0, kToolbarHeight+30);
	CGRect searchableTableViewControllerFrame = searchableTableViewController.view.frame;
	searchableTableViewControllerFrame.size.height -= kToolbarHeight+30;
	searchableTableViewController.view.frame = searchableTableViewControllerFrame;
	
	// Set the data sources and delegates
	searchableTableViewController.tableViewDataSource = allStationsDataSource;
	searchableTableViewController.tableViewDelegate = addFavoriteStationDelegate;
	searchableTableViewController.searchResultsDataSource = self;
	searchableTableViewController.searchResultsDelegate = self;
	
	// Set the search bar delegate
	searchableTableViewController.searchBarDelegate = (id <UISearchBarDelegate>) self;
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
