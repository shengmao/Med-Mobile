//
//  coredataMasterViewController.m
//  Medical2Mobile
//
//  Created by LISComputer on 03.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "coredataMasterViewController.h"
#import "tyxAppDelegate.h"
#import "Patient.h"
#import "tyxDetailViewController.h"
#import "PossibleStationaryType.h"
#import <QuartzCore/QuartzCore.h>

@interface coredataMasterViewController ()
@property (strong, nonatomic)  NSUserDefaults *userDefaults;
@end

@implementation coredataMasterViewController
@synthesize managedObjectContext = __managedObjectContext;
@synthesize fetchedObjects = __fetchedObjects;
@synthesize detailViewController=_detailViewController;
@synthesize fetchedResultsController =_fetchedResultsController;
@synthesize userDefaults =_userDefaults;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSFetchedResultsController *)fetchedResultsController {
    //Get managedObjectContext from App delegate.
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(tyxAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    if (_fetchedResultsController != nil) {
        NSLog(@"the fetched resultscontroller method is executed now2");

        return _fetchedResultsController;
    }
    
    /*
	 Set up the fetched results controller.
     */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patient" inManagedObjectContext:__managedObjectContext];
	[fetchRequest setEntity:entity];

    // Sort using the timeStamp property..
	NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"possiblestationarytype" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"lname" ascending:YES];
    NSSortDescriptor *sortDescriptor3 = [[NSSortDescriptor alloc] initWithKey:@"fname" ascending:YES];

	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: sortDescriptor1, sortDescriptor2, sortDescriptor3, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
		
    // Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
    
//    // Use predicate
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateend = %@", nil];
//    [fetchRequest setPredicate:predicate];
    
    // Use the sectionNameKeyPath property to group into sections.
//    NSError *error;
//    NSArray *fetchedobjects =[self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
	NSFetchedResultsController *FetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:__managedObjectContext sectionNameKeyPath:@"possiblestationarytype" cacheName:nil];
    FetchedResultsController.delegate = self;
	self.fetchedResultsController = FetchedResultsController;
	NSLog(@"the fetched resultscontroller method is executed now1: %@", [_fetchedResultsController objectAtIndexPath:0]);
	return _fetchedResultsController;
}

- (void)viewDidLoad
{  
    [super viewDidLoad];
    
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    
    //Get managedObjectContext from App delegate.
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(tyxAppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext]; 
        //NSLog(@"After managedObjectContext: %@",  self.managedObjectContext);
    }
        
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}



//serialize the data in database otherwise only saved in memory.
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


//searchbar delegate method
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    if ([searchText length] == 0) {
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"1=1"];
        [_fetchedResultsController.fetchRequest setPredicate:predicate];
    }else {
       //search results like: "fanme lastnmae"(eg: "Shengmao Li")
       if ([searchText rangeOfString:@" "].location != NSNotFound) {
           NSRange range = [searchText rangeOfString:@" "];
           NSString *substr1 = [searchText substringToIndex:range.location];
           NSString *substr2 = [searchText substringFromIndex:range.location + range.length];
           NSInteger len_substr2 = [substr2 length];
           //NSLog(@"firstsubstring:%@  secondsubstring:%@ length of string is:%d", substr1, substr2, len_substr2);
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(fname CONTAINS[cd] %@) AND ((lname CONTAINS[cd] %@) OR (%d == 0))", substr1, substr2, len_substr2];
        [_fetchedResultsController.fetchRequest setPredicate:predicate];
       }
     //process searchtext with only lastname or firstname
       else {
           NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(fname CONTAINS[cd] %@) OR (lname CONTAINS[cd] %@)", searchText, searchText ];
           [_fetchedResultsController.fetchRequest setPredicate:predicate];
       }
    }
    //NSLog(@"endofmethod: %@", searchText);
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}      
    
    [self.tableView reloadData];
}
//dismiss keyboard
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}


//preselect a row.
-(void)viewWillAppear:(BOOL)animated

{
    
    //preselect a row in section     
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0
                                       inSection:0];
    [(UITableView*)self.view selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    
    //pass detailItem data of preselected row to detail view.
    Patient *patient = [self.fetchedResultsController objectAtIndexPath:ip];
    NSLog(@"nihao1%@",patient);
    self.detailViewController = (tyxDetailViewController *)[self.splitViewController.viewControllers lastObject];    
    self.detailViewController.detailItem = patient;
    
    
}

