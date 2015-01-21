//
//  BuyTicketDeparturesTableViewController+Events.h
//  iTicket
//
//  Created by Matteo Cortonesi on 17/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BuyTicketDeparturesTableViewController.h"

enum segmentedControlValue {
	allStationsSelected,
	nearbyStationsSelected
};

@interface BuyTicketDeparturesTableViewController (Events)

- (IBAction)doneButtonTouchUpInside:(id)sender;

- (IBAction)segmentedControlValueChanged:(id)sender;

@end
