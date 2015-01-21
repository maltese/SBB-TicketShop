//
//  BuyTicketDeparturesTableViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 16/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDeparturesTableViewController.h"

#import "SearchableTableViewController.h"

#import "BuyTicketDeparturesAllStationsTableViewDelegate.h"
#import "BuyTicketDeparturesAllStationsTableSearchResultsDelegate.h";

#import "BuyTicketNearbyStationsTableViewDelegate.h"
#import "BuyTicketNearbyStationsTableViewDataSource.h"

#import "AllStationsDataSource.h"

#import "iTicketAppDelegate.h"

@implementation BuyTicketDeparturesTableViewController

@synthesize doneButton;
@synthesize tablesSwitch;

@synthesize searchableTableViewController;

@synthesize allStationsTableViewDelegate;
@synthesize allStationsDataSource;

@synthesize nearbyStationsTableViewDelegate;
@synthesize nearbyStationsTableViewDataSource;

@synthesize allStationsTableSearchResultsDelegate;

@synthesize searchResults;


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Set up the navigation item
	self.navigationItem.title = NSLocalizedString(@"Departures",@"Title of the departures navigation item");
	self.navigationItem.prompt = NSLocalizedString(@"Select a departure station",@"");
	
	// Create the searchable table view controller
	searchableTableViewController = [[SearchableTableViewController alloc] initWithNibName:@"SearchableTableView" bundle:nil];
	
	// Add the searchable table view controller's view to the current view and set its position
	[self.view addSubview:searchableTableViewController.view];
	searchableTableViewController.view.frame = CGRectOffset(searchableTableViewController.view.frame, 0, kToolbarHeight);
	CGRect searchableTableViewControllerFrame = searchableTableViewController.view.frame;
	searchableTableViewControllerFrame.size.height -= kToolbarHeight;
	searchableTableViewController.view.frame = searchableTableViewControllerFrame;
	
	// Instanciate the data sources and delegates
	allStationsDataSource = [[AllStationsDataSource alloc] init];
	allStationsTableViewDelegate = [[BuyTicketDeparturesAllStationsTableViewDelegate alloc] initWithViewController:self];
	allStationsTableSearchResultsDelegate = [[BuyTicketDeparturesAllStationsTableSearchResultsDelegate alloc] initWithViewController:self];
	nearbyStationsTableViewDataSource = [[BuyTicketNearbyStationsTableViewDataSource alloc] init];
	nearbyStationsTableViewDelegate = [[BuyTicketNearbyStationsTableViewDelegate alloc] initWithViewController:self];
	
	// Set the search bar delegate
	searchableTableViewController.searchBarDelegate = (id <UISearchBarDelegate>) self;
	
	// Load default selection
	tablesSwitch.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:kDeparturesTablesSwitchSelectionIndexKey];

	// Set the data source and delegate for the search results table
	searchableTableViewController.searchResultsDelegate = allStationsTableSearchResultsDelegate;
	searchableTableViewController.searchResultsDataSource = self;
}

- (void)dealloc {
	[doneButton release];
	[tablesSwitch release];
	
	[searchableTableViewController release];
	
	[allStationsTableViewDelegate release];
	[allStationsDataSource release];
	
	[nearbyStationsTableViewDelegate release];
	[nearbyStationsTableViewDataSource release];
	
	[allStationsTableSearchResultsDelegate release];
	
	[searchResults release];
	
    [super dealloc];
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
