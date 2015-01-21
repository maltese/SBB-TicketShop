//
//  OneTapTicketsViewController+DataSource.m
//  iTicket
//
//  Created by Matteo Cortonesi on 18/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "OneTapTicketsViewController+DataSource.h"

#import "OneTapCell.h"
#import "UIFactory.h"
#import "iTicketAppDelegate.h"
#import "Ticket.h"

NSString *kOneTapCellIdentifier = @"OneTapCell";
NSString *kOneTapCellNib = @"OneTapCell";

@implementation OneTapTicketsViewController (DataSource)

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	return [[[NSUserDefaults standardUserDefaults] objectForKey:k1TapTicketsKey] count];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSMutableArray *oneTapTickets = [[[NSUserDefaults standardUserDefaults]
									  objectForKey:k1TapTicketsKey] mutableCopy];
	
	NSDictionary *tempTicket = [[oneTapTickets objectAtIndex:fromIndexPath.row] retain];
	[oneTapTickets removeObjectAtIndex:fromIndexPath.row];
	[oneTapTickets insertObject:tempTicket atIndex:toIndexPath.row];
	[tempTicket release];
	
	[[NSUserDefaults standardUserDefaults] setObject:oneTapTickets forKey:k1TapTicketsKey];
	[oneTapTickets release];
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSMutableArray *oneTapTickets = [[[NSUserDefaults standardUserDefaults]
										  objectForKey:k1TapTicketsKey] mutableCopy];
		[oneTapTickets removeObjectAtIndex:indexPath.row];
		[[NSUserDefaults standardUserDefaults] setObject:oneTapTickets forKey:k1TapTicketsKey];
		[oneTapTickets release];
				
		[aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
	}
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	OneTapCell *cell = (OneTapCell *)[aTableView dequeueReusableCellWithIdentifier:kOneTapCellIdentifier];
	if (cell == nil) {
		cell = (OneTapCell *)[[UIFactory newUIObjectFromNib:kOneTapCellNib] autorelease];
	}
	
	NSDictionary *ticketDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:k1TapTicketsKey] objectAtIndex:indexPath.row];
	
	Ticket *ticket = [[Ticket alloc] initWithDictionary:ticketDictionary];
	cell.ticket = ticket;
	[ticket release];
	
	return cell;
}

@end
