//
//  DetailedViewCell.h
//  iTicket
//
//  Created by Matteo Cortonesi on 17/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailedViewCell : UITableViewCell {
	UILabel *stationNameLabel;
	UILabel *timeLabel;
	UILabel *trackLabel;
	UILabel *commentsLabel;
	UIImageView *trackImage;
}

@property (nonatomic, retain) IBOutlet UILabel *stationNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *trackLabel;
@property (nonatomic, retain) IBOutlet UILabel *commentsLabel;
@property (nonatomic, retain) IBOutlet UIImageView *trackImage;

@end
