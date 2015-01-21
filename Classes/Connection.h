//
//  Connection.h
//  iTicket
//
//  Created by Matteo Cortonesi on 13/9/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kDepartureTimeKey;
extern NSString *kArrivalTimeKey;
extern NSString *kChangesKey;

@interface Connection : NSObject {
	NSString *departureHour;
	NSString *departureMinute;
	NSString *arrivalHour;
	NSString *arrivalMinute;
	NSString *changes;
}

@property (nonatomic, copy) NSString *departureHour;
@property (nonatomic, copy) NSString *departureMinute;
@property (nonatomic, copy) NSString *arrivalHour;
@property (nonatomic, copy) NSString *arrivalMinute;
@property (nonatomic, copy) NSString *changes;

- (id)initWithDictionary:(NSDictionary *)aDictionary;

@end
