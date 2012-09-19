//
//  NeurospinewatermarkmasterviewViewController.m
//  TYX"
//
//  Created by LISComputer on 25.06.12.
//  Copyright (c) 2012 Techedge GmbH. All rights reserved.
//

#import "NeurospinewatermarkmasterviewViewController.h"
#import "tyxSingleDiagnostikTableViewController.h"
#import "TESingleDocumentListViewController.h"

@interface NeurospinewatermarkmasterviewViewController (){
    NSString *object;
}
@property NSMutableArray *usertabsarray;
@property NSArray *usertabsiconarray;
@end

@implementation NeurospinewatermarkmasterviewViewController
@synthesize usertabs;
@synthesize usertabsarray;
@synthesize usertabsiconarray;
@synthesize detailItem = _detailItem;
@synthesize ip =_ip;

- (void)viewDidLoad
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    usertabsarray = [[NSMutableArray alloc] initWithObjects:@"Übersicht", @"Chronik", @"Diagnostik", @"Klinische Aufträge", @"Vitalwerte", @"Labor", @"Demographie", @"Dokumente", @"Abrechnung", @"EMR Info",nil];
    usertabsiconarray = [[NSArray alloc] initWithObjects:@"picto37.jpg",@"picto67.jpg",@"picto55.jpg", @"picto12.jpg",@"picto58.jpg",@"picto57.jpg", @"picto117.jpg", @"picto15.jpg",@"picto118.jpg",@"picto45.jpg", nil];
    NSLog(@"%@",usertabsiconarray);
    
	// Do any additional setup after loading the view.
    NSLog(@"%@",_detailItem);
    NSLog(@"indexpath ip value is:%@", _ip);
}

-(void)viewWillAppear:(BOOL)animated

{
    
    //preselect a cell
    if ( [object isEqualToString:@"Dokumente"]) {
        _ip=[NSIndexPath indexPathForRow:7 inSection:0];
        
        [(UITableView*)self.usertabs selectRowAtIndexPath:_ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }else{
        
        [(UITableView*)self.usertabs selectRowAtIndexPath:_ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }
    
   
    
}

- (void)viewDidUnload
{
    [self setUsertabs:nil];
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

#pragma mark patientList - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.usertabsarray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    // Configure the cell...
    cell.textLabel.text = [usertabsarray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.imageView.image = [UIImage imageNamed:[usertabsiconarray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //read the current selection in tableview and perform the next segue
    object = [self.usertabsarray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:object sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //pass information about the patient to next detail controller
    if ([segue.identifier isEqualToString:@"Diagnostik"]){
        UINavigationController *nextNavigation = [segue destinationViewController];
        tyxSingleDiagnostikTableViewController *dt = (tyxSingleDiagnostikTableViewController *)(id)[nextNavigation.viewControllers objectAtIndex:0];
        [dt setDetailItem: self.detailItem];
    }
   
        else {
            [[segue destinationViewController] setDetailItem:self.detailItem]; 
        }
    
}

@end
