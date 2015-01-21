//
//  TimetableCell.h
//  iTicket
//
//  Created by Matteo Cortonesi on 12/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Connection;

@interface TimetableCell : UITableViewCell {
	// Model
	Connection *connection;
	
	// User Interface
	UILabel *departureHourLabel;
	UILabel *departureMinuteLabel;
	UILabel *arrivalHourLabel;
	UILabel *arrivalMinuteLabel;
	UILabel *changesLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *departureHourLabel;
@property (nonatomic, retain) IBOutlet UILabel *departureMinuteLabel;
@property (nonatomic, retain) IBOutlet UILabel *arrivalHourLabel;
@property (nonatomic, retain) IBOutlet UILabel *arrivalMinuteLabel;
@property (nonatomic, retain) IBOutlet UILabel *changesLabel;
@property (nonatomic, retain) Connection *connection;

@end
