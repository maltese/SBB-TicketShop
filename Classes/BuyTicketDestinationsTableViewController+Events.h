//
//  BuyTicketDestinationsTableViewController+Events.h
//  iTicket
//
//  Created by Matteo Cortonesi on 25/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BuyTicketDestinationsTableViewController.h"

enum segmentedControlValue {
	allStationsSelected,
	favoriteStationsSelected
};

@interface BuyTicketDestinationsTableViewController (Events)

- (IBAction)doneButtonTouchUpInside:(id)sender;

- (IBAction)segmentedControlValueChanged:(id)sender;

- (IBAction)addButtonTouchUpInside:(id)sender;

- (IBAction)cancelAddFavoriteStationButtonTouchUpInside:(id)sender;

@end
