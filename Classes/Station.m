//
//  Station.m
//  iTicket
//
//  Created by Matteo Cortonesi on 19/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

#import "Station.h"


@implementation Station

@synthesize identifier;
@synthesize name;
@synthesize longitude;
@synthesize latitude;

NSString *kIdentifierKey = @"identifier";
NSString *kNameKey = @"name";
NSString *kLongitudeKey = @"longitude";
NSString *kLatitudeKey = @"latitude";

+ (Station *)stationWithDictionary:(NSDictionary *)aDictionary {
	Station *station = [[Station alloc] initWithDictionary:aDictionary];
	return [station autorelease];
}

- (id)initWithDictionary:(NSDictionary *)aDictionary {
	if (self = [self init]) {
		self.identifier = [aDictionary objectForKey:kIdentifierKey];
		self.name = [aDictionary objectForKey:kNameKey];
		self.longitude = [aDictionary objectForKey:kLongitudeKey];
		self.latitude = [aDictionary objectForKey:kLatitudeKey];
	}
	return self;
}

- (NSDictionary *)encode {
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setObject:identifier forKey:kIdentifierKey];
	[dictionary setObject:name forKey:kNameKey];
	[dictionary setObject:longitude forKey:kLongitudeKey];
	[dictionary setObject:latitude forKey:kLatitudeKey];
	return dictionary;
}

- (void)dealloc {
	[identifier release];
	[name release];
	[longitude release];
	[latitude release];
	
	[super dealloc];
}

@end
