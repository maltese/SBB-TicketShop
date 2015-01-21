//
//  BuyTicketOptionsTableViewController.m
//  iTicket
//
//  Created by Matteo Cortonesi on 30/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "BuyTicketOptionsTableViewController.h"

#import "iTicketAppDelegate.h"
#import "Ticket.h"
#import "BuyTicketNavigationController.h"
#import "TimetableOverviewController.h"
#import "Connections.h"

NSString *kNormalCell = @"normalCell";
NSString *kBuyTicketOptionsFileName = @"BuyTicketOptions";

@interface BuyTicketOptionsTableViewController (PrivateMethods)

- (void)readOptionsPlist;
- (void)bringUpDatePicker;
- (NSUInteger)getIdFromSection:(NSUInteger)section;

@end

@implementation BuyTicketOptionsTableViewController

@synthesize tableView;
@synthesize checkoutButton;
@synthesize datePicker;
@synthesize sections;
@synthesize pickerView;

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Set the ticket date
	NSDate *todaysDate = [NSDate date];
	datePicker.minimumDate = todaysDate;
	[datePicker setDate:todaysDate animated:NO];
	((BuyTicketNavigationController *)[self navigationController]).ticket.validityDate = todaysDate;
	
	id navigationController = [self navigationController];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[[navigationController ticket] setTicketDirection:[userDefaults integerForKey:kOptionsTicketDirectionKey]];
	[[navigationController ticket] setTicketClass:[userDefaults integerForKey:kOptionsTicketClassKey]];
	[[navigationController ticket] setTicketFare:[userDefaults integerForKey:kOptionsTicketFareKey]];	
	
	// Set the title and prompt properties of the options navigation item
	self.navigationItem.title = NSLocalizedString(@"Options", @"Title of the options navigation item");
	self.navigationItem.prompt = NSLocalizedString(@"Choose the ticket options",@"");
	
	// Add the buy button to the navigation item
	[self.navigationItem setRightBarButtonItem:checkoutButton];
	
	[self readOptionsPlist];
}

- (void)dealloc {
	[tableView release];
	[checkoutButton release];
	[datePicker release];
	[sections release];
	[pickerView release];
	
	[super dealloc];
}

- (void)readOptionsPlist {
	NSString *path = [[NSBundle mainBundle] pathForResource:kBuyTicketOptionsFileName ofType:@"plist"];
	self.sections = [NSArray arrayWithContentsOfFile:path];
}

// UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[sections objectAtIndex:section] objectForKey:kContentKey] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[sections objectAtIndex:section] objectForKey:kSectionNameKey];
}

// UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:kNormalCell];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:kNormalCell] autorelease];
	}
	
	NSUInteger section = indexPath.section;
	NSUInteger sectionId = [self getIdFromSection:section];

	if (sectionId == DateSection) {
		cell.image = nil;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterFullStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		NSDate *date = ((BuyTicketNavigationController *)[self navigationController]).ticket.validityDate;
		cell.text = [dateFormatter stringFromDate:date];
		[dateFormatter release];
	} else if (sectionId == TimetableSection) {
		cell.image = [UIImage imageNamed:@"TimetableIcon.png"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} else if (sectionId == SaveAs1TapTicketSection) {
		cell.image = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
	} else {
		NSInteger checkedRow;
		UIImage *icon;
		switch (sectionId) {
			case JourneySection:
				checkedRow = [[NSUserDefaults standardUserDefaults] integerForKey:kOptionsTicketDirectionKey];
				switch (indexPath.row) {
					case TicketDirectionOneWay:
						icon = [UIImage imageNamed:@"OneWay.png"];
						break;
					case TicketDirectionRoundTrip:
						icon = [UIImage imageNamed:@"RoundTrip.png"];
						break;
				}
				break;
			case ClassSection:
				checkedRow = [[NSUserDefaults standardUserDefaults] integerForKey:kOptionsTicketClassKey];
				switch (indexPath.row) {
					case TicketClassFirst:
						icon = [UIImage imageNamed:@"FirstClass.png"];
						break;
					case TicketClassSecond:
						icon = [UIImage imageNamed:@"SecondClass.png"];
						break;
				}
				break;
			case FareSection:
				checkedRow = [[NSUserDefaults standardUserDefaults] integerForKey:kOptionsTicketFareKey];
				switch (indexPath.row) {
					case TicketFareFull:
						icon = [UIImage imageNamed:@"FullFare.png"];
						break;
					case TicketFareHalf:
						icon = [UIImage imageNamed:@"HalfFare.png"];
						break;
				}
				break;
		}
		cell.image = icon;
		cell.accessoryType = indexPath.row == checkedRow ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	}
	
	NSString *cellText = [[[sections objectAtIndex:section] objectForKey:kContentKey] objectAtIndex:indexPath.row];
	// If cellText is empty, then it is meant as a place holder, don't set the text property
	if (![cellText isEqualToString:@""]) {
		cell.text = cellText;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger sectionId = [self getIdFromSection:indexPath.section];
	
	if (sectionId == DateSection) {
		// Bring up the date picker
		[self bringUpDatePicker];
		// Scroll the tableview so that the date cell is visible (unelegant but effective)
		[theTableView scrollRectToVisible:CGRectMake(0, 490, 320, 1) animated:NO];
		[theTableView scrollRectToVisible:CGRectMake(0, 30, 320, 1) animated:NO];
	} else if (sectionId == TimetableSection) { // Timetable
		// Deselect the row with animation
		[theTableView deselectRowAtIndexPath:indexPath animated:YES];
		
		TimetableOverviewController *controller = [[TimetableOverviewController alloc]
												   initWithNibName:kTimetableOverviewNib bundle:nil];
		[[self navigationController] pushViewController:controller animated:YES];
		[controller release];
	} else if (sectionId == SaveAs1TapTicketSection) { // Save as 1-Tap Ticket
		// Deselect the row with animation
		[theTableView deselectRowAtIndexPath:indexPath animated:YES];
		
		// Save the current ticket
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		
		// Get the 1-tap tickets array
		NSMutableArray *oneTapTickets = [[userDefaults arrayForKey:k1TapTicketsKey] mutableCopy];
		[oneTapTickets insertObject:[[(id)[self navigationController] ticket] encode] atIndex:0];
		
		// Save the new 1-tap tickets array
		[userDefaults setObject:oneTapTickets forKey:k1TapTicketsKey];
		
		[oneTapTickets release];
	} else {
		id navigationController = [self navigationController];
		switch (sectionId) {
			case JourneySection:
				[[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:kOptionsTicketDirectionKey];
				[[navigationController ticket] setTicketDirection:indexPath.row];
				break;
			case ClassSection:
				[[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:kOptionsTicketClassKey];
				[[navigationController ticket] setTicketClass:indexPath.row];
				break;
			case FareSection:
				[[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:kOptionsTicketFareKey];
				[[navigationController ticket] setTicketFare:indexPath.row];
				break;
		}
		
		// Reload the data of the table
		[theTableView reloadData];
		// Reselect the selected row
		[theTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
		// Use a timer to fire a method that will deselect the currently selected row
		NSTimer *deselectionTimer = [NSTimer scheduledTimerWithTimeInterval:0.001
																	 target:self
																   selector:@selector(deselectionTimerFireMethod:)
																   userInfo:indexPath
																	repeats:NO];
	}
}

// Private Methods

- (void)deselectionTimerFireMethod:(NSTimer*)theTimer {
	[self.tableView deselectRowAtIndexPath:[theTimer userInfo] animated:YES];
}

-(void)bringUpDatePicker {
	datePicker.date = ((BuyTicketNavigationController *)[self navigationController]).ticket.validityDate;
	checkoutButton.enabled = NO;
	tableView.userInteractionEnabled = NO;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
	CGRect picketViewFrame = pickerView.frame;
	pickerView.frame = CGRectOffset(picketViewFrame, 0, -picketViewFrame.size.height);
	[UIView commitAnimations];
}

-(void)bringDownDatePicker {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.35];
	CGRect picketViewFrame = pickerView.frame;
	pickerView.frame = CGRectOffset(picketViewFrame, 0, picketViewFrame.size.height);
	[UIView commitAnimations];
	checkoutButton.enabled = YES;
	tableView.userInteractionEnabled = YES;
	[tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES];
}

- (NSUInteger)getIdFromSection:(NSUInteger)section {
	return [[[sections objectAtIndex:section] objectForKey:kIdKey] unsignedIntValue];
}

@end

