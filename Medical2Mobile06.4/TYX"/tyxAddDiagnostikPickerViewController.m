#import "tyxAddDiagnostikPickerViewController.h"
#import "tyxAppDelegate.h"
#import "tyxSingleDiagnostikTableViewController.h"
#import "Activity.h"
#import "Patient.h"
#import "QuartzCore/QuartzCore.h"
#import "User.h"

@interface tyxAddDiagnostikViewController ()
@end

@implementation tyxAddDiagnostikViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize selectedIssue;
@synthesize fetchedResultsController = _fetchedResultsController;

@synthesize ld = _ld;
@synthesize detailItem = _detailItem;
@synthesize clinicalIssue = _clinicalIssue;
@synthesize delegate =_delegate;

- (void)setupFetchedResultsController
{
    // 0 - Ensure you have a MOC
    if (!self.managedObjectContext) {
        tyxAppDelegate *ad = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = ad.managedObjectContext;
    }
    
	// 1 - Decide what Entity you want
	NSString *entityName = @"PossibleClinicalIssue"; // Put your entity name here
    
	// 2 - Request that Entity
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
	// 3 - Filter it if you want
	request.predicate = [NSPredicate predicateWithFormat:@"type = \"Untersuchung\""];
    
	// 4 - Sort it if you want
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"shortdescription"
																					 ascending:YES
																					  selector:@selector(localizedCaseInsensitiveCompare:)]];
	// 5 - Fetch it
	self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
																		managedObjectContext:self.managedObjectContext
																		  sectionNameKeyPath:nil
																				   cacheName:nil];
	[self.fetchedResultsController performFetch:nil];
    
    NSLog(@"The following ones were fetched for the Picker:");
    for (PossibleClinicalIssue *fetchedIssue in [self.fetchedResultsController fetchedObjects]) {
        NSLog(@"Issue: %@", fetchedIssue.shortdescription);        
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupFetchedResultsController];
    
    //design textview
    //[[self.ld layer] setBorderWidth:1.0f];
    [[self.ld layer] setCornerRadius:5.0f];
    [[self.ld layer] setMasksToBounds:YES];
    [[self.ld layer] setBackgroundColor: [UIColor clearColor].CGColor];
  
    
    //setup buttons 
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Speichern" style:UIBarButtonItemStylePlain target:self action:@selector(saveIssue1:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    NSLog(@"patient is :%@", _detailItem);
}

- (void)viewDidUnload
{
    [self setLd:nil];
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

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [[self.fetchedResultsController fetchedObjects] count];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    // Display the Roles we've fetched on the picker
    PossibleClinicalIssue *issue = [[self.fetchedResultsController fetchedObjects] objectAtIndex:row];
    return issue.shortdescription;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _clinicalIssue = (PossibleClinicalIssue *)[[self.fetchedResultsController fetchedObjects] objectAtIndex:row];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    //pass information about the patient to next detail controller
//    if ([segue.identifier isEqualToString:@"Abbrechen"])
//    {
//        NSLog(@"---> %s",__PRETTY_FUNCTION__);
//        NSLog(@"selected segue: Abbrechen");
//        [[segue destinationViewController] setDetailItem:self.detailItem];
//
//    }
//    if ([segue.identifier isEqualToString:@"Speichern"]) 
//    {
//        [[segue destinationViewController] setDetailItem:self.detailItem];
//        NSLog(@"---> %s",__PRETTY_FUNCTION__);
//        NSLog(@"selected segue: Speichern");
//    }
    
    NSLog(@"%@",segue.identifier);
    [[segue destinationViewController] setDetailItem:self.detailItem];
}


- (IBAction)cancell:(id)sender {
    [self.delegate dismissPopover];
}

- (void)saveIssue1:(id)sender {
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    NSLog(@"patient is :%@", _detailItem);
    //check if there is some description entered, if not give an alert and do not perform save
    if ([self.ld.text length]==0) {
        [[[UIAlertView alloc] initWithTitle:@"Hinweis" message:@"Bitte geben sie eine Beschreibung ein." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else 
    {
        Activity *newActivity = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:_managedObjectContext];
        
       
        
        if (_clinicalIssue != nil) 
        {
            newActivity.possibleclinicalissue = _clinicalIssue;
        }
        else 
        {
            newActivity.possibleclinicalissue =  [[self.fetchedResultsController fetchedObjects] objectAtIndex:0];
        }
        
        [newActivity setPatient: _detailItem];
        [newActivity setLongdescription:self.ld.text];
        
        //set up date
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd.MM.yyyy"];
        NSDate *date = [[NSDate alloc] init];
        NSLog(@"the time right now is: %@", date);
        NSString *stringFromDate = [formatter stringFromDate: date];
        
        [newActivity setSectiondate:stringFromDate];
        [newActivity setTimestamp:date];
        NSLog(@"new Activity is: %@", newActivity);
        NSLog(@"the possible issue is : %@", _clinicalIssue);
        
        
        [self saveContext];  
        [self.delegate dismissPopover]; 
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


@end
