//
//  tyxClinicalIssuesViewController.m
//  Medical2Mobile
//
//  Created by Sandra Möller on 24.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxClinicalIssuesViewController.h"
#import "Patient.h"

@interface tyxClinicalIssuesViewController ()
@property NSDictionary *clinicalissues;
@end

@implementation tyxClinicalIssuesViewController
@synthesize detailItem = _detailItem;
@synthesize externalissues;
@synthesize internalissues;
@synthesize clinicalissues;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    internalissues = [[NSArray alloc] initWithObjects:@"Blutentnahme", @"Röntgen", @"Ultraschall", nil];
    externalissues = [[NSArray alloc] initWithObjects:@"CT",@"MRT", nil];
    
    NSLog(@"Intern: %@", internalissues);
    NSLog(@"Extern: %@", externalissues);
    clinicalissues = [[NSDictionary alloc] initWithObjectsAndKeys:internalissues, @"Interne Aufträge", externalissues, @"Externe Aufträge", nil];
    
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
    return [clinicalissues count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return [internalissues count];
            break;
            
        case 1:
            return [externalissues count];
            break;
        default:
            return 1;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Interne Aufträge";
            break;
        case 1:
            return @"Externe Aufträge";
        default:
            return @"unbekannt";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //NSLog(@"%@",indexPath.section);

    // Configure the cell...
    switch (indexPath.section) {
        case 0:
            NSLog(@"%@",[internalissues objectAtIndex:indexPath.row]);
            cell.textLabel.text = [internalissues objectAtIndex:indexPath.row];
            switch (indexPath.row) {
                case 0:
                    cell.imageView.image = [UIImage imageNamed:@"picto65.jpg"];
                    break;
                case 1:
                    cell .imageView.image = [UIImage imageNamed:@"picto119.jpg"];
                    break;
                case 2:
                    cell .imageView.image = [UIImage imageNamed:@"picto98.jpg"];
                default:
                    break;
            }
            break;
        case 1:
            cell.textLabel.text = [externalissues objectAtIndex:indexPath.row];
            switch (indexPath.row) {
                case 0:
                    cell .imageView.image = [UIImage imageNamed:@"picto84.jpg"];
                    break;
                case 1:
                    cell .imageView.image = [UIImage imageNamed:@"picto85.jpg"];
                    break;
                default:
                    break;
            }
            break;
        default:
            cell.textLabel.text = @"nicht bekannt";
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
    NSString *selectedIssue = @"";
    
    switch (indexPath.section) {
        case 0:
            selectedIssue = [internalissues objectAtIndex:indexPath.row];
            break;
        case 1:
            selectedIssue = [externalissues objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    selectedIssue = [selectedIssue stringByAppendingString:@" Auftrag wird ausgeführt."];
    [[[UIAlertView alloc] initWithTitle:@"Hinweis" message:selectedIssue delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];

    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
@end
