//
//  BuyTicketCheckoutViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 1/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BuyTicketCheckoutViewController : UIViewController {
	UIView *requestingView;
	UIView *ticketView;
	UIButton *amountButton;
	UIButton *buyButton;
	UIActivityIndicatorView *buyingTicketIndicator;
	
	UILabel *departureStation1;
	UILabel *departureStation2;
	UILabel *destinationStation1;
	UILabel *destinationStation2;
	UILabel *ticketClass;
	UILabel *ticketValidityDate;
	UILabel *ticketPrice;
}

@property (nonatomic, retain) IBOutlet UIView *requestingView;
@property (nonatomic, retain) IBOutlet UIView *ticketView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *buyingTicketIndicator;
@property (nonatomic, retain) UIButton *amountButton;
@property (nonatomic, retain) UIButton *buyButton;

@property (nonatomic, retain) IBOutlet UILabel *departureStation1;
@property (nonatomic, retain) IBOutlet UILabel *departureStation2;
@property (nonatomic, retain) IBOutlet UILabel *destinationStation1;
@property (nonatomic, retain) IBOutlet UILabel *destinationStation2;
@property (nonatomic, retain) IBOutlet UILabel *ticketClass;
@property (nonatomic, retain) IBOutlet UILabel *ticketValidityDate;
@property (nonatomic, retain) IBOutlet UILabel *ticketPrice;

@end
