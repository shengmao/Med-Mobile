//
//  tyxSingleBillingViewController.m
//  Medical2Mobile
//
//  Created by Sandra Möller on 24.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxSingleBillingViewController.h"
#import "tyxAppDelegate.h"
#import "Billing.h"
#import "Patient.h"

@interface tyxSingleBillingViewController ()
@property NSInteger selectedSection;
@end

@implementation tyxSingleBillingViewController
@synthesize detailItem = _detailItem;
@synthesize selectedBilling = _selectedBilling;
@synthesize allItems;
@synthesize billingnotsend = _billingnotsend;
@synthesize billingsend = _billingsend;
@synthesize billingpayed = _billingpayed;
@synthesize selectedSection;
@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)configureSections {
    
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"iscalculated" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    allItems = [[self.detailItem billing] sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"allItems: %i, %@",[allItems count], allItems);
    
    //filter all items that are not calculated yet
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"iscalculated == 0"];
    _billingnotsend = [allItems filteredArrayUsingPredicate:predicate];
    NSLog(@"NotSend: %i,  %@",[_billingnotsend count], _billingnotsend);
    
    //filter all items for that a billing is already send but not payed till now
    predicate = [NSPredicate predicateWithFormat:@"((iscalculated == 1) AND (datepayed == nil))"];
    _billingsend = [allItems filteredArrayUsingPredicate:predicate];
    NSLog(@"Send: %i, %@",[_billingsend count], _billingsend);
    
    //all payed items
    predicate = [NSPredicate predicateWithFormat:@"datepayed != nil"];
    _billingpayed = [allItems filteredArrayUsingPredicate:predicate];
}
- (void)viewDidLoad
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    
    if (self.detailItem) {
        [self configureSections];
    }
    else {
        NSLog(@"Fehler");
    }
    if (!self.managedObjectContext) {
        tyxAppDelegate *ad = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = ad.managedObjectContext;
    }
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            if ([_billingnotsend count] ==0 || _billingnotsend == nil) {
                return 1;
            }
            else {
                return [_billingnotsend count];
            }
            break;
        case 1:
            if ([_billingsend count] ==0 || _billingsend == nil) {
                return 1;
            }
            else {
                return [_billingsend count];
            }
            break;
        case 2:
            if ([_billingpayed count] ==0 || _billingpayed == nil) {
                return 1;
            }
            else {
                return [_billingpayed count];
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
            return @"Freigabecenter";
            break;
        case 1:
            return @"Offene Positionen";
            break;
        case 2:
            return @"Bezahlte Positionen";
            break;
        default:
            return @"nicht bekannt";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    static NSString *CellIdentifier = @"BillingCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    UILabel *billingdescription = (UILabel *)[cell viewWithTag:200];
    UILabel *billingcost = (UILabel *)[cell viewWithTag:201];
    UILabel *billinginsert = (UILabel *)[cell viewWithTag:202];
    UILabel *billingpayed = (UILabel *)[cell viewWithTag:203];
    switch (indexPath.section) {
        case 0:
            //Cell configuration for items that are not calculated
            if (_billingnotsend == nil || [_billingnotsend count] == 0) {
                billingdescription.text = @"keine Einträge vorhanden";  
                billinginsert.text = @"";
                billingcost.text = @"";
                billingpayed.text = @"";
                //if the patient has no item, user interactions are disabled so the didSelectRowAtIndexPath can not crashes with an error because of nil array
                cell.userInteractionEnabled = NO;
            }
            else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyyy"];
                billingdescription.text = [[_billingnotsend objectAtIndex:indexPath.row] shortdescription];
                billinginsert.text = [formatter stringFromDate:[[_billingnotsend objectAtIndex:indexPath.row] dateinsert]];
                NSString *price = [[[_billingnotsend objectAtIndex:indexPath.row] cost] stringValue];
                price = [price stringByAppendingString:@",00 €"];
                billingcost.text = price;
                billingpayed.text = @"nicht abgerechnet";
            }
                cell.backgroundColor = [UIColor redColor];
            break;
        case 1:
            if (_billingsend == nil || [_billingsend count] == 0) {
                billingdescription.text = @"keine Einträge vorhanden";
                billinginsert.text = @"";
                billingcost.text = @"";
                billingpayed.text = @"";
                //if the patient has no item, user interactions are disabled so the didSelectRowAtIndexPath can not crashes with an error because of nil array
                cell.userInteractionEnabled = NO;
            }
            else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyyy"];
                billingdescription.text = [[_billingsend objectAtIndex:indexPath.row] shortdescription];
                billinginsert.text = [formatter stringFromDate:[[_billingsend objectAtIndex:indexPath.row] dateinsert]];          
                NSString *price = [[[_billingsend objectAtIndex:indexPath.row] cost] stringValue];
                price = [price stringByAppendingString:@",00 €"];
                billingcost.text = price;
                billingpayed.text = @"nicht bezahlt";
            }
                cell.backgroundColor = [UIColor orangeColor];
            break;
        case 2:
            if (_billingpayed == nil || [_billingpayed count] == 0) {
                billingdescription.text = @"keine Einträge vorhanden";
                billinginsert.text = @"";
                billingcost.text = @"";
                billingpayed.text = @"";   
                //if the patient has no item, user interactions are disabled so the didSelectRowAtIndexPath can not crashes with an error because of nil array
                cell.userInteractionEnabled = NO;
            }
            else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd.MM.yyyy"];
                billingdescription.text = [[_billingpayed objectAtIndex:indexPath.row] shortdescription];
                billinginsert.text = [formatter stringFromDate:[[_billingpayed objectAtIndex:indexPath.row] dateinsert]];  
                NSString *price = [[[_billingpayed objectAtIndex:indexPath.row] cost] stringValue];
                price = [price stringByAppendingString:@",00 €"];
                billingcost.text = price;
                [formatter setDateFormat:@"dd.MM.yyyy"];
                billingpayed.text = [formatter stringFromDate:[[_billingpayed objectAtIndex:indexPath.row] datepayed]];
            }            
            cell.backgroundColor = [UIColor greenColor];
            break;
        default:
            cell.detailTextLabel.text = @"Fehler";
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            //if the selected item is not calculated the actual timestamp is given and an nsalert appears
            _selectedBilling = (Billing *) [_billingnotsend objectAtIndex:indexPath.row];
            selectedSection = 0;
        [[[UIAlertView alloc] initWithTitle:@"Hinweis" message:@"Rechnung wird versendet" delegate:self cancelButtonTitle:@"Abbrechen" otherButtonTitles:@"Versenden", nil] show];
            break;
        }
        case 1: 
        {
            //if the selected item is calculated but not payed yet, an alert for entering a date appears. the inserted value have to be bigger than dateinsert and it have to be a valid date that is not bigger than the actual date
            _selectedBilling = (Billing *) [_billingsend objectAtIndex:indexPath.row];
            selectedSection = 1;
            
            [[[UIAlertView alloc] initWithTitle:@"Hinweis" message:@"Rechnung wurde bezahlt." delegate:self cancelButtonTitle:@"Abbrechen" otherButtonTitles:@"Versenden",nil] show];
            break;
        }
        case 2:
            //if selected item is payed already nothing happens
            break;
        default:
            break;
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
            NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
            if(detailedErrors != nil && [detailedErrors count] > 0) {
                for(NSError* detailedError in detailedErrors) {
                    NSLog(@"  DetailedError: %@", [detailedError userInfo]);
                }
            }
            else {
                NSLog(@"  %@", [error userInfo]);
            }
            abort();
        } 
    }
}

#pragma mark UIAlert
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        //index 0 wurde gewählt
        NSLog(@"INDEX 0");
    }
    else
    {
        switch (selectedSection) {
            case 0:
            {
                NSNumber *val = [[NSNumber alloc] initWithInt:1];
                [_selectedBilling setIscalculated:val];
                [self saveContext];
                [self configureSections];
                [self.tableView reloadData];
                break;
            }
            case 1:
            {
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:1344432855];
                [_selectedBilling setDatepayed:date];
                [self saveContext];
                [self configureSections];
                [self.tableView reloadData];
                break;
            }
            default:
                break;
        }
        //index 1 wurde gewählt
    }
}
@end
