//
//  Profile.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class Medication;
@class Result;

@interface Profile :  RKManagedObject  
{
}

@property (nonatomic, retain) NSNumber *gender;
@property (nonatomic, retain) NSString *bloodType;
@property (nonatomic, retain) NSDate *birthDate;
@property (nonatomic, retain) NSNumber *guid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *results;
@property (nonatomic, retain) NSSet *medications;

@end


//@interface Profile (CoreDataGeneratedAccessors)
//- (void)addResultsObject:(Result *)value;
//- (void)removeResultsObject:(Result *)value;
//- (void)addResults:(NSSet *)value;
//- (void)removeResults:(NSSet *)value;
//
//- (void)addMedicationsObject:(Medication *)value;
//- (void)removeMedicationsObject:(Medication *)value;
//- (void)addMedications:(NSSet *)value;
//- (void)removeMedications:(NSSet *)value;
//
//@end

