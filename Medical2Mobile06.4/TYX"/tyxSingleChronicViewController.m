//
//  tyxSingleChronicViewController.m
//  Medical2Mobile
//
//  Created by LISComputer on 29.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tyxSingleChronicViewController.h"
#import "tyxAppDelegate.h"
#import "Activity.h"
#import <QuartzCore/QuartzCore.h>
#import "PossibleClinicalIssue.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface tyxSingleChronicViewController ()

@end

@implementation tyxSingleChronicViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchedResultsController =_fetchedResultsController;
@synthesize detailItem =_detailItem;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupFetchedResultsController
{
    // 0 - Ensure you have a MOC
    if (!self.managedObjectContext) {
        tyxAppDelegate *ad = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = ad.managedObjectContext;
    }
    
	// 1 - Decide what Entity you want
	NSString *entityName = @"Activity"; // Put your entity name here
    
	// 2 - Request that Entity
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
	// 3 - Filter it if you want
	request.predicate = [NSPredicate predicateWithFormat:@"patient ==%@ ", _detailItem];
	
    // 4 - Sort it if you want
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"sectiondate" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: sortDescriptor1, sortDescriptor2, nil];
    [request setSortDescriptors: sortDescriptors];
    
	// 5 - Fetch it
	self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
																		managedObjectContext:self.managedObjectContext
																		  sectionNameKeyPath:@"sectiondate"
																				   cacheName:nil];
	[self.fetchedResultsController performFetch:nil];
    
    NSLog(@"the fetch request has been performed for entity Activity.");
    for (Activity *activity in [self.fetchedResultsController fetchedObjects]) {
        NSLog(@"Activity: %@", activity.longdescription);   
    }
    
    
}

- (void)viewDidLoad
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    NSLog(@"the patient is: %@", _detailItem);
    [self setupFetchedResultsController];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.

    NSInteger count = [[_fetchedResultsController sections] count];
    count = MAX(count, 1);
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    NSInteger count;
    // Return the number of rows in the section.
    if ([_fetchedResultsController fetchedObjects] == nil || [[_fetchedResultsController fetchedObjects] count] == 0) 
    {
        count = 1;
    }
    else {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    count = [sectionInfo numberOfObjects];
    }
    return  count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
   // NSLog(@"%i",[[_fetchedResultsController fetchedObjects] count]);
    if ([_fetchedResultsController fetchedObjects] == nil || [[_fetchedResultsController fetchedObjects] count] == 0) 
    {
        return @"Chronik";
    }
    else {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
        NSArray * sectionobjectarray = [sectionInfo objects];
        return  [[sectionobjectarray objectAtIndex:0] sectiondate] ;
        NSLog(@"the header name of section 1 is:%@", [[sectionobjectarray objectAtIndex:0] sectiondate]);
    }
}

#pragma mark TableView Rows
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    if ([_fetchedResultsController fetchedObjects] == nil || [[_fetchedResultsController fetchedObjects] count] == 0) 
    {
        return 44;;
    }
    else {
            Activity *activity = [_fetchedResultsController objectAtIndexPath:indexPath];
    // Get the text so we can measure it
    NSString *text = activity.longdescription;
    // Get a CGSize for the width and, effectively, unlimited height
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    // Get the size of the text given the CGSize we just made as a constraint
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeTailTruncation];
    // Get the height of our measurement, with a minimum of 44 (standard cell size)
    CGFloat height = MAX((size.height+10.0f), 44.0f);
    // return the height, with a bit of extra padding in
    return height + (CELL_CONTENT_MARGIN * 3);
        NSLog(@"height for row at index path method is called");
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChronikCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *shortdes = (UILabel *)[cell viewWithTag:100];
    UILabel *time = (UILabel *)[cell viewWithTag:101];
    UILabel *longdes = (UILabel *)[cell viewWithTag:102];
    UIImageView *patientpicview =(UIImageView *)[cell viewWithTag:103];
    
    // Configure the cell...
    if ([_fetchedResultsController fetchedObjects] == nil || [[_fetchedResultsController fetchedObjects] count] == 0) 
    {
        shortdes.text = @"keine Einträge vorhanden";
        longdes.text = nil;
        time.text = nil;
        patientpicview.image = nil;
    }
    else {
            Activity *activity = [_fetchedResultsController objectAtIndexPath:indexPath];
    shortdes.text = [activity.possibleclinicalissue shortdescription];
    longdes.text = activity.longdescription;
    
    //extremely important, solve problems cause by sizetofit method when scrolling.
         [longdes layoutIfNeeded];
    longdes.autoresizingMask = UIViewAutoresizingFlexibleHeight;
   
      
    
        
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyy HH:mm:ss"];
    NSString *stringFromDate = [formatter stringFromDate:activity.timestamp];
    time.text = stringFromDate;
    time.textAlignment = UITextAlignmentRight;
    
    //modify pictures layout
    UIImage *pic = [[UIImage alloc] initWithData:[activity.possibleclinicalissue picture]];
    patientpicview.image = pic;
    
    }
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
