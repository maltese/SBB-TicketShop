//
//  BuyTicketLoginViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 3/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TableSections {
	UsernameSection,
	PasswordSection
};

@interface BuyTicketLoginViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
	UITableView *loginTable;
	UITextField *usernameTextField;
	UITextField *passwordTextField;
	UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UITableView *loginTable;
@property (nonatomic, retain) UITextField *usernameTextField;
@property (nonatomic, retain) UITextField *passwordTextField;
@property (nonatomic, assign) UIViewController *viewController;

- (IBAction)cancelButtonTouchUpInside:(id)sender;

- (IBAction)doneButtonTouchUpInside:(id)sender;

@end
