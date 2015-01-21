//
//  OneTapCell.h
//  iTicket
//
//  Created by Matteo Cortonesi on 18/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ticket;

@interface OneTapCell : UITableViewCell {
	// View
	UILabel *departureStationLabel;
	UILabel *destinationStationLabel;
	UIImageView *journeyImageView;
	UILabel *fareLabel;
	UIImageView *classImageView;
	UILabel *classLabel;
	UIImageView *fareImageView;
	
	// Model
	Ticket *ticket;
}

@property (nonatomic, retain) IBOutlet UILabel *departureStationLabel;
@property (nonatomic, retain) IBOutlet UILabel *destinationStationLabel;
@property (nonatomic, retain) IBOutlet UIImageView *journeyImageView;
@property (nonatomic, retain) IBOutlet UIImageView *classImageView;
@property (nonatomic, retain) IBOutlet UIImageView *fareImageView;
@property (nonatomic, retain) IBOutlet UILabel *fareLabel;
@property (nonatomic, retain) IBOutlet UILabel *classLabel;
@property (nonatomic, retain) Ticket *ticket;

@end
