//
//  tyxDetailViewController.h
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 Techedge GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/Coredata.h>
//#import "Patient.h"
//#import "PossibleICDNumber.h"
//#import "Desease.h"

@class coredataMasterViewController;

@interface tyxDetailViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) id detailItem;

@property ( strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *fetchedObjects;
@property (strong, nonatomic) coredataMasterViewController *masterview;
@property (strong, nonatomic) NSArray *fetchedObjects1;


@property (strong, nonatomic)  NSString  *patientname;
@property (strong, nonatomic) UIImage *patientpic;

@property (strong, nonatomic)  NSString *shortdescription;
//@property (strong, nonatomic)  NSString *ICDnumber;
@property (strong, nonatomic)  NSString *startdate;
@property (strong, nonatomic)  NSMutableArray *deseasearray;

@property (strong, nonatomic) NSMutableArray *patientissuearray;
@property (strong, nonatomic) NSArray *patientdocumentarray;
@property (strong, nonatomic) NSArray *patientallergyarray;

@end
