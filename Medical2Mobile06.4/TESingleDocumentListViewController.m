//
//  TESingleDocumentListViewController.m
//  AlHami@Mobile
//
//  Created by Sandra Möller on 21.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "TESingleDocumentListViewController.h"
#import <QuickLook/QuickLook.h>
#import "Patient.h"
#import "Document.h"


@interface TESingleDocumentListViewController ()
{
    NSMutableArray *farray;
}
@end

@implementation TESingleDocumentListViewController
@synthesize FileListTableView;
@synthesize fileURL;
@synthesize pdfPath;
@synthesize imagePath;
@synthesize bildPath;
@synthesize detailItem = _detailItem;
@synthesize doctypejpg = _doctypejpg;
@synthesize doctypepdf = _doctypepdf;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//fill table with documents from this patient
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"documentType" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"dateinsert" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, sortDescriptor2, nil];
    fileNameList = [[self.detailItem document] sortedArrayUsingDescriptors:sortDescriptors];
    
    //all pdf
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"documentType = \"PDF\""];
    _doctypepdf = [fileNameList filteredArrayUsingPredicate:predicate];
    
    //all jpg
    predicate = [NSPredicate predicateWithFormat:@"documentType = \"Bild\""];
    _doctypejpg = [fileNameList filteredArrayUsingPredicate:predicate];
}

- (void)viewDidUnload
{
    FileListTableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    switch (section) {
        case 0:
            if ([_doctypejpg count] ==0) {
                return 1;
            }
            else {
                //return [_doctypejpg count];
                return 1;
            }
            break;
        case 1:
            if ([_doctypepdf count] ==0) {
                return 1;
            }
            else {
                //return [_doctypepdf count];
                return 1;
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
            return @"Bilder";
            break;
        case 1:
            return @"Berichte";
            break;
        default:
            return @"nicht bekannt";
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    static NSString *CellIdentifier = @"DocumentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
            //Cell configuration for items that are not calculated
            if (_doctypejpg == nil || [_doctypejpg count] == 0) {
                cell.textLabel.text = @"keine Einträge vorhanden";
                cell.detailTextLabel.text = nil;
            }
            else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyyy hh:mm:ss"];
                NSString *string = [[NSString alloc] init];
                NSString *number =[[NSString alloc] initWithFormat:@"%d", [_doctypejpg count]];
                string = [string stringByAppendingFormat:[[_doctypejpg objectAtIndex:indexPath.row] shortdescription]];
                if ([_doctypejpg count] ==1) {
                    string = [string stringByAppendingFormat:@"(%@file)", number];
                }else {
                    string = [string stringByAppendingFormat:@"(%@files)", number];
                }
          
                cell.textLabel.text = string;
                cell.detailTextLabel.text = [formatter stringFromDate:[[_doctypejpg objectAtIndex:indexPath.row] dateinsert]];  
                cell.imageView.image = [UIImage imageNamed:@"radiationsign.jpg"];
            }
            break;
        case 1:
            if (_doctypepdf == nil || [_doctypepdf count] == 0) {
                cell.textLabel.text = @"keine Einträge vorhanden";
                cell.detailTextLabel.text = nil;
            }
            else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyyy hh:mm:ss"];
                cell.textLabel.text = [[_doctypepdf objectAtIndex:indexPath.row] shortdescription];
                cell.detailTextLabel.text = [formatter stringFromDate:[[_doctypepdf objectAtIndex:indexPath.row] dateinsert]];  
                cell.imageView.image = [UIImage imageNamed:@"pdfsign.jpg"];
            }
            break;
        default:
            cell.detailTextLabel.text = @"Fehler";
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
    switch (indexPath.section) {
                  
        case 0:
            farray = [[NSMutableArray alloc] init];
            for (int i =0; i < [_doctypejpg count] ; i++) {
                NSLog(@"---> %s",__PRETTY_FUNCTION__);
                fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[[_doctypejpg objectAtIndex: i] documentname] ofType:@"jpg"]];
                [farray  addObject:fileURL];
            }
            break;
        case 1:
            farray = [[NSMutableArray alloc] init];
            for (int i =0; i < [_doctypepdf count] ; i++) {
                NSLog(@"---> %s",__PRETTY_FUNCTION__);
                fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[[_doctypepdf objectAtIndex: i] documentname] ofType:@"pdf"]];
                [farray  addObject:fileURL];
            }
            break;        
        default:
            break;
    } 
    
    //creating object of QLPreviewController
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    
    //setting datasource to self
    previewController.dataSource = self;
    
    //pushing the controller to navigation stack
    //[[self navigationController] pushViewController:previewController animated:YES];
    [self presentModalViewController:previewController animated:YES];
    
    //remove the right bar print button
    [previewController.navigationItem setRightBarButtonItem:nil];
}


#pragma mark - QLPreviewControllerDataSource
//Returns the number of items the preview controller should preview
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController
{
    return [farray count];
}

//returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)index
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    if ([farray count]> index) {
        return [farray objectAtIndex: index];
    }
    else {
        return [farray lastObject];

    }
}

@end
