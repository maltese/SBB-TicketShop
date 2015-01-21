//
//  BuyTicketOptionsTableViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 30/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

enum SectionsNames {
	DateSection,
	JourneySection,
	ClassSection,
	FareSection,
	TimetableSection,
	SaveAs1TapTicketSection
};

@interface BuyTicketOptionsTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView *tableView;
	UIBarButtonItem *checkoutButton;
	UIDatePicker *datePicker;
	UIView *pickerView;
	
	NSArray *sections;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *checkoutButton;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UIView *pickerView;
@property (nonatomic, retain) NSArray *sections;

@end
