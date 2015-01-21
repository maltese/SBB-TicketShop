//
//  BuyTicketCheckoutViewController+Events.m
//  iTicket
//
//  Created by Matteo Cortonesi on 1/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketCheckoutViewController+Events.h"

#import "BuyTicketNavigationController.h"
#import "iTicketAppDelegate.h"
#import "iTicketTabBarController.h"
#import "BuyTicketLoginViewController.h"
#import "Ticket.h"
#import "MyTicketsViewController.h"

#define kSwooshAnimationDuration 1.0

NSString *kAmountButtonTouchUpInsideAnimation = @"AmountButtonTouchUpInsideAnimation";
NSString *kBuyButtonTouchUpInsideAnimation = @"BuyButtonTouchUpInsideAnimation";
NSString *kActivityIndicatorAnimation = @"ActivityIndicatorAnimation";
NSString *kTicketSwooshAnimation = @"TicketSwoosh1Animation";

@interface BuyTicketCheckoutViewController (PrivateMethods)

- (void)performSwooshAnimation;
- (void)saveTicket:(Ticket *)ticket;

@end


@implementation BuyTicketCheckoutViewController (Events)

- (void)amountButtonTouchUpInside:(id)sender {
	[UIView beginAnimations:kAmountButtonTouchUpInsideAnimation context:NULL];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	amountButton.alpha = 0.0;
	buyButton.hidden = NO;
	buyButton.alpha = 1.0;
	[UIView commitAnimations];
}

- (void)buyButtonTouchUpInside:(id)sender {
	// Load the username and password for the ticket shop login
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *username = [standardUserDefaults stringForKey:kUsernameKey];
	NSString *password = [standardUserDefaults stringForKey:kPasswordKey];
	// If the user hasn't entered a username and password yet, push a modal view controller
	// that prompts the user for the login information
	
	if (username == nil || password == nil || [username isEqualToString:@""] || [password isEqualToString:@""]) {
		BuyTicketLoginViewController *loginViewController = [[BuyTicketLoginViewController alloc]
															 initWithNibName:kBuyTicketLoginNib
															 bundle:nil];
		loginViewController.viewController = self;
		
		[self presentModalViewController:loginViewController animated:YES];
	} else {
		[self buyTicket];
	}
}

- (void)animationDidStop:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
	if ([animationID isEqualToString:kAmountButtonTouchUpInsideAnimation]) {
		amountButton.hidden = YES;
	} else if ([animationID isEqualToString:kBuyButtonTouchUpInsideAnimation]) {
		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2
														  target:self
														selector:@selector(ticketBought:)
														userInfo:nil
														 repeats:NO];
	} else if ([animationID isEqualToString:kActivityIndicatorAnimation]) {
		[self performSwooshAnimation];
	}
}

- (void)performSwooshAnimation {
	buyingTicketIndicator.hidden = YES;
	[ticketView removeFromSuperview];
	ticketView.frame = CGRectOffset(ticketView.frame, 0, 64);
	[((iTicketAppDelegate *)[[UIApplication sharedApplication] delegate]).window
	 addSubview:ticketView];
	
	// Extract the Core Animation layer
	CALayer *ticketLayer = ticketView.layer;
	
	// Fix the flashing problem.
	ticketLayer.opacity = 0.0;
	
	// Create a swoosh animation by distorting the ticket (like it is suck in)
	
	// Create a distortion animation
	CAKeyframeAnimation *perspectiveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	perspectiveAnimation.duration = kSwooshAnimationDuration;
	
	// Create a transform matrix to apply the perspective effect.
	CATransform3D transform = CATransform3DMakeScale(0.15, 0.15, 1);
	transform.m24 = 0.0015; // Distortion
	
	// Create the transform matrix that represents the final dimension of the ticket
	CATransform3D transform2 = CATransform3DMakeScale(0.07, 0.07, 1);
	
	// Adds the 3 keyframes to the animation
	perspectiveAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:CATransform3DIdentity],
								   [NSValue valueWithCATransform3D:transform],
								   [NSValue valueWithCATransform3D:transform2],
								   [NSValue valueWithCATransform3D:transform2], nil];
	
	// Set the time for the 3 keyframes
	perspectiveAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
									 [NSNumber numberWithFloat:0.85],
									 [NSNumber numberWithFloat:0.95],
									 [NSNumber numberWithFloat:1.0], nil];
	// End distortion animation
	
	// Create the translation animation
	CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	moveAnimation.duration = kSwooshAnimationDuration;
	CGPoint point1 = ticketLayer.position;
	CGPoint point2 = CGPointMake(ticketLayer.position.x + 40, 420);
	CGPoint point3 = CGPointMake(ticketLayer.position.x + 40, 455);
	moveAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:point1],
							[NSValue valueWithCGPoint:point2],
							[NSValue valueWithCGPoint:point3],nil];
	moveAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
							  [NSNumber numberWithFloat:0.85],
							  [NSNumber numberWithFloat:1.0], nil];
	// End translation animation
	
	// Create the opacity animation
	CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
	opacityAnimation.duration = kSwooshAnimationDuration;
	
	// Adds the 3 keyframes to the animation
	opacityAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0],
							   [NSNumber numberWithFloat:1.0],
							   [NSNumber numberWithFloat:0.0], nil];		
	// Set the time for the 3 keyframes
	opacityAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
								 [NSNumber numberWithFloat:0.95],
								 [NSNumber numberWithFloat:1.0], nil];
	// End opacity animation
	
	// Create an animation group to combine all the animations
	CAAnimationGroup *theGroup = [CAAnimationGroup animation];
	theGroup.delegate = self;
	theGroup.duration = kSwooshAnimationDuration;
	theGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	theGroup.animations = [NSArray arrayWithObjects:perspectiveAnimation, moveAnimation, opacityAnimation, nil];
	// End group animation
	
	[ticketLayer addAnimation:theGroup forKey:kTicketSwooshAnimation];	
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	[ticketView removeFromSuperview];
	
	[[self navigationController] popToRootViewControllerAnimated:NO];
	
	iTicketAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	appDelegate.tabBarController.selectedIndex = MyTicketsTabBarSection;
	[(MyTicketsViewController *)appDelegate.tabBarController.selectedViewController loadTickets];
}

- (void)ticketBought:(NSTimer *)theTimer {
	[UIView beginAnimations:kActivityIndicatorAnimation context:NULL];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	buyButton.hidden = YES;
	buyingTicketIndicator.alpha = 0.0;
		
	[UIView commitAnimations];
	
	// Save the ticket
	Ticket *ticket = ((BuyTicketNavigationController *)[self navigationController]).ticket;
	[self saveTicket:ticket];
}

- (void)buyTicket {
	[UIView beginAnimations:kBuyButtonTouchUpInsideAnimation context:NULL];
	[UIView setAnimationDuration:0.35];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	buyButton.alpha = 0;
	buyingTicketIndicator.hidden = NO;
	buyingTicketIndicator.alpha = 1.0;
	[self.navigationItem setHidesBackButton:YES animated:YES];
	
	[UIView commitAnimations];
}
	
- (void)saveTicket:(Ticket *)ticket {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	// Get the my tickets array
	NSMutableArray *myTickets = [[userDefaults arrayForKey:kMyTicketsKey] mutableCopy];
	[myTickets insertObject:[ticket encode] atIndex:0];
	
	// Save the new my tickets array
	[userDefaults setObject:myTickets forKey:kMyTicketsKey];
	
	[myTickets release];
}

@end
