//
//  tyxSingleDiagnostikTableViewController.m
//  Medical2Mobile
//
//  Created by Sandra Möller on 20.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxSingleDiagnostikTableViewController.h"
#import "tyxAddDiagnostikPickerViewController.h"
#import "Activity.h"
#import "QuartzCore/QuartzCore.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface tyxSingleDiagnostikTableViewController ()
@property (strong, nonatomic) UIPopoverController *popover;
@property (strong, nonatomic) NSArray *itemList;
@end

@implementation tyxSingleDiagnostikTableViewController
@synthesize detailItem = _detailItem;
@synthesize popover = _popover;
@synthesize patienttherapy = _patienttherapy;
@synthesize patientanamnese = _patientanamnese;
@synthesize patientdiagnose =_patientdiagnose;
@synthesize patientresult = _patientresult;
@synthesize itemList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setSections
{
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    itemList = [[self.detailItem activity] sortedArrayUsingDescriptors:sortDescriptors];
    
    //all anamnese
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"possibleclinicalissue.shortdescription = \"Anamnese\""];
    _patientanamnese = [itemList filteredArrayUsingPredicate:predicate];
    
    //all results
    predicate = [NSPredicate predicateWithFormat:@"possibleclinicalissue.shortdescription LIKE \"*Befund\""];
    _patientresult = [itemList filteredArrayUsingPredicate:predicate];
    
    //all diagnosis
    predicate = [NSPredicate predicateWithFormat:@"possibleclinicalissue.shortdescription = \"Diagnose\""];
    _patientdiagnose = [itemList filteredArrayUsingPredicate:predicate];
    
    //all therapy
    predicate = [NSPredicate predicateWithFormat:@"possibleclinicalissue.shortdescription = \"Therapie\""];
    _patienttherapy = [itemList filteredArrayUsingPredicate:predicate];

}
- (void)viewDidLoad
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    NSLog(@"%@",_detailItem);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self setSections];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //fill table with documents from this patient
    
    
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    // Return the number of rows in the section.
    
    switch (section) {
        case 0:
            if ([_patientanamnese count] ==0) {
                return 1;
            }
            else {
                return [_patientanamnese count];
            }
            break;
        case 1:
            if ([_patientresult count] ==0) {
                return 1;
            }
            else {
                return [_patientresult count];
            }
            break;
            
        case 2:
            if ([_patientdiagnose count] ==0) {
                return 1;
            }
            else {
                return [_patientdiagnose count];
            }
            break;
        case 3:
            if ([_patienttherapy count]==0) {
                return 1;
            }
            else {
                return [_patienttherapy count];
            }
            break;
        default:
            return 1;
            break;
    }
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    //returns predefined SectionHeader
    switch (section) {
        case 0:
            return @"Anamesen";
            break;
        case 1:
            return @"Befunde";
        case 2:
            return @"Diagnosen";
            break;
        case 3:
            return @"Therapien";
            break;
        default:
            return @"unbekannt";
            break;
    }
}

