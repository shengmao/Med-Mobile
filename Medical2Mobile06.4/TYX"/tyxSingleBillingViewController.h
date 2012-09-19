//
//  tyxSingleBillingViewController.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 24.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Billing.h"

@interface tyxSingleBillingViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) NSArray *billingnotsend;
@property (strong, nonatomic) NSArray *billingsend;
@property (strong, nonatomic) NSArray *billingpayed;
@property (strong, nonatomic) NSArray *allItems;
@property (strong, nonatomic) Billing *selectedBilling;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
