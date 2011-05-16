//
//  SettingsEditViewController.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-05-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsEditViewController.h"


@implementation SettingsEditViewController

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - UI actions

- (IBAction) save {   
    // Resign active responder
    [[IBAInputManager sharedIBAInputManager] deactivateActiveInputRequestor];
    
    NSDictionary *credentials = self.formDataSource.model;
    
    // change client credentials
    RKClient* client = [RKClient sharedClient];
    client.username = [credentials objectForKey:@"email"];
    client.password = [credentials objectForKey:@"password"];
    
    // save credentials
    [[NSUserDefaults standardUserDefaults] setObject:[credentials objectForKey:@"email"] forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setObject:[credentials objectForKey:@"password"] forKey:@"password"];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction) cancel {
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

@end
