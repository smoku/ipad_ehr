//
//  ResultCreateViewController.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-05-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Profile;

@interface ResultCreateViewController : IBAFormViewController<RKObjectLoaderDelegate> {
    Profile *_profile;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) Profile *profile;

- (IBAction) save;

- (IBAction) cancel;

- (void) showAlertWithTitle:(NSString*)title andMessage:(NSString*)message;

- (void) startActivityIndicator;

- (void) stopActivityIndicator;

@end
