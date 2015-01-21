//
//  OneTapTicketsViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 18/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OneTapTicketsViewController : UIViewController {
	UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
