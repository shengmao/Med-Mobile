//
//  tyxAddDiagnostik.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 29.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PossibleClinicalIssue.h"

@protocol DismissPopoverDelegate <NSObject>
-(void) dismissPopover;
@end

@interface tyxAddDiagnostikViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIPopoverControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextView *ld;

@property (strong, nonatomic) id detailItem;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) PossibleClinicalIssue *selectedIssue;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) PossibleClinicalIssue *clinicalIssue;

@property (nonatomic, assign) id<DismissPopoverDelegate> delegate;
- (IBAction)cancell:(id)sender;

- (void)saveIssue1:(id)sender;
@end