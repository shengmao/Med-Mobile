//
//  tyxBlanko2ViewController.m
//  Medical2Mobile
//
//  Created by Sandra Möller on 24.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxBlanko2ViewController.h"

@interface tyxBlanko2ViewController ()

@end

@implementation tyxBlanko2ViewController
@synthesize detailItem = _detailItem;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
