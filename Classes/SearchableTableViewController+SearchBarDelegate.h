//
//  SearchableTableViewController+SearchBarDelegate.h
//  iTicket
//
//  Created by Matteo Cortonesi on 18/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchableTableViewController.h"

@interface SearchableTableViewController (SearchBarDelegate) <UISearchBarDelegate>

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar;

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

@end
