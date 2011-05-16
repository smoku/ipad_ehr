//
//  EHRAppDelegate.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EHRAppDelegate.h"
#import "ProfilesViewController.h"

#import <RestKit/ObjectMapping/RKDynamicRouter.h>
#import <RestKit/ObjectMapping/RKRailsRouter.h>

#import "Profile.h"
#import "Medication.h"
#import "Result.h"


@implementation EHRAppDelegate

@synthesize window, splitViewController, profilesViewController;


#pragma mark -
#pragma mark Application lifecycle

- (void)awakeFromNib {
    // Pass the managed object context to the root view controller.
    // rootViewController.managedObjectContext = self.managedObjectContext; 
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	// Initialize RestKit
	RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://webehr.heroku.com/api"];
    [objectManager.client setValue:@"application/json" forHTTPHeaderField:@"Accept"]; 
    
    objectManager.client.username = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    objectManager.client.password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
	RKObjectMapper* mapper = objectManager.mapper;
    
    // Update date format so that we can parse twitter dates properly
	// Wed Sep 29 15:31:08 +0000 2010
	NSMutableArray* dateFormats = [[[mapper dateFormats] mutableCopy] autorelease];
	[dateFormats addObject:@"yyyy-mm-dd"];
	[mapper setDateFormats:dateFormats];

	// Add our element to object mappings
	[mapper registerClass:[Profile class] forElementNamed:@"profile"];
	[mapper registerClass:[Result class] forElementNamed:@"results"];
	[mapper registerClass:[Medication class] forElementNamed:@"medications"];	
    
   	[mapper registerClass:[Result class] forElementNamed:@"result"];
  	[mapper registerClass:[Medication class] forElementNamed:@"medication"];	
    
    
    // Router
    RKRailsRouter* router = [[[RKRailsRouter alloc] init] autorelease];

    [router setModelName:@"result" forClass:[Result class]];
	[router routeClass:[Result class] toResourcePath:@"/profiles/(profileGuid)/results" forMethod:RKRequestMethodPOST];
    [router routeClass:[Result class] toResourcePath:@"/profiles/(profileGuid)/results/(guid)" forMethod:RKRequestMethodDELETE];
    
	[router setModelName:@"medication" forClass:[Medication class]];
	[router routeClass:[Medication class] toResourcePath:@"/profiles/(profileGuid)/medications" forMethod:RKRequestMethodPOST];
    [router routeClass:[Medication class] toResourcePath:@"/profiles/(profileGuid)/medications/(guid)" forMethod:RKRequestMethodDELETE];
    
	objectManager.router = router;
    
    // Initialize object store
    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"EHRData.sqlite"];
	
    
	// Set the split view controller as the window's root view controller and display.
	[self.window addSubview:self.splitViewController.view];
    //self.window.rootViewController = self.splitViewController;
    [self.window makeKeyAndVisible];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
//    NSError *error = nil;
//	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
//    if (managedObjectContext != nil) {
//        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
//            /*
//             Replace this implementation with code to handle the error appropriately.
//             
//             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
//             */
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        } 
//    }
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
	[splitViewController release];
	[profilesViewController release];

	[window release];
	[super dealloc];
}


@end

