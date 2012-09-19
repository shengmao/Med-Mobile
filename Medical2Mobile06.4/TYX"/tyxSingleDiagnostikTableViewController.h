//
//  tyxSingleDiagnostikTableViewController.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 20.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tyxAddDiagnostikPickerViewController.h"

@interface tyxSingleDiagnostikTableViewController : UITableViewController <DismissPopoverDelegate>
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSArray *patientanamnese;
@property (strong, nonatomic) NSArray *patientdiagnose;
@property (strong, nonatomic) NSArray *patienttherapy;
@property (strong, nonatomic) NSArray *patientresult;
@end
