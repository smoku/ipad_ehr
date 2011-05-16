// 
//  Medication.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Medication.h"

#import "Profile.h"

@implementation Medication 

@dynamic guid;
@dynamic profileGuid;
@dynamic endedDate;
@dynamic frequency;
@dynamic dose;
@dynamic note;
@dynamic strength;
@dynamic startedDate;
@dynamic route;
@dynamic name;
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
			@"route", @"route",
			@"dose", @"dose",
			@"frequency", @"frequency",
			@"started_date", @"startedDate",
			@"ended_date", @"endedDate",
			@"strength", @"strength",
			@"note", @"note",
			nil];
}

+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"profile", @"profileGuid",
			nil];
}



@end
