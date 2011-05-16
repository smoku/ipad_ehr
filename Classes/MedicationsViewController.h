//
//  MedicationsViewController.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProfilesViewController;
@class Profile;
@class Medication;
@class MedicationTableCell;


@interface MedicationsViewController : UITableViewController<UIPopoverControllerDelegate, UISplitViewControllerDelegate, RKObjectLoaderDelegate> {
	UIPopoverController *popoverController;
	
	ProfilesViewController *profilesViewController;
	
	Profile *profile;
	NSArray *medications;
	
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) UIPopoverController *popoverController;

@property (nonatomic, assign) IBOutlet ProfilesViewController *profilesViewController;

@property (nonatomic, retain) Profile *profile;
@property (nonatomic, retain) NSArray *medications;



- (void)updateViewFor:(Profile *)newProfile;

- (void)loadMedications;

- (IBAction)newMedication;

- (void)startActivityIndicator;

- (void)stopActivityIndicator;

@end
