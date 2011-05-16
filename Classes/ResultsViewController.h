//
//  ResultsViewController.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Profile;
@class Result;


@interface ResultsViewController : UITableViewController<UIPopoverControllerDelegate, UISplitViewControllerDelegate, RKObjectLoaderDelegate> {
	UIPopoverController *popoverController;
	
	Profile *profile;
	NSArray *results;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) UIPopoverController *popoverController;

@property (nonatomic, retain) Profile *profile;
@property (nonatomic, retain) NSArray *results;


- (void)updateViewFor:(Profile *)newProfile;

- (void)loadResults;

- (IBAction)newResult;

- (void)startActivityIndicator;

- (void)stopActivityIndicator;

@end
