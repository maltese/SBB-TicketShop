//
//  SearchableTableViewController+SearchBarDelegate.m
//  iTicket
//
//  Created by Matteo Cortonesi on 18/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "SearchableTableViewController+SearchBarDelegate.h"


@implementation SearchableTableViewController (SearchBarDelegate)

// This message is sent by the search bar when the user initiates a search
// e.g. he clicks on it. The code shows the semi-transparent black layer
// with an animation and finally forwards the message to the searchBarDelegate
// object.
- (void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	// Hide the table index
	tableView.sectionIndexMinimumDisplayRowCount = NSIntegerMax;
	[tableView reloadData];
	// Scale the search bar
	CGRect searchBarFrame = self.searchBar.frame;
	searchBarFrame.size.width = [[UIScreen mainScreen] applicationFrame].size.width;
	self.searchBar.frame = searchBarFrame;
	// Unhide the black layer
	blackLayerButton.hidden = NO;
	// Scroll the table to top
	[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
					 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	// Disable scrolling of the table view
	tableView.scrollEnabled = NO;
	
	// Setup animation
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:SEARCH_BAR_ANIMATION_DURATION_SECONDS];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)]; 
	
	// Show the black layer and push it up together with the table view
	blackLayerButton.alpha = 0.8;
		
	[UIView commitAnimations];
	
	// Forward the message to the searchBarDelegate object
	if ([searchBarDelegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)])
		[searchBarDelegate searchBarTextDidBeginEditing:theSearchBar];
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	// If the search string isn't empty
	if (![searchText isEqualToString:@""]) {
		// Unhide the search results
		searchResultsView.hidden = NO;
	}
	else {
		// Hide the search results
		searchResultsView.hidden = YES;
	}
	
	// Forward the message to the searchBarDelegate object
	if ([searchBarDelegate respondsToSelector:@selector(searchBar:textDidChange:)])
		[searchBarDelegate searchBar:theSearchBar textDidChange:searchText];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)theSearchBar {
	// Forward the message to the searchBarDelegate object
	if ([searchBarDelegate respondsToSelector:@selector(searchBarTextDidEndEditing:)])
		[searchBarDelegate searchBarTextDidEndEditing:theSearchBar];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)theSearchBar {
	// Forward the message to the searchBarDelegate object
	if ([searchBarDelegate respondsToSelector:@selector(searchBarBookmarkButtonClicked:)])
		[searchBarDelegate searchBarBookmarkButtonClicked:theSearchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar {
	// Forward the message to the searchBarDelegate object
	if ([searchBarDelegate respondsToSelector:@selector(searchBarCancelButtonClicked:)])
		[searchBarDelegate searchBarCancelButtonClicked:theSearchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	// Forward the message to the searchBarDelegate object
	if ([searchBarDelegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
		[searchBarDelegate searchBarSearchButtonClicked:theSearchBar];
}

@end
