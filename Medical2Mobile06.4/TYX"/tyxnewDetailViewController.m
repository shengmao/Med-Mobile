//
//  tyxnewDetailViewController.m
//  TYX"
//
//  Created by LISComputer on 18.06.12.
//  Copyright (c) 2012 Techedge GmbH. All rights reserved.
//

#import "tyxnewDetailViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "Patient.h"
#import "Desease.h"
#import "PossibleICDNumber.h"
#import "PossibleClinicalIssue.h"
#import "Activity.h"
#import "Document.h"

//number of items per sections
#define MAXNUMBER 7

@interface tyxnewDetailViewController ()

@end

@implementation tyxnewDetailViewController
@synthesize dvimage1;
@synthesize detailItem = _detailItem;
@synthesize patientpic = _patientpic;
@synthesize patientname = _patientname;
@synthesize deseasearray = _deseasearray;
@synthesize patientissuearray = _patientissuearray;
@synthesize patientallergyarray = _patientallergyarray;
@synthesize patientdocumentarray = _patientdocumentarray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configureView
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    // set up Update  part of user interface for the detail item, more specifically the first section of detial view..
    if (self.detailItem) {
        //select all diagnose
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        NSArray *temp_array1 = [[self.detailItem activity] sortedArrayUsingDescriptors:sortDescriptors];
        _deseasearray = [[NSMutableArray alloc] init];
        for (Activity *activity in temp_array1) {
            if ([[activity.possibleclinicalissue shortdescription] isEqualToString: @"Diagnose"]) {
                [_deseasearray addObject: activity]; 
            }
        }        
        
        //select all issues
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
        sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        NSArray *temp_array2 = [[self.detailItem activity] sortedArrayUsingDescriptors:sortDescriptors];
        _patientissuearray = [[NSMutableArray alloc] init];
        for (Activity *activity in temp_array2) {
            if (![[activity.possibleclinicalissue type] isEqualToString: @"Untersuchung"]){
                [_patientissuearray addObject: activity];
            }
        }
        NSInteger num = [_patientissuearray count];
        NSLog(@"the number of activity is: %i", num);
        
        //select all allergies
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"shortdescription" ascending:NO];
        sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        _patientallergyarray = [[self.detailItem allergy] sortedArrayUsingDescriptors:sortDescriptors];
        
        //select all documents
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateinsert" ascending:YES];
        sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        _patientdocumentarray = [[self.detailItem document] sortedArrayUsingDescriptors:sortDescriptors];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark TableView Section

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    //number of predefined sections to show
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    
    //counts the number of rows per section and compare the result to the maximum number of items, if the array is bigger clip it at index maxnumber
    NSInteger countedRows;
    countedRows = 1;
    switch (section) {
        case 0:
        {
            countedRows = 1;
            break;
        }
        case 1:
        {
            if(!(_patientallergyarray == nil || [_patientallergyarray count] ==0))
            {
                countedRows = [_patientallergyarray count];
            }
            break;
        }
        case 2:
        {
            if (!(_deseasearray == nil || [_deseasearray count] == 0))
            {
                countedRows = [_deseasearray count];
            }
            break;
        }
        case 3:
        {
            if(!(_patientdocumentarray == nil || [_patientdocumentarray count] ==0))
            {
                countedRows = [_patientdocumentarray count];
            }
            break;
        }
        case 4:
        {
            if(!(_patientissuearray == nil || [_patientissuearray count] ==0))
            {
                countedRows = [_patientissuearray count];
            }
            break;
        }
        default:
            countedRows = 1;
            break;
    }
    
    //set the number of shown items to a maximum
    if (countedRows > MAXNUMBER) {
        return MAXNUMBER;
    }
    else {
        return countedRows;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    //returns predefined SectionHeader
    switch (section) {
        case 0:
            return @"Patient";
            break;
        case 1:
            return @"Allergien/Risiken";
            break;
        case 2:
            return @"Diagnosen";
            break;
        case 3:
            return @"Dokumente";
            break;
        case 4:
            return @"Klinische Aufträge";
        default:
            return @"nicht bekannt";
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        return 119; 
    }
    else {
        return 44;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
        {               
            static NSString *CellIdentifier = @"PatientBasicCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first section look and feel
            UIImageView *patientpicview =(UIImageView *)[cell viewWithTag:101];
            UILabel *patientnamelabel =(UILabel *)[cell viewWithTag:102];
            UILabel *patientbirthdate = (UILabel *)[cell viewWithTag:103];
            UILabel *patientstation = (UILabel *) [cell viewWithTag:104];
            UILabel *patientroom = (UILabel *) [cell viewWithTag:105];
            UILabel *patientincome = (UILabel *) [cell viewWithTag:106];
            UILabel *patientleave = (UILabel *) [cell viewWithTag:107];
            
            
            //Load the patient picture, if there is none use a default
            if([self.detailItem picture]) {
                _patientpic =[UIImage imageWithData:[self.detailItem picture]];
            }
            else {
                _patientpic = [UIImage imageNamed:@"patientpicture.png"];
            }
            //modify pictures layout
            patientpicview.image = _patientpic;
            [[patientpicview layer] setCornerRadius:10.0f];
            [[patientpicview layer] setBorderColor:[UIColor clearColor].CGColor];
            [[patientpicview layer] setBorderWidth:2.0f];
            [[patientpicview layer] setMasksToBounds:YES];
            
            
            //Configure the name of patient...
            _patientname = [[NSString alloc] init];
            _patientname = [_patientname stringByAppendingString: [self.detailItem fname]];
            _patientname = [_patientname stringByAppendingString:@" "];
            _patientname = [_patientname stringByAppendingString:[self.detailItem lname]];
            patientnamelabel.text = _patientname;
            
            
            //birtdate
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd.MM.yyyy"];
            
            NSString *stringFromDate = [formatter stringFromDate:[self.detailItem birthdate]];
            patientbirthdate.text = stringFromDate;
            
            //Station
            patientstation.text = [self.detailItem station];
            
            //room
            patientroom.text = [self.detailItem room];
            
            //date income
            stringFromDate = [formatter stringFromDate:[self.detailItem dateincome]];
            patientincome.text = stringFromDate;
            
            //date leave
            stringFromDate = [formatter stringFromDate:[self.detailItem dateleave]];
            patientleave.text = stringFromDate;
            
            return cell;
            break;
        }
        case 1:
        {
            //configure allergies/risks cell
            static NSString *CellIdentifier = @"PatientClinicalIsssueCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first label's look and feel.
            UILabel *ShortDescription =(UILabel *)[cell viewWithTag:301];
            UILabel *issuedate = (UILabel *)[cell viewWithTag:302];
            
            if (!(_patientallergyarray == nil || [_patientallergyarray count]) == 0) {
                ShortDescription.text = [[_patientallergyarray objectAtIndex:indexPath.row] shortdescription];
                issuedate.text = nil;
                cell.imageView.image = nil;
            }
            else {
                ShortDescription.text =@"keine Einträge vorhanden";
                issuedate.text = nil;
                cell.imageView.image = nil;
            }
            return cell;
            break;
        }    
        case 2:
        {
            //configure desease cells
            //configuration of second section's look and feel
            static NSString *CellIdentifier = @"PatientDeseaseCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first label's look and feel.
            UILabel *ShortDescription =(UILabel *)[cell viewWithTag:201];
            UILabel *issuedate = (UILabel *)[cell viewWithTag:202];
            
            if (!(_deseasearray == nil || [_deseasearray count]) == 0) {
                NSString *temp_shortDesc = [[[_deseasearray objectAtIndex:indexPath.row] longdescription] substringToIndex: 43];
                ShortDescription.text = temp_shortDesc; 
               
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
                NSString *stringFromDate = [formatter stringFromDate:[(Activity *)[_deseasearray objectAtIndex:indexPath.row]  timestamp]];
                issuedate.text = stringFromDate; 
                
                //insert a picture
                if([[[_deseasearray objectAtIndex:indexPath.row] possibleclinicalissue] picture] != nil) {
                    cell.imageView.image =[UIImage imageWithData:[[[_deseasearray objectAtIndex:indexPath.row] possibleclinicalissue] picture]];
                }
                else {
                    cell.imageView.image = nil;                                
                }
            }
            else {
                ShortDescription.text =@"keine Aufträge vorhanden";
                issuedate.text = @"-";
                cell.imageView.image = nil;
            }
            return cell;
            break;
        }
        case 3:
        {
            //configure document cell
            static NSString *CellIdentifier = @"PatientDocumentCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first label's look and feel.
            UILabel *ShortDescription =(UILabel *)[cell viewWithTag:401];
            UILabel *issuedate = (UILabel *)[cell viewWithTag:402];
            
            if (!(_patientdocumentarray == nil || [_patientdocumentarray count]) == 0) {
                ShortDescription.text = [[_patientdocumentarray objectAtIndex:indexPath.row] shortdescription];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyyy hh:mm:ss"];
                NSString *stringFromDate = [formatter stringFromDate:[[_patientdocumentarray objectAtIndex:indexPath.row] dateinsert]];
                issuedate.text = stringFromDate; 
                //set a symbol
                if ([[[_patientdocumentarray objectAtIndex:indexPath.row] documentType] isEqualToString:@"Bild"]) {
                    cell.imageView.image = [UIImage imageNamed:@"radiationsign.jpg"];
                }
                else {
                    cell.imageView.image = [UIImage imageNamed:@"pdfsign.jpg"];
                }
            }
            else {
                ShortDescription.text =@"keine Dokumente vorhanden";
                issuedate.text = @"-";
                cell.imageView.image = nil;
            }
            return cell;
            break;
        }
        case 4:
        {
            //configure issue cells
            static NSString *CellIdentifier = @"PatientIssueCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first label's look and feel.
            UILabel *ShortDescription =(UILabel *)[cell viewWithTag:501];
            UILabel *issuedate = (UILabel *)[cell viewWithTag:502];
            
            if (!(_patientissuearray == nil || [_patientissuearray count]) == 0) {
                ShortDescription.text = [[[_patientissuearray objectAtIndex:indexPath.row] possibleclinicalissue] shortdescription]; 
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyyy hh:mm:ss"];
                
                NSString *stringFromDate = [formatter stringFromDate:[[_patientissuearray objectAtIndex:indexPath.row] valueForKey:@"timestamp"]];
                issuedate.text = stringFromDate; 
                //issuedate.text = [[_patientissuearray objectAtIndex:indexPath.row] valueForKey:@"timestamp"];
                //insert a picture
                if([[[_patientissuearray objectAtIndex:indexPath.row] possibleclinicalissue] picture] != nil) {
                    cell.imageView.image =[UIImage imageWithData:[[[_patientissuearray objectAtIndex:indexPath.row] possibleclinicalissue] picture]];
                }
                else {
                    cell.imageView.image = nil;                                
                }
            }
            else {
                ShortDescription.text =@"keine Aufträge vorhanden";
                issuedate.text = @"-";
                cell.imageView.image = nil;
            }
            return cell;
            break;
        }
        default:
        {
            static NSString *CellIdentifier = @"PatientDefaultCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first section look and feel
            cell.detailTextLabel.text = @"Falsche Zelle gewählt";
            return cell;
            break;
        }
    }
}

#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     
}
*/


@end
