//
//  RootViewController.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfilesViewController.h"
#import "MedicationsViewController.h"
#import "ResultsViewController.h"
#import "Profile.h"

#import "SettingsEditViewController.h"
#import "SettingsFormDataSource.h"


@implementation ProfilesViewController

@synthesize medicationsViewController, resultsViewController;
@synthesize profiles;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	
	
	// Load profiles from core data
	[self loadProfiles];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.    
    return YES;
}

#pragma mark -
#pragma mark IB Actions

- (IBAction)reload {
    [self startActivityIndicator];
	
	RKObjectManager* objectManager = [RKObjectManager sharedManager];
    [objectManager loadObjectsAtResourcePath:@"/profiles" delegate:self];
}

- (IBAction)settings {
    NSMutableDictionary *credentials = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        [[NSUserDefaults standardUserDefaults] objectForKey:@"email"], @"email", 
                                        [[NSUserDefaults standardUserDefaults] objectForKey:@"password"], @"password",                                         
                                        nil];
    
    SettingsFormDataSource *settingsFormDataSource = [[[SettingsFormDataSource alloc] initWithModel:credentials] retain];
    
    SettingsEditViewController *settingsEditViewController = [[[SettingsEditViewController alloc] initWithNibName:@"SettingsEditView" bundle:nil formDataSource:settingsFormDataSource] retain];
    
    [settingsEditViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [settingsEditViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:settingsEditViewController animated:YES];
    
    [settingsFormDataSource release];
    [settingsEditViewController release];
}

#pragma mark -
#pragma mark Loading profiles

- (void)loadProfiles {	
	NSFetchRequest* request = [Profile fetchRequest];
	NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	self.profiles = [Profile objectsWithFetchRequest:request];
}


#pragma mark Object loader delegate

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    [self stopActivityIndicator];
    
	[self loadProfiles];
	[self.tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    [self stopActivityIndicator];
	
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.profiles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
	Profile *profile = [self.profiles objectAtIndex:indexPath.row];
    
    cell.textLabel.text = profile.name;
    
    NSString *gender;
    
    if ([profile.gender intValue] == 0) {
        gender = @"male";
    } else {
        gender = @"female";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"dd.mm.yyyy"];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", gender, [dateFormatter stringFromDate:profile.birthDate]];
    
    [dateFormatter release];
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	Profile *selectedProfile = [self.profiles objectAtIndex:indexPath.row];
    
    [self.medicationsViewController updateViewFor:selectedProfile];
    [self.resultsViewController updateViewFor:selectedProfile];
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

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [medicationsViewController release];
	[activityIndicator release];
    
    [super dealloc];
}

@end
