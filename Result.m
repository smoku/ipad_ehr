// 
//  Result.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Result.h"

#import "Profile.h"

@implementation Result 

@dynamic guid;
@dynamic profileGuid;
@dynamic result;
@dynamic date;
@dynamic units;
@dynamic name;
@dynamic note;
@dynamic profile;


#pragma mark Mappable methods

+ (NSString*)primaryKeyProperty {
	return @"guid";
}

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"guid",
            @"profile_id", @"profileGuid",
			@"name", @"name",
			@"result", @"result",
			@"date", @"date",
			@"units", @"units",
			@"note", @"note",
			nil];
}

+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"profile", @"profileGuid",
			nil];
}

@end
