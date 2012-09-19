//
//  tyxSingleChronicViewController.h
//  Medical2Mobile
//
//  Created by LISComputer on 29.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface tyxSingleChronicViewController : UITableViewController
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) id detailItem;


@end
