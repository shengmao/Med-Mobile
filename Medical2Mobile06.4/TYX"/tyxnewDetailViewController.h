//
//  tyxnewDetailViewController.h
//  TYX"
//
//  Created by LISComputer on 18.06.12.
//  Copyright (c) 2012 Techedge GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tyxnewDetailViewController : UITableViewController <UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *dvimage1;
@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic)  NSString  *patientname;
@property (strong, nonatomic) UIImage *patientpic;

@property (strong, nonatomic)  NSMutableArray *deseasearray;
@property (strong, nonatomic) NSMutableArray *patientissuearray;
@property (strong, nonatomic) NSArray *patientdocumentarray;
@property (strong, nonatomic) NSArray *patientallergyarray;

@end
