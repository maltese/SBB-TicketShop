//
//  OneTapNavigationController.h
//  iTicket
//
//  Created by Matteo Cortonesi on 18/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ticket;

@interface OneTapNavigationController : UINavigationController {
	Ticket *ticket;
}

@property (nonatomic, retain) Ticket *ticket;

@end
