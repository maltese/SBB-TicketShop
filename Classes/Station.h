//
//  Station.h
//  iTicket
//
//  Created by Matteo Cortonesi on 19/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kIdentifierKey;
extern NSString *kNameKey;
extern NSString *kLongitudeKey;
extern NSString *kLatitudeKey;

@interface Station : NSObject {
	NSNumber *identifier;
	NSString *name;
	NSNumber *longitude;
	NSNumber *latitude;
}

@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSNumber *latitude;

+ (Station *)stationWithDictionary:(NSDictionary *)aDictionary;

- (id)initWithDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)encode;

@end
