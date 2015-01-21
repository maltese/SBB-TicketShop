//
//  TimetableCellEmpty.h
//  iTicket
//
//  Created by Matteo Cortonesi on 14/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TimetableCellEmpty : UITableViewCell {
	// View
	UILabel *textLabel;
	UIActivityIndicatorView *activityIndicator;
	
	// Model
	NSString *text;
}

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSString *text;

@end
