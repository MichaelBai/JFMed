//
//  HomeViewController.m
//  JFMed
//
//  Created by Michael on 7/20/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "HomeViewController.h"
#import "SelfCheckViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [kAppDelegate showLogin];
    
    UIButton *checkBtn = [UIButton new];
    [checkBtn setTitle:@"脊柱自查" forState:UIControlStateNormal];
    [checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(gotoCheck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
}

- (void)gotoCheck
{
    SelfCheckViewController *selfCheckVC = [[SelfCheckViewController alloc] init];
    [self.navigationController pushViewController:selfCheckVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
