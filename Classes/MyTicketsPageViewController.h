//
//  MyTicketsPageViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 5/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ticket;
@class MyTicketsViewController;

@interface MyTicketsPageViewController : UIViewController {
	UILabel *departureStation1;
	UILabel *departureStation2;
	UILabel *destinationStation1;
	UILabel *destinationStation2;
	UILabel *ticketClass;
	UILabel *ticketValidityDate;
	UILabel *ticketPrice;
	UIButton *deleteTicketButton;
	UIView *containerView;
	UIView *ticketView;
	UIView *backTicketView;
	
	Ticket *ticket;
	MyTicketsViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UILabel *departureStation1;
@property (nonatomic, retain) IBOutlet UILabel *departureStation2;
@property (nonatomic, retain) IBOutlet UILabel *destinationStation1;
@property (nonatomic, retain) IBOutlet UILabel *destinationStation2;
@property (nonatomic, retain) IBOutlet UILabel *ticketClass;
@property (nonatomic, retain) IBOutlet UILabel *ticketValidityDate;
@property (nonatomic, retain) IBOutlet UILabel *ticketPrice;
@property (nonatomic, retain) IBOutlet UIButton *deleteTicketButton;
@property (nonatomic, retain) IBOutlet UIView *containerView;
@property (nonatomic, retain) IBOutlet UIView *ticketView;
@property (nonatomic, retain) IBOutlet UIView *backTicketView;

@property (nonatomic, retain) IBOutlet Ticket *ticket;

@property (nonatomic, assign) MyTicketsViewController *viewController;

- (id)initWithTicket:(Ticket *)theTicket viewController:(MyTicketsViewController *)theViewController;

- (IBAction)flipToBackButtonTouchUpInside:(id)sender;

- (IBAction)flipToFrontButtonTouchUpInside:(id)sender;

@end
