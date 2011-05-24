//
//  MedicationFormDataSource.m
//
//  Created by Paweł Smoczyk on 11-05-10.
//  Copyright 2011 AppUnite.com. All rights reserved.
//

#import "MedicationFormDataSource.h"


@implementation MedicationFormDataSource

- (id)initWithModel:aModel
{   
	if ((self = [super initWithModel:aModel])) {
        
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setDateFormat:@"d MMM yyyy"];
        
        NSArray *routesList = [NSArray arrayWithObjects:@"By mouth", 
                                                        @"Injection", 
                                                        @"Inhaled", 
                                                        @"To eyes", 
                                                        @"To skin", 
                                                        @"To nose", 
                                                        nil];
        
        NSArray *dosesList = [NSArray arrayWithObjects:@"1/4", 
                                                       @"1/2", 
                                                       @"1", 
                                                       @"2", 
                                                       @"3", 
                                                       @"4",
                                                       @"5",
                                                       nil];
        
        NSArray *frequenciesList = [NSArray arrayWithObjects:@"1 time per day", 
                                                             @"1 time per day in the morning",
                                                             @"1 time per day in the evening",
                                                             @"2 times per day",
                                                             @"3 times per day", 
                                                             @"4 times per day", 
                                                             @"every hour", 
                                                             nil];
        
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"" footerTitle:nil];
        
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"name" title:@"Name"] autorelease]];
        
        [basicFieldSection addFormField:[[[IBADateFormField alloc] initWithKeyPath:@"startedDate"
                                                                             title:@"Started date"
                                                                      defaultValue:[NSDate date]
                                                                              type:IBADateFormFieldTypeDate
                                                                     dateFormatter:dateFormatter] autorelease]];

        
		[basicFieldSection addFormField:[[[IBADateFormField alloc] initWithKeyPath:@"endedDate"
                                                                             title:@"Ended date"
                                                                      defaultValue:[NSDate date]
                                                                              type:IBADateFormFieldTypeDate
                                                                     dateFormatter:dateFormatter] autorelease]];
        
        
		[basicFieldSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"route"
                                                                                 title:@"Route"
                                                                      valueTransformer:nil
                                                                         selectionMode:IBAPickListSelectionModeSingle
                                                                               options:[IBAPickListFormOption pickListOptionsForStrings:routesList]] autorelease]];
        
        [basicFieldSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"dose"
                                                                                 title:@"How many?"
                                                                      valueTransformer:nil
                                                                         selectionMode:IBAPickListSelectionModeSingle
                                                                               options:[IBAPickListFormOption pickListOptionsForStrings:dosesList]] autorelease]];
        
        [basicFieldSection addFormField:[[[IBAPickListFormField alloc] initWithKeyPath:@"frequency"
                                                                                 title:@"How often?"
                                                                      valueTransformer:nil
                                                                         selectionMode:IBAPickListSelectionModeSingle
                                                                               options:[IBAPickListFormOption pickListOptionsForStrings:frequenciesList]] autorelease]];
        
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"strength" title:@"Strength"] autorelease]];
        
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"note" title:@"Note"] autorelease]];
    }
	
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

@end