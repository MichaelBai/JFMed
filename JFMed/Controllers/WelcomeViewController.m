//
//  ViewController.m
//  JFMed
//
//  Created by Michael on 7/18/16.
//  Copyright (c) 2016 MichaelBai. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *registerBtn = [UIButton new];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    UIButton *loginBtn = [UIButton new];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(gotoLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@-70);
        make.bottom.equalTo(@-100);
    }];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@70);
        make.bottom.equalTo(@-100);
    }];
}

- (void)gotoLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)gotoRegister
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

@end
