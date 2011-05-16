//
//  MedicationsViewController.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedicationsViewController.h"
#import "ProfilesViewController.h"
#import "Profile.h"
#import "Medication.h"
#import "MedicationTableCell.h"

#import "MedicationCreateViewController.h"
#import "MedicationFormDataSource.h"


@implementation MedicationsViewController


@synthesize popoverController;
@synthesize profilesViewController;
@synthesize profile, medications;


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

- (IBAction)newMedication {
    if (self.profile != nil) {
        MedicationFormDataSource *medicationFormDataSource = [[[MedicationFormDataSource alloc] initWithModel:[NSMutableDictionary dictionary]] retain];
    
        MedicationCreateViewController *medicationCreateViewController = [[[MedicationCreateViewController alloc] initWithNibName:@"MedicationCreateView" bundle:nil formDataSource:medicationFormDataSource] retain];
        medicationCreateViewController.profile = self.profile;
    
        [medicationCreateViewController setModalPresentationStyle:UIModalPresentationFormSheet];
        [medicationCreateViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentModalViewController:medicationCreateViewController animated:YES];
    
        [medicationFormDataSource release];
        [medicationCreateViewController release];
    }
}

#pragma mark -
#pragma mark Configure view

- (void)updateViewFor:(Profile *)newProfile {
	self.profile = newProfile;
    
	[self loadMedications];
	[self.tableView reloadData];
	
	// Dismiss popover
	if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    } 
}
	 
- (void)loadMedications {	
    NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"guid" ascending:NO];
    
	self.medications = [self.profile.medications sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [self.medications count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MedicationCell";
    
    MedicationTableCell *cell = (MedicationTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MedicationTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Medication *medication = [self.medications objectAtIndex:indexPath.row];
    
    cell.name.text = medication.name;
    cell.strength.badgeString = medication.strength;
    cell.frequency.badgeString = [NSString stringWithFormat:@"%@ - %@", medication.dose, medication.frequency];
    cell.route.badgeString = medication.route;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"dd mm yyyy"];
    
    cell.date.text = [NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:medication.startedDate], [dateFormatter stringFromDate:medication.endedDate]];
    
    [dateFormatter release];
	
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self startActivityIndicator];
        
        Medication *medication = [self.medications objectAtIndex:indexPath.row];
        
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        
        [objectManager deleteObject:medication delegate:self];
        
        [[[objectManager objectStore] managedObjectContext] deleteObject:medication];
        [[objectManager objectStore] save];
    }
}

#pragma mark -
#pragma mark Object loader delegate

- (void) objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    [self loadMedications];
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
	[profilesViewController release];
	[profile release];
	[medications release];
	
    [super dealloc];
}


@end

