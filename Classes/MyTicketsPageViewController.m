//
//  MyTicketsPageViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 5/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "MyTicketsPageViewController.h"

#import "Ticket.h"
#import "Station.h"

#define kFlipAnimationDuration 1.0

NSString *kMyTicketsPageNib = @"MyTicketsPage";

@implementation MyTicketsPageViewController

@synthesize departureStation1;
@synthesize departureStation2;
@synthesize destinationStation1;
@synthesize destinationStation2;
@synthesize ticketClass;
@synthesize ticketValidityDate;
@synthesize ticketPrice;
@synthesize ticket;
@synthesize viewController;
@synthesize deleteTicketButton;
@synthesize containerView;
@synthesize ticketView;
@synthesize backTicketView;

- (id)initWithTicket:(Ticket *)theTicket viewController:(MyTicketsViewController *)theViewController {
	if (self = [self initWithNibName:kMyTicketsPageNib bundle:nil]) {
		self.ticket = theTicket;
		self.viewController = theViewController;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.departureStation1.text = [ticket.departureStation.name uppercaseString];
	self.departureStation2.text = ticket.ticketDirection == TicketDirectionRoundTrip ?
	[ticket.destinationStation.name uppercaseString] :
	@"*";
	self.destinationStation1.text = [ticket.destinationStation.name uppercaseString];
	self.destinationStation2.text = ticket.ticketDirection == TicketDirectionRoundTrip ?
	[ticket.departureStation.name uppercaseString] :
	@"*";
	self.ticketClass.text = ticket.ticketClass == TicketClassFirst ?
	[NSLocalizedString(@"1st","First class abbreviation") uppercaseString] :
	[NSLocalizedString(@"2nd","Second class abbreviation") uppercaseString];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterNoStyle];
	self.ticketValidityDate.text = [formatter stringFromDate:ticket.validityDate];
	[formatter release];

	NSString *priceString = [NSString stringWithFormat:@"%1.2f",[ticket.ticketPrice floatValue]];
	self.ticketPrice.text = priceString;
	
	deleteTicketButton.hidden = !([[NSDate date] timeIntervalSinceDate:ticket.validityDate] > 86400.0);
}

- (void)dealloc {	
	[deleteTicketButton release];
	[departureStation1 release];
	[departureStation2 release];
	[destinationStation1 release];
	[destinationStation2 release];
	[ticketClass release];
	[ticketValidityDate release];
	[ticketPrice release];
	[ticket release];
	[containerView release];
	[ticketView release];
	[backTicketView release];
	
	[super dealloc];
}

- (IBAction)flipToBackButtonTouchUpInside:(id)sender {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kFlipAnimationDuration];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:containerView cache:YES];
	
	[ticketView removeFromSuperview];
	[containerView addSubview:backTicketView];
	
	[UIView commitAnimations];
}

- (IBAction)flipToFrontButtonTouchUpInside:(id)sender {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kFlipAnimationDuration];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
						   forView:containerView cache:YES];
	
	[backTicketView removeFromSuperview];
	[containerView addSubview:ticketView];
	
	[UIView commitAnimations];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

@end
