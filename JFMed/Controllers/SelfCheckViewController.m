//
//  SelfCheckViewController.m
//  JFMed
//
//  Created by Michael on 7/22/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "SelfCheckViewController.h"
#import "MBRotateControl.h"

@interface SelfCheckViewController ()

@end

@implementation SelfCheckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    MBRotateControl *rotateControl = [[MBRotateControl alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH)];
    [self.view addSubview:rotateControl];
}



@end
