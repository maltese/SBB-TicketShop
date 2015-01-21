//
//  InputCell.h
//  iTicket
//
//  Created by Matteo Cortonesi on 3/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InputCell : UITableViewCell {
	UITextField *textField;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;

@end
