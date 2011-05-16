//
//  Result.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class Profile;

@interface Result :  RKManagedObject  
{
}

@property (nonatomic, retain) NSNumber * guid;
@property (nonatomic, retain) NSNumber * profileGuid;
@property (nonatomic, retain) NSString * result;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * units;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) Profile * profile;

@end



