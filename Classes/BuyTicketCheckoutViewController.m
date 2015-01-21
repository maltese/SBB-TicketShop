//
//  BuyTicketCheckoutViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 1/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketCheckoutViewController.h"

#import "Ticket.h"
#import "BuyTicketNavigationController.h"
#import "Station.h"
#import "iTicketAppDelegate.h"

@interface BuyTicketCheckoutViewController (PrivateMethods)

- (void)ticketTimerFireMethod:(NSTimer *)theTimer;

- (UIButton *)buttonWithTitle:	(NSString *)title
					   target:(id)target
					 selector:(SEL)selector
						frame:(CGRect)frame
						image:(UIImage *)image
				 imagePressed:(UIImage *)imagePressed
				darkTextColor:(BOOL)darkTextColor;

@end


@implementation BuyTicketCheckoutViewController

@synthesize requestingView;
@synthesize ticketView;
@synthesize buyingTicketIndicator;
@synthesize amountButton;
@synthesize buyButton;

@synthesize departureStation1;
@synthesize departureStation2;
@synthesize destinationStation1;
@synthesize destinationStation2;
@synthesize ticketClass;
@synthesize ticketValidityDate;
@synthesize ticketPrice;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = NSLocalizedString(@"Checkout",@"Title of the checkout navigation item");
	
	Ticket *ticket = [(id)[self navigationController] ticket];
	
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
	
	// Calculate the price just for demo purposes
	NSInteger price = 29;
	price *= ticket.ticketClass == TicketClassFirst ? 2 : 1;
	price *= ticket.ticketDirection == TicketDirectionRoundTrip ? 2 : 1;
	price *= ticket.ticketFare == TicketFareFull ? 2 : 1;
	ticket.ticketPrice = [NSNumber numberWithFloat:(float)price];
	NSString *priceString = [NSString stringWithFormat:@"%1.2f",(float)price];
	self.ticketPrice.text = priceString;
	
	self.amountButton = [self buttonWithTitle:[@"CHF " stringByAppendingString:priceString]
									target:self
									selector:@selector(amountButtonTouchUpInside:)
									frame:CGRectMake(20, 267, 280, 46)
									image:[UIImage imageNamed:@"TranslucentButton.png"]
									imagePressed:[UIImage imageNamed:@"TranslucentButtonPressed.png"]
									darkTextColor:YES];
	
	self.buyButton = [self buttonWithTitle:NSLocalizedString(@"Buy Ticket",@"Title of the buy button in the checkout screen")
									target:self
								  selector:@selector(buyButtonTouchUpInside:)
									 frame:CGRectMake(20, 267, 280, 46)
									 image:[UIImage imageNamed:@"TranslucentButtonRed.png"]
							  imagePressed:[UIImage imageNamed:@"TranslucentButtonRedPressed.png"]
							 darkTextColor:YES];
	buyButton.hidden = YES;
	buyButton.alpha = 0.0;
	
	[ticketView addSubview:amountButton];
	[ticketView addSubview:buyButton];
	
	NSTimer *ticketTimer = [NSTimer scheduledTimerWithTimeInterval:3
															target:self
														  selector:@selector(ticketTimerFireMethod:)
														  userInfo:nil
														   repeats:NO];
}

- (void)dealloc {
	[requestingView release];
	[ticketView release];
	[buyingTicketIndicator release];
	[amountButton release];
	[buyButton release];
	
	[departureStation1 release];
	[departureStation2 release];
	[destinationStation1 release];
	[destinationStation2 release];
	[ticketClass release];
	[ticketValidityDate release];
	[ticketPrice release];
	
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

// Private Methods
- (void)ticketTimerFireMethod:(NSTimer *)theTimer {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	requestingView.hidden = YES;
	CGRect frame = ticketView.frame;
	frame.origin = CGPointMake(0, 20);
	ticketView.frame = frame;
	[UIView commitAnimations];
}

- (UIButton *)buttonWithTitle:	(NSString *)title
					   target:(id)target
					 selector:(SEL)selector
						frame:(CGRect)frame
						image:(UIImage *)image
				 imagePressed:(UIImage *)imagePressed
				darkTextColor:(BOOL)darkTextColor {	
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	[button setTitle:title forState:UIControlStateNormal];	
	if (darkTextColor)
	{
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	}
	else
	{
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	
	UIImage *newImage = [image stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newImage forState:UIControlStateNormal];
	
	UIImage *newPressedImage = [imagePressed stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
	
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
    // in case the parent view draws with a custom color or gradient, use a transparent color
	button.backgroundColor = [UIColor clearColor];
	
	return [button autorelease];
}

@end
