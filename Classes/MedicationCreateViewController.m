//
//  MedicationCreateViewController.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-05-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedicationCreateViewController.h"
#import "MedicationsViewController.h"
#import "Profile.h"
#import "Medication.h"


@implementation MedicationCreateViewController

@synthesize profile=_profile;

- (void)dealloc
{
    [_profile release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


#pragma mark Object loader delegate

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    [self stopActivityIndicator];
    
    MedicationsViewController *parentController = (MedicationsViewController*)[self parentViewController];
    
    [parentController loadMedications];
    [parentController.tableView reloadData];
    
    [parentController dismissModalViewControllerAnimated:YES];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    [self stopActivityIndicator];
    
    // Dziwnie jest przechowywany error w RestKicie
    [self showAlertWithTitle:@"Record invalid" andMessage:[[error userInfo] objectForKey:@"NSLocalizedDescription"]];
}

#pragma mark - UI actions

- (IBAction) save {   
    // Resign active responder
    [[IBAInputManager sharedIBAInputManager] deactivateActiveInputRequestor];
    
    NSDictionary *attributes = self.formDataSource.model;
    
    Medication *medication = [Medication object];
    medication.name = [attributes objectForKey:@"name"];
    medication.startedDate = [attributes objectForKey:@"startedDate"];
    medication.endedDate = [attributes objectForKey:@"endedDate"];
    medication.strength = [attributes objectForKey:@"strength"];
    medication.route = [[[[attributes objectForKey:@"route"] allObjects] objectAtIndex:0] name];
    medication.dose = [[[[attributes objectForKey:@"dose"] allObjects] objectAtIndex:0] name];
    medication.frequency = [[[[attributes objectForKey:@"frequency"] allObjects] objectAtIndex:0] name];
    medication.note = [attributes objectForKey:@"note"];
    medication.profileGuid = self.profile.guid;
    
    [self startActivityIndicator];
    
    [[RKObjectManager sharedManager] postObject:medication delegate:self];
}

- (IBAction) cancel {
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark - Alert

- (void) showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark -
#pragma mark Activity indicator

- (void) startActivityIndicator {
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.center = self.view.center;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[activityIndicator startAnimating];
	[self.view addSubview: activityIndicator];
}

- (void) stopActivityIndicator {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	[activityIndicator release];
}


@end
