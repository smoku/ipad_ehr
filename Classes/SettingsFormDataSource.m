//
//  SettingsFormDataSource.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-05-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsFormDataSource.h"


@implementation SettingsFormDataSource

- (id)initWithModel:aModel
{   
	if ((self = [super initWithModel:aModel])) {
        
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"" footerTitle:nil];
        
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"email" title:@"Email"] autorelease]];
        
        [basicFieldSection addFormField:[[[IBAPasswordFormField alloc] initWithKeyPath:@"password" title:@"Password"] autorelease]];
        
    }
	
    return self;
}

- (void) dealloc
{
    [super dealloc];
}


@end
