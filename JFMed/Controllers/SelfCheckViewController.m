//
//  SelfCheckViewController.m
//  JFMed
//
//  Created by Michael on 7/22/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "SelfCheckViewController.h"
#import "MBRotateControl.h"

@interface SelfCheckViewController () <MBRotateDelegate>

@property (nonatomic, strong) UILabel *angleLabel;

@end

@implementation SelfCheckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    MBRotateControl *rotateControl = [[MBRotateControl alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH)];
    rotateControl.delegate = self;
    [self.view addSubview:rotateControl];
    
    self.angleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 550, SCREEN_WIDTH, 20)];
    self.angleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.angleLabel];
}

#pragma mark - MBRotateDelegate

- (void)angleDidChangeTo:(CGFloat)angle
{
    self.angleLabel.text = [NSString stringWithFormat:@"当前角度：%.0f度", fabs(angle)];
}

@end
