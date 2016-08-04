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
    
    UIImageView *bgImage = [UIImageView new];
    [self.view addSubview:bgImage];
    bgImage.image = [UIImage imageNamed:@"welcome_bg"];
    bgImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UILabel *versionLabel = [UILabel new];
    [self.view addSubview:versionLabel];
    versionLabel.text = @"v1.0";
    versionLabel.textColor = HEXColor(0x98a3b2);
    versionLabel.font = FONT_(17);
    
    UIImageView *nameImg = [UIImageView new];
    [self.view addSubview:nameImg];
    nameImg.image = [UIImage imageNamed:@"welcome_title"];
    
    UILabel *slogon = [UILabel new];
    [self.view addSubview:slogon];
    slogon.text = @"坚持 · 坚强 · 坚定";
    slogon.textColor = HEXColor(0x98a3b2);
    slogon.font = FONT_(17);
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.centerX.equalTo(@0);
    }];
    [nameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(versionLabel.mas_bottom).offset(10);
        make.centerX.equalTo(@0);
    }];
    [slogon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameImg.mas_bottom).offset(12);
        make.centerX.equalTo(@0);
    }];
    
    UIButton *registerBtn = [UIButton new];
    [registerBtn setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateHighlighted];
    [registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    UIButton *loginBtn = [UIButton new];
    [loginBtn setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme_border"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme_border"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(gotoLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@-77.5);
        make.bottom.equalTo(@-180);
        make.width.equalTo(@130);
        make.height.equalTo(@44);
    }];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@77.5);
        make.bottom.equalTo(@-180);
        make.width.equalTo(@130);
        make.height.equalTo(@44);
    }];
    
#warning test
    UIButton *close = [UIButton new];
    [self.view addSubview:close];
    [close setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [close setImage:[UIImage imageNamed:@"close"] forState:UIControlStateHighlighted];
    [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.right.equalTo(@-10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
