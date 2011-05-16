//
//  ResultFormDataSource.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-05-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultFormDataSource.h"


@implementation ResultFormDataSource

- (id)initWithModel:aModel
{   
	if ((self = [super initWithModel:aModel])) {
        
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setDateFormat:@"d MMM yyyy"];
        
        
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"" footerTitle:nil];
        
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"name" title:@"Name"] autorelease]];
        
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"result" title:@"Result"] autorelease]];
        
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"units" title:@"Units"] autorelease]];
        
        [basicFieldSection addFormField:[[[IBADateFormField alloc] initWithKeyPath:@"date"
                                                                             title:@"Date"
                                                                      defaultValue:[NSDate date]
                                                                              type:IBADateFormFieldTypeDate
                                                                     dateFormatter:dateFormatter] autorelease]];
        
        [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"note" title:@"Note"] autorelease]];
    }
	
    return self;
}

- (void) dealloc
{
    [super dealloc];
}


@end
