//
//  tyxsecdetaiViewController.m
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 Techedge GmbH. All rights reserved.
//

#import "tyxsecdetaiViewController.h"
#import "Patient.h"
@interface tyxsecdetaiViewController ()

@end

@implementation tyxsecdetaiViewController
@synthesize nav_item = _nav_item;
@synthesize detailItem = _detailItem;

- (void)viewDidLoad
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

    [super viewDidLoad];
    //Configure the name of patient...
    NSString *patientname = [[NSString alloc] init];
    patientname = [patientname stringByAppendingString: [_detailItem fname]];
    patientname = [patientname stringByAppendingString:@" "];
    patientname = [patientname stringByAppendingString:[_detailItem lname]];
    _nav_item.title = patientname;
}

- (void)viewDidUnload
{
    [self setNav_item:nil];
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
@end