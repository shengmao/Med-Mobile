//
//  TESingleDocumentListViewController.h
//  AlHami@Mobile
//
//  Created by Sandra Möller on 21.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface TESingleDocumentListViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource, QLPreviewControllerDataSource, QLPreviewControllerDelegate>
{
    NSArray *fileNameList;
    IBOutlet UITableView *FileListTableView;
    NSURL *fileURL;
}

@property (strong, nonatomic) id detailItem;
@property (nonatomic, retain) NSURL *fileURL;
@property (nonatomic, retain) UITableView *FileListTableView;

@property (strong, nonatomic) NSArray *doctypepdf;
@property (strong, nonatomic) NSArray *doctypejpg;

@property (nonatomic, retain) NSString *pdfPath;
@property (nonatomic, retain) NSString *imagePath;
@property (nonatomic, retain) NSString *bildPath;

@end
