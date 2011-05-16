//
//  Medication.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class Profile;

@interface Medication :  RKManagedObject  
{
}

@property (nonatomic, retain) NSNumber * guid;
@property (nonatomic, retain) NSNumber * profileGuid;
@property (nonatomic, retain) NSDate * endedDate;
@property (nonatomic, retain) NSString * frequency;
@property (nonatomic, retain) NSString * dose;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * strength;
@property (nonatomic, retain) NSDate * startedDate;
@property (nonatomic, retain) NSString * route;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Profile * profile;

@end



