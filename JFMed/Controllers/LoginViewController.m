//
//  LoginViewController.m
//  JFMed
//
//  Created by Michael on 7/20/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgotPasswordViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) NSArray *curTextFields;
@property (nonatomic, strong) UIButton *curButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"登录账号";
    
    CGFloat offsetY = NAV_HEIGHT + 25;
    UITextField *phoneField = [self customTextFieldWithOffsetY:offsetY];
    phoneField.placeholder = @"请输入手机号";
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [phoneField becomeFirstResponder];
    [self.view addSubview:phoneField];
    offsetY += 44 + 25;
    UITextField *pwdField = [self customTextFieldWithOffsetY:offsetY];
    pwdField.placeholder = @"请输入密码";
    pwdField.keyboardType = UIKeyboardTypeAlphabet;
    pwdField.secureTextEntry = YES;
    [self.view addSubview:pwdField];
    offsetY += 44 + 25;
    UIButton *nextBtn = [self customButtonWithOffsetY:offsetY];
    [self.view addSubview:nextBtn];
    [nextBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    self.curButton = nextBtn;
    self.curTextFields = @[phoneField, pwdField];
    
    offsetY += 44 + 16;
    UIButton *forgotPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:forgotPwdBtn];
    forgotPwdBtn.frame = CGRectMake(10, offsetY, 100, 40);
    [forgotPwdBtn setImage:[UIImage imageNamed:@"login_help"] forState:UIControlStateNormal];
    [forgotPwdBtn setImage:[UIImage imageNamed:@"login_help"] forState:UIControlStateHighlighted];
    forgotPwdBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [forgotPwdBtn setTitle:@"密码忘了？" forState:UIControlStateNormal];
    [forgotPwdBtn setTitleColor:HEXColor(0x98a0b4) forState:UIControlStateNormal];
    forgotPwdBtn.titleLabel.font = FONT_(15);
    [forgotPwdBtn addTarget:self action:@selector(gotoForgotPwdVC:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:registerBtn];
    registerBtn.frame = CGRectMake(SCREEN_WIDTH-150-10, offsetY, 150, 40);
    [registerBtn setTitle:@"没有账户？去注册 ›" forState:UIControlStateNormal];
    [registerBtn setTitleColor:HEXColor(0x98a0b4) forState:UIControlStateNormal];
    registerBtn.titleLabel.font = FONT_(15);
    registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [registerBtn addTarget:self action:@selector(gotoRegisterVC:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)gotoForgotPwdVC:(UIButton *)sender
{
    ForgotPasswordViewController *forgotVC = [[ForgotPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgotVC animated:YES];
}

- (void)gotoRegisterVC:(UIButton *)sender
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)loginClick:(UIButton *)sender
{
    kAppDelegate.accessToken = @"token";
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    self.curButton.enabled = YES;
    self.curButton.backgroundColor = nil;
    [self.curButton setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateNormal];
    [self.curButton setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateHighlighted];
    for (UITextField *textField in self.curTextFields) {
        if (textField.text.length == 0) {
            self.curButton.enabled = NO;
            self.curButton.backgroundColor = HEXColor(0xbfccd5);
            [self.curButton setBackgroundImage:nil forState:UIControlStateNormal];
            [self.curButton setBackgroundImage:nil forState:UIControlStateHighlighted];
            break;
        }
    }
}

- (UITextField *)customTextFieldWithOffsetY:(CGFloat)offsetY
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, offsetY, SCREEN_WIDTH - 20, 44)];
    textField.backgroundColor = HEXColor(0xf3f6fb);
    textField.layer.cornerRadius = 44/2;
    textField.layer.masksToBounds = YES;
    textField.placeholder = @"请输入手机号";
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *innerShadowView = [[UIImageView alloc] initWithFrame:textField.bounds];
    
    innerShadowView.contentMode = UIViewContentModeScaleToFill;
    innerShadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [textField addSubview:innerShadowView];
    
    [innerShadowView.layer setCornerRadius:44/2];
    [innerShadowView.layer setMasksToBounds:YES];
    
    [innerShadowView.layer setBorderColor:HEXColor(0xdee3e9).CGColor];
    [innerShadowView.layer setShadowColor:HEXColor(0xdee3e9).CGColor];
    [innerShadowView.layer setBorderWidth:1.0f];
    
    [innerShadowView.layer setShadowOffset:CGSizeMake(0, 0)];
    [innerShadowView.layer setShadowOpacity:1.0];
    
    // this is the inner shadow thickness
    [innerShadowView.layer setShadowRadius:1.5];
    
    return textField;
}

- (UIButton *)customButtonWithOffsetY:(CGFloat)offsetY
{
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(10, offsetY, SCREEN_WIDTH-20, 44);
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 44/2;
    submitBtn.layer.masksToBounds = YES;
    // need customize when calling
    submitBtn.backgroundColor = HEXColor(0xbfccd5);
    submitBtn.enabled = NO;
    
    return submitBtn;
}

@end