#pragma mark TableView Rows
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *text = [[NSString alloc] init];
    
    // Get the text so we can measure it
    switch (indexPath.section) {
        case 0:
            if (_patientanamnese == nil || [_patientanamnese count] == 0) {
                text = @"";
            }
            else {
                text = [[_patientanamnese objectAtIndex:indexPath.row] longdescription];
            }
            break;
        case 1:
            if ([_patientresult count] == 0 || _patientresult == nil) {
                text = @"";
            }
            else {
                text = [[_patientresult objectAtIndex:indexPath.row] longdescription];
            }
            break;
        case 2:
            if ([_patientdiagnose count] == 0 || _patientdiagnose == nil) {
                text = @"";
            }
            else {
                text = [[_patientdiagnose objectAtIndex:indexPath.row] longdescription];
            }
            break;
        case 3:
            if (_patienttherapy == nil || [_patienttherapy count]== 0) {
                text = @"";
            }
            else {
                text = [[_patienttherapy objectAtIndex:indexPath.row] longdescription];
            }
            break;
        default:
            break;
    }
    // Get a CGSize for the width and, effectively, unlimited height
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    // Get the size of the text given the CGSize we just made as a constraint
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    // Get the height of our measurement, with a minimum of 44 (standard cell size)
    CGFloat height = MAX((size.height+10.0f), 44.0f);
    // return the height, with a bit of extra padding in
    return height + (CELL_CONTENT_MARGIN * 3);
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
    switch (indexPath.section) {
        case 0:
        {
            if ([_patientanamnese count] == 0 || _patientanamnese == nil) {
                shortdes.text = @" keine Einträge vorhanden";
                longdes.text = nil;
                time.text = nil;
            }
            else {
                shortdes.text = [[[_patientanamnese objectAtIndex:indexPath.row] possibleclinicalissue] shortdescription];
                longdes.text = [[_patientanamnese objectAtIndex:indexPath.row] longdescription];
                
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyy HH:mm:ss"];
                NSString *stringFromDate = [formatter stringFromDate:[[_patientanamnese objectAtIndex:indexPath.row] valueForKey:@"timestamp"]];
                time.text = stringFromDate;
                time.textAlignment = UITextAlignmentRight;
                
                
                //modify pictures layout
                UIImage *pic = [[UIImage alloc] initWithData:[[[_patientanamnese objectAtIndex:indexPath.row] possibleclinicalissue] picture]];
                patientpicview.image = pic;
            }
            
            
            [longdes sizeToFit];
            break;
        }   
        case 1:
        {            if ([_patientresult count] == 0 || _patientresult == nil) {
            shortdes.text = @" keine Einträge vorhanden";
            longdes.text = nil;
            time.text = nil;
        }
        else {
            shortdes.text = [[[_patientresult objectAtIndex:indexPath.row] possibleclinicalissue] shortdescription];
            longdes.text = [[_patientresult objectAtIndex:indexPath.row] longdescription];
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd.MM.yyy HH:mm:ss"];
            NSString *stringFromDate = [formatter stringFromDate:[[_patientresult objectAtIndex:indexPath.row] valueForKey:@"timestamp"]];
            time.text = stringFromDate;
            time.textAlignment = UITextAlignmentRight;
            
            
            //modify pictures layout
            UIImage *pic = [[UIImage alloc] initWithData:[[[_patientresult objectAtIndex:indexPath.row] possibleclinicalissue] picture]];
            patientpicview.image = pic;
        }
            [longdes sizeToFit];
            break;
        }     
        case 2:
        {            if ([_patientdiagnose count] == 0 || _patientdiagnose == nil) {
            shortdes.text = @" keine Einträge vorhanden";
            longdes.text = nil;
            time.text = nil;
        }
        else {
            shortdes.text = [[[_patientdiagnose objectAtIndex:indexPath.row] possibleclinicalissue] shortdescription];
            longdes.text = [[_patientdiagnose objectAtIndex:indexPath.row] longdescription];
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd.MM.yyy HH:mm:ss"];
            NSString *stringFromDate = [formatter stringFromDate:[[_patientdiagnose objectAtIndex:indexPath.row] valueForKey:@"timestamp"]];
            time.text = stringFromDate;
            time.textAlignment = UITextAlignmentRight;
            
            
            //modify pictures layout
            UIImage *pic = [[UIImage alloc] initWithData:[[[_patientdiagnose objectAtIndex:indexPath.row] possibleclinicalissue] picture]];
            patientpicview.image = pic;
        }
            [longdes sizeToFit];
            break;
        }           
        case 3:
        {           
            if ([_patienttherapy count] == 0 || _patienttherapy == nil) {
                shortdes.text =  @" keine Einträge vorhanden";
                longdes.text = nil;
                time.text = nil;
            }
            else {
                shortdes.text = [[[_patienttherapy objectAtIndex:indexPath.row] possibleclinicalissue] shortdescription];
                longdes.text = [[_patienttherapy objectAtIndex:indexPath.row] longdescription];
                
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyy HH:mm:ss"];
                NSString *stringFromDate = [formatter stringFromDate:[[_patienttherapy objectAtIndex:indexPath.row] valueForKey:@"timestamp"]];
                time.text = stringFromDate;
                time.textAlignment = UITextAlignmentRight;
                
                
                //modify pictures layout
                UIImage *pic = [[UIImage alloc] initWithData:[[[_patienttherapy objectAtIndex:indexPath.row] possibleclinicalissue] picture]];
                patientpicview.image = pic;
            }
            
            [longdes sizeToFit];
            break;
        }   
            
        default:
            break;    
            
            
            
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{   
    //changes are made just now!!
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    
    //    [[segue destinationViewController] setDetailItem: self.detailItem];
    //    _popover = [(UIStoryboardPopoverSegue *)segue popoverController];
    //    tyxAddDiagnostikViewController *adc = (tyxAddDiagnostikViewController *)_popover.contentViewController;
    //    adc.delegate = self;
    
    
    UINavigationController *nextNavigation = [segue destinationViewController];
    tyxAddDiagnostikViewController *tv = (tyxAddDiagnostikViewController *)(id)[nextNavigation.viewControllers objectAtIndex:0];
    tv.delegate = self;
    tv.detailItem = self.detailItem;
    NSLog(@"patient is;%@", tv.detailItem);
    _popover = [(UIStoryboardPopoverSegue *)segue popoverController];
    nextNavigation = (UINavigationController *)_popover.contentViewController;
}

-(void)dismissPopover
{    
    [self setSections];
    [self.tableView reloadData];
    [_popover dismissPopoverAnimated:YES];
}


@end
