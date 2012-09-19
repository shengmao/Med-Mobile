//
//  tyxClinicalIssuesViewController.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 24.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tyxClinicalIssuesViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSArray *internalissues;
@property (strong, nonatomic) NSArray *externalissues;

@end
