//
//  MyTicketsViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 5/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "MyTicketsViewController.h"

#import "iTicketAppDelegate.h"
#import "MyTicketsPageViewController.h"
#import "Ticket.h"

#define kAnimationDuration 0.35

NSString *kTicketDisappearAnimation = @"ticketDisappearAnimation";
NSString *kDeleteTicketAnimation = @"deleteTicketAnimation";

@interface MyTicketsViewController (PrivateMethods)

- (void)loadScrollViewWithPage:(NSInteger)page;

@end

@implementation MyTicketsViewController

@synthesize pageControl;
@synthesize scrollView;
@synthesize ticketsControllers;
@synthesize tickets;
@synthesize noTicketsLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self loadTickets];
}

- (void)dealloc {
	[pageControl release];
	[scrollView release];
	[ticketsControllers release];
	[tickets release];
	[noTicketsLabel release];

    [super dealloc];
}

- (void)loadTickets {
	// Empty the scroll view
	NSArray *theSubviews = [scrollView subviews];
	for (UIView *aView in theSubviews) {
		[aView removeFromSuperview];
	}
	// update the scroll view to the first page
    CGRect frame = scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:NO];
	
	// Tickets controllers are created lazily
	// In the meantime, load the array with placeholders which will be replaced on demand
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
	
	self.tickets = [NSMutableArray array];
	// Load the tickets from the user defaults
	for (NSDictionary *ticketDictionary in [[NSUserDefaults standardUserDefaults] objectForKey:kMyTicketsKey]) {
		Ticket *ticket = [[Ticket alloc] initWithDictionary:ticketDictionary];
		[tickets addObject:ticket];
		[ticket release];
	}
	
	ticketsCount = [tickets count];
	
	for (unsigned i = 0; i < ticketsCount; i++) {
		[controllers addObject:[NSNull null]];
	}
	self.ticketsControllers = controllers;
	[controllers release];
	
	// A page is the width of the scroll view
	scrollView.contentSize =
	CGSizeMake(scrollView.frame.size.width * ticketsCount, scrollView.frame.size.height);
	
	pageControl.numberOfPages = ticketsCount;
	pageControl.currentPage = 0;
	
	// Pages are created on demand
	// Load the visible page
	// Load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
	
	noTicketsLabel.hidden = ticketsCount > 0;
}

- (void)loadScrollViewWithPage:(NSInteger)page {
    if (page < 0) return;
    if (page >= ticketsCount) return;
	
    // replace the placeholder if necessary
	MyTicketsPageViewController *controller = [ticketsControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
		controller = [[MyTicketsPageViewController alloc] initWithTicket:[tickets objectAtIndex:page]
														  viewController:self];
		[ticketsControllers replaceObjectAtIndex:page withObject:controller];
		[controller release];
    }
	
    // Add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)pageControlerValueChanged:(id)sender {
    NSInteger page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

- (void)deleteTicketWithViewController:(MyTicketsPageViewController *)theViewController {
	// Disable temporarily the scrolling
	scrollView.scrollEnabled = NO;
	
	// Search the view controller
	MyTicketsPageViewController *aController;
	BOOL found = NO;
	unsigned i;
	for (i = 0; i < ticketsCount, !found; i++) {
		aController = [ticketsControllers objectAtIndex:i];
		// If found
		if (aController == theViewController) {
			found = YES;
		}
	}
	
	if (found) {
		[UIView beginAnimations:kTicketDisappearAnimation context:[NSNumber numberWithInt:i - 1]];
		[UIView setAnimationDuration:kAnimationDuration];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
		theViewController.view.alpha = 0.0;
		[UIView commitAnimations];				
	}
}

- (void)animationDidStop:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
	if ([animationID isEqualToString:kTicketDisappearAnimation]) {
		[UIView beginAnimations:kDeleteTicketAnimation context:context];
		[UIView setAnimationDuration:kAnimationDuration];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
		
		NSUInteger ticketIndexToDelete = [(NSNumber *)context integerValue];
		MyTicketsPageViewController *aController;
		
		// If it is not at the end of the array
		if (ticketIndexToDelete != ticketsCount - 1) {
			for (unsigned j = ticketIndexToDelete; j < ticketsCount; j++) {
				aController = [ticketsControllers objectAtIndex:j];
				if ((NSNull *)aController != [NSNull null]) {
					CGRect frame = aController.view.frame;
					aController.view.frame = CGRectOffset(frame, -scrollView.frame.size.width, 0);
				}
			}
		} else { // It is at the end of the array
			aController = [ticketsControllers objectAtIndex:ticketIndexToDelete];
			CGRect frame = aController.view.frame;
			aController.view.frame = CGRectOffset(frame, -scrollView.frame.size.width, 0);
			
			pageControl.currentPage = ticketsCount - 2;
			[self pageControlerValueChanged:self];
		}
		
		[UIView commitAnimations];
	} else if ([animationID isEqualToString:kDeleteTicketAnimation]) {
		// Delete the ticket and update the data structures and ui elements
		NSUInteger ticketIndexToDelete = [(NSNumber *)context integerValue];
		[tickets removeObjectAtIndex:ticketIndexToDelete];
		ticketsCount = [tickets count];
		[((MyTicketsPageViewController *)[ticketsControllers objectAtIndex:ticketIndexToDelete]).view removeFromSuperview];
		[ticketsControllers removeObjectAtIndex:ticketIndexToDelete];
		pageControl.numberOfPages = ticketsCount;
		scrollView.contentSize =
			CGSizeMake(scrollView.frame.size.width * ticketsCount, scrollView.frame.size.height);
		
		// Update the defaults
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		// Get the my tickets array
		NSMutableArray *myTickets = [[userDefaults arrayForKey:kMyTicketsKey] mutableCopy];
		[myTickets removeObjectAtIndex:ticketIndexToDelete];
		// Save the new my tickets array
		[userDefaults setObject:myTickets forKey:kMyTicketsKey];
		[myTickets release];

		// load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
		[self loadScrollViewWithPage:ticketIndexToDelete - 1];
		[self loadScrollViewWithPage:ticketIndexToDelete];
		[self loadScrollViewWithPage:ticketIndexToDelete + 1];
		
		// Re-enable the scrolling
		scrollView.scrollEnabled = YES;
		
		noTicketsLabel.hidden = ticketsCount > 0;
	}
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
