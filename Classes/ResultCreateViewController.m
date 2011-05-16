//
//  ResultCreateViewController.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-05-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultCreateViewController.h"
#import "ResultsViewController.h"
#import "Profile.h"
#import "Result.h"


@implementation ResultCreateViewController

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
    
    ResultsViewController *parentController = (ResultsViewController*)[self parentViewController];
    
    [parentController loadResults];
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
    
    Result *result = [Result object];
    result.name = [attributes objectForKey:@"name"];
    result.result = [attributes objectForKey:@"result"];
    result.units = [attributes objectForKey:@"units"];
    result.date = [attributes objectForKey:@"date"];
    result.note = [attributes objectForKey:@"note"];
    result.profileGuid = self.profile.guid;
    
    [self startActivityIndicator];
    
    [[RKObjectManager sharedManager] postObject:result delegate:self];
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
