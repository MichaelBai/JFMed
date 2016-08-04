//
//  ForgotPasswordViewController.m
//  JFMed
//
//  Created by Michael on 7/29/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "LoginProgressView.h"

typedef NS_ENUM(NSInteger, ForgotPasswordProgress) {
    ForgotPasswordProgressPhoneNumber,
    ForgotPasswordProgressPhoneVerify,
    ForgotPasswordProgressNewPassword
};

@interface ForgotPasswordViewController ()

@property (nonatomic, strong) LoginProgressView *progressView;
@property (nonatomic, strong) UIView *actionView;
@property (nonatomic, strong) NSArray *curTextFields;
@property (nonatomic, strong) UIButton *curButton;
@property (nonatomic, strong) UIButton *manBtn;
@property (nonatomic, strong) UIButton *womanBtn;

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"找回密码";
    
    self.progressView = [[LoginProgressView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT + 50, SCREEN_WIDTH, 20) progressCount:3];
    [self.view addSubview:self.progressView];
    
    self.actionView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT + 130, SCREEN_WIDTH, 200)];
    [self.view addSubview:self.actionView];
    
    [self changeState:ForgotPasswordProgressPhoneNumber];
}

#pragma mark - actions

- (void)phoneNumberClick:(UIButton *)sender
{
    [self changeState:ForgotPasswordProgressPhoneVerify];
}

- (void)phoneVerifyClick:(UIButton *)sender
{
    [self changeState:ForgotPasswordProgressNewPassword];
}

- (void)passwordClick:(UIButton *)sender
{
    
}

- (void)changeState:(ForgotPasswordProgress)state
{
    [self.actionView removeAllSubViews];
    self.progressView.progressIndex = state;
    switch (state) {
        case ForgotPasswordProgressPhoneNumber:
        {
            UITextField *phoneNumberField = [self customTextFieldWithOffsetY:0];
            [self.actionView addSubview:phoneNumberField];
            UIButton *nextBtn = [self customButtonWithOffsetY:44 + 25];
            [self.actionView addSubview:nextBtn];
            [nextBtn setTitle:@"把验证码发给我" forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(phoneNumberClick:) forControlEvents:UIControlEventTouchUpInside];
            self.curButton = nextBtn;
            self.curTextFields = @[phoneNumberField];
        }
            break;
        case ForgotPasswordProgressPhoneVerify:
        {
            UITextField *phoneVerifyField = [self customTextFieldWithOffsetY:0];
            [self.actionView addSubview:phoneVerifyField];
            UIButton *nextBtn = [self customButtonWithOffsetY:44 + 25];
            [self.actionView addSubview:nextBtn];
            [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(phoneVerifyClick:) forControlEvents:UIControlEventTouchUpInside];
            self.curButton = nextBtn;
            self.curTextFields = @[phoneVerifyField];
        }
            break;
        case ForgotPasswordProgressNewPassword:
        {
            UITextField *pwdField = [self customTextFieldWithOffsetY:0];
            [self.actionView addSubview:pwdField];
            UITextField *pwdAgainField = [self customTextFieldWithOffsetY:44 + 25];
            [self.actionView addSubview:pwdAgainField];
            UIButton *nextBtn = [self customButtonWithOffsetY:(44 + 25) * 2];
            [self.actionView addSubview:nextBtn];
            [nextBtn setTitle:@"确 定" forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(passwordClick:) forControlEvents:UIControlEventTouchUpInside];
            self.curButton = nextBtn;
            self.curTextFields = @[pwdField, pwdAgainField];
        }
            break;
        default:
            break;
    }
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
