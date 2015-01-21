//
//  BuyTicketDestinationsTableViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketDestinationsTableViewController.h"

#import "SearchableTableViewController.h"

#import "BuyTicketDestinationsAllStationsTableViewDelegate.h"
#import "BuyTicketDestinationsAllStationsTableSearchResultsDelegate.h";

#import "BuyTicketFavoriteStationsTableViewDelegate.h"
#import "BuyTicketFavoriteStationsTableViewDataSource.h"

#import "AllStationsDataSource.h"

#import "iTicketAppDelegate.h"

@implementation BuyTicketDestinationsTableViewController

@synthesize doneButton;
@synthesize tablesSwitch;
@synthesize editingToolbar;
@synthesize addButton;
@synthesize flexibleSpace;

@synthesize searchableTableViewController;
@synthesize addFavoriteStationViewController;

@synthesize allStationsTableViewDelegate;
@synthesize allStationsDataSource;

@synthesize favoriteStationsTableViewDelegate;
@synthesize favoriteStationsTableViewDataSource;

@synthesize allStationsTableSearchResultsDelegate;

@synthesize searchResults;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Set up the navigation item
	self.navigationItem.title = NSLocalizedString(@"Destinations",@"Title of the destinations navigation item");
	self.navigationItem.prompt = NSLocalizedString(@"Select a destination station",@"");
	
	// Set up the editing toolbar
	self.editingToolbar.items = [NSArray arrayWithObjects:[self editButtonItem],flexibleSpace,addButton,nil];
	
	// Create the searchable table view controller
	searchableTableViewController = [[SearchableTableViewController alloc] initWithNibName:@"SearchableTableView" bundle:nil];
	
	// Add the searchable table view controller's view to the current view and set its position
	[self.view addSubview:searchableTableViewController.view];
	searchableTableViewController.view.frame = CGRectOffset(searchableTableViewController.view.frame, 0, kToolbarHeight);
	CGRect searchableTableViewControllerFrame = searchableTableViewController.view.frame;
	searchableTableViewControllerFrame.size.height -= kToolbarHeight;
	searchableTableViewController.view.frame = searchableTableViewControllerFrame;
	
	// Bring to front the editing toolbar
	[self.view bringSubviewToFront:editingToolbar];
	
	// Instanciate the data sources and delegates
	allStationsDataSource = [[AllStationsDataSource alloc] init];
	allStationsTableViewDelegate = [[BuyTicketDestinationsAllStationsTableViewDelegate alloc] initWithViewController:self];
	allStationsTableSearchResultsDelegate = [[BuyTicketDestinationsAllStationsTableSearchResultsDelegate alloc] initWithViewController:self];
	favoriteStationsTableViewDataSource = [[BuyTicketFavoriteStationsTableViewDataSource alloc] init];
	favoriteStationsTableViewDelegate = [[BuyTicketFavoriteStationsTableViewDelegate alloc] initWithViewController:self];
	
	// Set the search bar delegate
	searchableTableViewController.searchBarDelegate = (id <UISearchBarDelegate>) self;
	
	// Load default selection
	tablesSwitch.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:kDestinationsTablesSwitchSelectionIndexKey];
	
	// Set the data source and delegate for the search results table
	searchableTableViewController.searchResultsDelegate = allStationsTableSearchResultsDelegate;
	searchableTableViewController.searchResultsDataSource = self;
}

- (void)dealloc {
	[doneButton release];
	[tablesSwitch release];
	[editingToolbar release];
	[addButton release];
	[flexibleSpace release];
	
	[searchableTableViewController release];
	[addFavoriteStationViewController release];
	
	[allStationsTableViewDelegate release];
	[allStationsDataSource release];
	
	[favoriteStationsTableViewDelegate release];
	[favoriteStationsTableViewDataSource release];
	
	[allStationsTableSearchResultsDelegate release];
	
	[searchResults release];
	
    [super dealloc];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];

	// Put the table in editing mode
	[searchableTableViewController.tableView setEditing:editing animated:animated];
	
	// The add button must not be enabled in editing mode
	addButton.enabled = !editing;
	
	// The tables switch must not be enabled in editing mode
	tablesSwitch.enabled = !editing;
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
