//
//  BuyTicketLoginViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 3/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketLoginViewController.h"

#import "UIFactory.h"
#import "InputCell.h"
#import "BuyTicketCheckoutViewController+Events.h"
#import "iTicketAppDelegate.h"

NSString *kInputCellIdentifier = @"InputCell";
NSString *kInputCellNib = @"InputCell";

@implementation BuyTicketLoginViewController

@synthesize loginTable;
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize viewController;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Set the background color
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)dealloc {
	[usernameTextField release];
	[passwordTextField release];
	[loginTable release];
	
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	InputCell *cell = (InputCell *) [tableView dequeueReusableCellWithIdentifier:kInputCellIdentifier];
	if (cell == nil) {
		cell = (InputCell *) [UIFactory newUIObjectFromNib:kInputCellNib];
	}
	
	switch (indexPath.section) {
		case UsernameSection:
			self.usernameTextField = cell.textField;
			usernameTextField.delegate = self;
			usernameTextField.placeholder = NSLocalizedString(@"Username",@"Displayed in the ticket shop login modal view");
			usernameTextField.secureTextEntry = NO;
			[usernameTextField becomeFirstResponder];
			break;
		case PasswordSection:
			self.passwordTextField = cell.textField;
			passwordTextField.delegate = self;
			passwordTextField.placeholder = NSLocalizedString(@"Password",@"Displayed in the ticket shop login modal view");
			passwordTextField.secureTextEntry = YES;
			break;
	}
	
	return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == usernameTextField) {
		[passwordTextField becomeFirstResponder];
	} else if (textField == passwordTextField) {
		[self doneButtonTouchUpInside:self];
	}
	return NO;
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneButtonTouchUpInside:(id)sender {
	if (!([usernameTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""])) {
		NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
		[standardUserDefaults setObject:usernameTextField.text forKey:kUsernameKey];
		[standardUserDefaults setObject:passwordTextField.text forKey:kPasswordKey];
		
		[[self parentViewController] dismissModalViewControllerAnimated:YES];
		[(BuyTicketCheckoutViewController *) viewController buyTicket];
	}
}

@end

