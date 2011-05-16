//
//  EHRAppDelegate.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ProfilesViewController;
@class DetailViewController;

@interface EHRAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;

	UISplitViewController *splitViewController;

	ProfilesViewController *profilesViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet ProfilesViewController *profilesViewController;

@end