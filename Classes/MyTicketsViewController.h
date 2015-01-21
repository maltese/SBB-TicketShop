//
//  MyTicketsViewController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 5/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTicketsPageViewController;

@interface MyTicketsViewController : UIViewController {
	UIPageControl *pageControl;
	UIScrollView *scrollView;
	NSMutableArray *ticketsControllers;
	NSUInteger ticketsCount;
	NSMutableArray *tickets;
	UILabel *noTicketsLabel;
	
	// To be used when scrolls originate from the UIPageControl
	BOOL *pageControlUsed;
}

@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *ticketsControllers;
@property (nonatomic, retain) NSMutableArray *tickets;
@property (nonatomic, retain) IBOutlet UILabel *noTicketsLabel;

- (void)loadTickets;

- (void)deleteTicketWithViewController:(MyTicketsPageViewController *)theViewController;

- (IBAction)pageControlerValueChanged:(id)sender;

@end
