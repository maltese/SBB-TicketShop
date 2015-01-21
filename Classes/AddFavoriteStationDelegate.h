//
//  AddFavoriteStationDelegate.h
//  iTicket
//
//  Created by Matteo Cortonesi on 28/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddFavoriteStationDelegate : NSObject <UITableViewDelegate> {
	UIViewController *viewController;
}

@property (nonatomic, assign) UIViewController *viewController;

- (id)initWithViewController:(UIViewController *)aViewController;

@end
