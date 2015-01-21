//
//  SearchResultsProtocol.h
//  iTicket
//
//  Created by Matteo Cortonesi on 20/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SearchResultsDataSource

- (id)searchResultForRow:(NSUInteger)row;

@end