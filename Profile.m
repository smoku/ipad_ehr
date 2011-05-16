// 
//  Profile.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Profile.h"

#import "Medication.h"
#import "Result.h"

@implementation Profile 

@dynamic gender;
@dynamic bloodType;
@dynamic birthDate;
@dynamic guid;
@dynamic name;
@dynamic results;
@dynamic medications;

#pragma mark Mappable methods

+ (NSString*)primaryKeyProperty {
	return @"guid";
}

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"id", @"guid",
			@"name", @"name",
			@"birth_date", @"birthDate",
			@"blood_type", @"bloodType",
			@"gender", @"gender",			
			nil];
}

+ (NSDictionary*)elementToRelationshipMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"results", @"results",
			@"medications", @"medications",
			nil];
}

@end
