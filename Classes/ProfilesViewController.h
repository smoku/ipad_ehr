//
//  RootViewController.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MedicationsViewController;
@class ResultsViewController;

@interface ProfilesViewController : UITableViewController <RKObjectLoaderDelegate> {
    
    MedicationsViewController *medicationsViewController;
    ResultsViewController *resultsViewController;
	
	NSArray *profiles;
	
	UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet MedicationsViewController *medicationsViewController;
@property (nonatomic, retain) IBOutlet ResultsViewController *resultsViewController;
@property (nonatomic, retain) NSArray *profiles;

- (IBAction)reload;

- (IBAction)settings;

- (void)loadProfiles;

- (void)startActivityIndicator;

- (void)stopActivityIndicator;

@end