/*
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    //prescroll a row in section     
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0
                                       inSection:0];
    [(UITableView *)self.view scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
   
//    //remember last row selection
//    _userDefaults = [NSUserDefaults standardUserDefaults];
//    if (!([_userDefaults valueForKey:@"content_row"] == nil || [_userDefaults valueForKey:@"content_section"] == nil ))
//    {
//        int rowint = [[_userDefaults valueForKey:@"content_row"] intValue];
//        int secint = [[_userDefaults valueForKey:@"content_section"] integerValue];
//        NSIndexPath *selectedIndexpath = [NSIndexPath indexPathForRow:rowint inSection:secint];
//        [self.tableView scrollToRowAtIndexPath: selectedIndexpath atScrollPosition:UITableViewScrollPositionTop  animated:YES];    
//    }
    
}
 
-(void) viewWillDisappear:(BOOL)animated
{
//    NSLog(@"---> %s",__PRETTY_FUNCTION__);
//    NSIndexPath *selectedIndexpath = [[self.tableView indexPathsForVisibleRows] objectAtIndex:0];
//    [_userDefaults setInteger: selectedIndexpath.row forKey:@"content_row"];
//    [_userDefaults setInteger: selectedIndexpath.section forKey:@"content_section"];
//    NSLog(@"Indexpath is:%@ good %@", [_userDefaults valueForKey:@"content_row"], [_userDefaults valueForKey:@"content_section"]);
}
*/
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    _fetchedResultsController = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
if(interfaceOrientation == UIInterfaceOrientationPortrait){
    return NO;
}
if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
    return YES;
}
else 
{
    return NO;
} 
}

#pragma mark - Table view data source

#pragma mark TableView Section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);

    NSLog(@"%i",[[_fetchedResultsController sections] count]);
    NSInteger count = [[_fetchedResultsController sections] count];
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);

    id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    NSLog(@"%i",[sectionInfo numberOfObjects]);
    NSInteger count = [sectionInfo numberOfObjects];
    return  count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

  id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    NSArray * sectionobjectarray = [sectionInfo objects];
    return  [[[sectionobjectarray objectAtIndex:0] possiblestationarytype] name]; 

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    static NSString *CellIdentifier = @"PatientCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Patient *patient = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString  *patientname = [[NSString alloc] init];
    patientname = [patientname stringByAppendingString:[patient fname]];
    patientname = [patientname stringByAppendingString:@" "];
    patientname = [patientname stringByAppendingString:[patient lname]];
    
    UILabel *patientNameTextfield = (UILabel *)[cell viewWithTag:100];
    patientNameTextfield.text = patientname;

    UIImageView *patientpicture = (UIImageView *) [cell viewWithTag:102];
    if([patient picture] != nil){
        patientpicture.image =[UIImage imageWithData:[patient picture]];
    }
    else
    {
        patientpicture.image =[UIImage imageNamed:@"patientpicture1.jpg"];
    }
    
    NSString *patientStationaryInformation = @"Station ";
    patientStationaryInformation = [patientStationaryInformation stringByAppendingString: [patient station]];
    patientStationaryInformation = [patientStationaryInformation stringByAppendingFormat:@" - Raum "];
    patientStationaryInformation = [patientStationaryInformation stringByAppendingFormat:[patient room]];
    
    UILabel *patientStationaryTextfield = (UILabel *) [cell viewWithTag:101];patientStationaryTextfield.text = patientStationaryInformation;
    return cell;
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //This is getting the data from my CoreData fetch
    Patient *patient = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    //I am able to now get the data for my specific key called complete
    //NSLog(@"Data: %@",[patient valueForKey:@"lname"]);
    // I can use [patient setValue:[NSNumber numberWithBool:NO] forKey:@"complete"];
    // to set the value to false.
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.detailViewController = (tyxDetailViewController *)[self.splitViewController.viewControllers lastObject];
    //Patient *object = [self.fetchedObjects objectAtIndex:indexPath.row];
    
    self.detailViewController.detailItem = patient;
    [self.detailViewController.tableView reloadData];
    NSLog(@"nihao%@",patient);
}
@end
