//
//  ResultsViewController.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultsViewController.h"
#import "Profile.h"
#import "Result.h"
#import "ResultTableCell.h"

#import "ResultCreateViewController.h"
#import "ResultFormDataSource.h"


@implementation ResultsViewController

@synthesize popoverController;
@synthesize profile, results;

#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    barButtonItem.title = @"Profiles";
	self.navigationItem.leftBarButtonItem = barButtonItem;
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
	self.navigationItem.leftBarButtonItem = nil;
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
}

#pragma mark -
#pragma mark IB Actions

- (IBAction)newResult {
    if (self.profile != nil) {
        ResultFormDataSource *resultFormDataSource = [[[ResultFormDataSource alloc] initWithModel:[NSMutableDictionary dictionary]] retain];
    
        ResultCreateViewController *resultCreateViewController = [[[ResultCreateViewController alloc] initWithNibName:@"ResultCreateView" bundle:nil formDataSource:resultFormDataSource] retain];
        resultCreateViewController.profile = self.profile;
    
        [resultCreateViewController setModalPresentationStyle:UIModalPresentationFormSheet];
        [resultCreateViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentModalViewController:resultCreateViewController animated:YES];
    
        [resultFormDataSource release];
        [resultCreateViewController release];
    }
}


#pragma mark -
#pragma mark Configure view

- (void)updateViewFor:(Profile *)newProfile {
	self.profile = newProfile;
	
    [self loadResults];
	[self.tableView reloadData];
    
    // Dismiss popover
	if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    } 
}

- (void)loadResults {	
    NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"guid" ascending:NO];
    
	self.results = [self.profile.results sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.results count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ResultCell";
    
    ResultTableCell *cell = (ResultTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ResultTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Result *result = [self.results objectAtIndex:indexPath.row];
    
    cell.result.text = [NSString stringWithFormat:@"%@ %@", result.result, result.units];
    cell.name.badgeString = result.name;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"dd mm yyyy"];
    
    cell.date.text = [dateFormatter stringFromDate:result.date];
    
    [dateFormatter release];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self startActivityIndicator];
        
        Result *result = [self.results objectAtIndex:indexPath.row];
        
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        
        [objectManager deleteObject:result delegate:self];
        
        [[[objectManager objectStore] managedObjectContext] deleteObject:result];
        [[objectManager objectStore] save];
    }
}

#pragma mark -
#pragma mark Object loader delegate

- (void) objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    [self loadResults];
    [self.tableView reloadData];
    
    [self stopActivityIndicator];
}

- (void) objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    [self stopActivityIndicator];
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



#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[popoverController release];
	[profile release];
	[results release];
	
    [super dealloc];
}


@end

