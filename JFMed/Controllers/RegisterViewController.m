//
//  RegisterViewController.m
//  JFMed
//
//  Created by Michael on 7/20/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginProgressView.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>


typedef NS_ENUM(NSInteger, RegisterProgress) {
    RegisterProgressPhoneNumber,
    RegisterProgressPhoneVerify,
    RegisterProgressPassword,
    RegisterProgressNickname,
    RegisterProgressSex,
    RegisterProgressBirthdate
};

@interface RegisterViewController () <TTTAttributedLabelDelegate, UITextFieldDelegate>

@property (nonatomic, strong) LoginProgressView *progressView;
@property (nonatomic, strong) UIView *actionView;
@property (nonatomic, strong) NSArray *curTextFields;
@property (nonatomic, strong) UIButton *curButton;
@property (nonatomic, strong) UIButton *manBtn;
@property (nonatomic, strong) UIButton *womanBtn;
@property (nonatomic, strong) UILabel *manLabel;
@property (nonatomic, strong) UILabel *womanLabel;
@property (nonatomic, strong) UITextField *birthdateField;

@property (nonatomic, assign) NSInteger timerCount;
@property (nonatomic, strong) UIButton *resendBtn;
@property (nonatomic, copy) NSString *phoneNumber;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"注册";
    
    self.progressView = [[LoginProgressView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT + 50, SCREEN_WIDTH, 20) progressCount:6];
    [self.view addSubview:self.progressView];
    
    self.actionView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT + 130, SCREEN_WIDTH, 200)];
    [self.view addSubview:self.actionView];
    
    [self changeState:RegisterProgressPhoneNumber];
}

#pragma mark - actions

- (void)phoneNumberClick:(UIButton *)sender
{
    UITextField *phoneNumberField = self.curTextFields[0];
    self.phoneNumber = phoneNumberField.text;
    [self changeState:RegisterProgressPhoneVerify];
}

- (void)phoneVerifyClick:(UIButton *)sender
{
    [self changeState:RegisterProgressPassword];
}

- (void)passwordClick:(UIButton *)sender
{
    [self changeState:RegisterProgressNickname];
}

- (void)nicknameClick:(UIButton *)sender
{
    [self changeState:RegisterProgressSex];
}

- (void)sexClick:(UIButton *)sender
{
    
    [self changeState:RegisterProgressBirthdate];
}

- (void)birthdateClick:(UIButton *)sender
{
    kAppDelegate.accessToken = @"token";
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)manBtnClick:(UIButton *)sender
{
    if (!sender.selected) {
        sender.selected = YES;
        self.womanBtn.selected = NO;
        self.manLabel.textColor = COLOR_THEME;
        self.womanLabel.textColor = COLOR_NAV;
    }
}

- (void)womanBtnClick:(UIButton *)sender
{
    if (!sender.selected) {
        sender.selected = YES;
        self.manBtn.selected = NO;
        self.manLabel.textColor = COLOR_NAV;
        self.womanLabel.textColor = COLOR_THEME;
    }
}

- (void)changeState:(RegisterProgress)state
{
    [self.actionView removeAllSubViews];
    self.progressView.progressIndex = state;
    switch (state) {
        case RegisterProgressPhoneNumber:
        {
            UITextField *phoneNumberField = [self customTextFieldWithOffsetY:0];
            phoneNumberField.keyboardType = UIKeyboardTypeNumberPad;
            [phoneNumberField becomeFirstResponder];
            [self.actionView addSubview:phoneNumberField];
            UIButton *nextBtn = [self customButtonWithOffsetY:44 + 25];
            [self.actionView addSubview:nextBtn];
            [nextBtn setTitle:@"注 册" forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(phoneNumberClick:) forControlEvents:UIControlEventTouchUpInside];
            self.curButton = nextBtn;
            self.curTextFields = @[phoneNumberField];
            [self setupAttributedLabel];
        }
            break;
        case RegisterProgressPhoneVerify:
        {
            self.title = @"手机验证码";
            UITextField *phoneVerifyField = [self customTextFieldWithOffsetY:0];
            phoneVerifyField.placeholder = @"请输入验证码";
            phoneVerifyField.width = SCREEN_WIDTH - 125 - 35;
            [self.actionView addSubview:phoneVerifyField];
            phoneVerifyField.keyboardType = UIKeyboardTypeNumberPad;
            [phoneVerifyField becomeFirstResponder];
            
            self.resendBtn = [self customButtonWithOffsetY:0];
            self.resendBtn.left = phoneVerifyField.right + 15;
            self.resendBtn.width = 125;
            [self.resendBtn addTarget:self action:@selector(resend:) forControlEvents:UIControlEventTouchUpInside];
            [self.actionView addSubview:self.resendBtn];
            
            self.timerCount = 60;
            self.resendBtn.enabled = NO;
            [self.resendBtn setTitle:@(self.timerCount).stringValue forState:UIControlStateNormal];
            [self.resendBtn setTitleColor:COLOR_NAV forState:UIControlStateNormal];
            self.resendBtn.backgroundColor = HEXColor(0xebeef5);
            self.resendBtn.layer.borderColor = HEXColor(0xdee3e9).CGColor;
            self.resendBtn.layer.borderWidth = 0.5;
            [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(fireTimer:)
                                           userInfo:nil
                                            repeats:YES];
            
            UIButton *nextBtn = [self customButtonWithOffsetY:44 + 25];
            [self.actionView addSubview:nextBtn];
            [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(phoneVerifyClick:) forControlEvents:UIControlEventTouchUpInside];
            self.curButton = nextBtn;
            self.curTextFields = @[phoneVerifyField];
        }
            break;
        case RegisterProgressPassword:
        {
            self.title = @"设定密码";
            UITextField *pwdField = [self customTextFieldWithOffsetY:0];
            pwdField.placeholder = @"设置密码，至少6位数";
            pwdField.keyboardType = UIKeyboardTypeAlphabet;
            pwdField.secureTextEntry = YES;
            [pwdField becomeFirstResponder];
            [self.actionView addSubview:pwdField];
            UITextField *pwdAgainField = [self customTextFieldWithOffsetY:44 + 25];
            pwdAgainField.placeholder = @"再次输入密码，以便确认正确";
            pwdAgainField.keyboardType = UIKeyboardTypeAlphabet;
            pwdAgainField.secureTextEntry = YES;
            [self.actionView addSubview:pwdAgainField];
            UIButton *nextBtn = [self customButtonWithOffsetY:(44 + 25) * 2];
            [self.actionView addSubview:nextBtn];
            [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(passwordClick:) forControlEvents:UIControlEventTouchUpInside];
            self.curButton = nextBtn;
            self.curTextFields = @[pwdField, pwdAgainField];
        }
            break;
        case RegisterProgressNickname:
        {
            self.title = @"昵称";
            UITextField *nicknameField = [self customTextFieldWithOffsetY:0];
            nicknameField.placeholder = @"请输入昵称";
            [nicknameField becomeFirstResponder];
            [self.actionView addSubview:nicknameField];
            UIButton *nextBtn = [self customButtonWithOffsetY:44 + 25];
            [self.actionView addSubview:nextBtn];
            [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(nicknameClick:) forControlEvents:UIControlEventTouchUpInside];
            self.curButton = nextBtn;
            self.curTextFields = @[nicknameField];
        }
            break;
        case RegisterProgressSex:
        {
            self.title = @"性别";
            self.manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.manBtn.frame = CGRectMake(SCREEN_WIDTH/2-35-56, 0, 56, 56);
            [self.manBtn setImage:[UIImage imageNamed:@"register_man"] forState:UIControlStateNormal];
            [self.manBtn setImage:[UIImage imageNamed:@"register_man_highlight"] forState:UIControlStateSelected];
            [self.manBtn addTarget:self action:@selector(manBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            self.manBtn.selected = YES;
            [self.actionView addSubview:self.manBtn];
            self.womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.womanBtn.frame = CGRectMake(SCREEN_WIDTH/2+35, 0, 56, 56);
            [self.womanBtn setImage:[UIImage imageNamed:@"register_woman"] forState:UIControlStateNormal];
            [self.womanBtn setImage:[UIImage imageNamed:@"register_woman_highlight"] forState:UIControlStateSelected];
            [self.womanBtn addTarget:self action:@selector(womanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.actionView addSubview:self.womanBtn];
            
            self.manLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-35-56, 56 + 15, 56, 17)];
            self.manLabel.text = @"男";
            self.manLabel.textColor = COLOR_THEME;
            self.manLabel.font = FONT_(16);
            self.manLabel.textAlignment = NSTextAlignmentCenter;
            [self.actionView addSubview:self.manLabel];
            
            self.womanLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+35, 56 + 15, 56, 17)];
            self.womanLabel.text = @"女";
            self.womanLabel.textColor = COLOR_NAV;
            self.womanLabel.font = FONT_(16);
            self.womanLabel.textAlignment = NSTextAlignmentCenter;
            [self.actionView addSubview:self.womanLabel];
            
            // check self.manBtn.selected or womanBtn.selected
            UIButton *nextBtn = [self customButtonWithOffsetY:56 + 70];
            [self.actionView addSubview:nextBtn];
            [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
            nextBtn.enabled = YES;
            nextBtn.backgroundColor = COLOR_THEME;
            self.curButton = nextBtn;
            self.curTextFields = nil;
        }
            break;
        case RegisterProgressBirthdate:
        {
            self.title = @"出生年月";
            self.birthdateField = [self customTextFieldWithOffsetY:0];
            self.birthdateField.placeholder = @"点击选择出生年月";
            self.birthdateField.delegate = self;
            self.birthdateField.inputView = [self setupDatePicker];
            [self.actionView addSubview:self.birthdateField];
            UIButton *nextBtn = [self customButtonWithOffsetY:44 + 25];
            [self.actionView addSubview:nextBtn];
            [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
            [nextBtn addTarget:self action:@selector(birthdateClick:) forControlEvents:UIControlEventTouchUpInside];
            self.curButton = nextBtn;
            self.curTextFields = @[self.birthdateField];
        }
            break;
        default:
            break;
    }
}

- (UIDatePicker *)setupDatePicker
{
    // alloc/init your date picker, and (optional) set its initial date
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//    [datePicker setDate:[NSDate date]]; //this returns today's date
    
    // theMinimumDate (which signifies the oldest a person can be) and theMaximumDate (defines the youngest a person can be) are the dates you need to define according to your requirements, declare them:
    
    // the date string for the minimum age required (change according to your needs)
//    NSString *maxDateString = @"01-Jan-1900";
    // the date formatter used to convert string to date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // the specific format to use
    dateFormatter.dateFormat = @"dd-MMM-yyyy";
    // converting string to date
    NSDate *theMaximumDate = [NSDate date];//[dateFormatter dateFromString:maxDateString];
    
    NSString *minDateString = @"01-Jan-1900";
    NSDate *theMinimumDate = [dateFormatter dateFromString:minDateString];
    
    // repeat the same logic for theMinimumDate if needed
    
    // here you can assign the max and min dates to your datePicker
    [datePicker setMaximumDate:theMaximumDate]; //the min age restriction
    [datePicker setMinimumDate:theMinimumDate]; //the max age restriction (if needed, or else dont use this line)
    
    // set the mode
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // update the textfield with the date everytime it changes with selector defined below
    [datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    return datePicker;
}

- (void)datePickerChanged:(UIDatePicker *)sender
{
    self.birthdateField.text = [self formatDate:sender.date];
    self.curButton.enabled = YES;
    self.curButton.backgroundColor = nil;
    [self.curButton setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateNormal];
    [self.curButton setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateHighlighted];
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
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

- (void)setupAttributedLabel
{
    TTTAttributedLabel *tttLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(22, self.curButton.bottom + 25, SCREEN_WIDTH - 22 - 10, 0)];
    [self.actionView addSubview:tttLabel];
    
    tttLabel.font = FONT_(14);
    tttLabel.textColor = COLOR_TITLE;
    tttLabel.numberOfLines = 0;
    tttLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSString *tttText = @"点击上面的注册按钮即同意服务协议和隐私政策";
    [tttLabel setText:tttText afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    tttLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink; // Automatically detect links when the label text is subsequently changed
    tttLabel.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
    
    tttLabel.linkAttributes = @{(id)kCTForegroundColorAttributeName:COLOR_THEME};
    tttLabel.activeLinkAttributes = nil;
    
    // Embedding a custom link in a substring
    NSRange serviceRange = [tttText rangeOfString:@"服务协议" options:NSCaseInsensitiveSearch];
    NSRange policyRange = [tttText rangeOfString:@"隐私政策" options:NSCaseInsensitiveSearch];
    [tttLabel addLinkToURL:[NSURL URLWithString:@"help://gotoService/"] withRange:serviceRange];
    [tttLabel addLinkToURL:[NSURL URLWithString:@"help://gotoPolicy/"] withRange:policyRange];
    
    CGFloat height = [tttText boundingRectWithFont:FONT_(14) andSize:CGSizeMake(tttLabel.width, CGFLOAT_MAX)].height;
    tttLabel.height = height;
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    if ([url.scheme isEqualToString:@"help"]) {
        if ([url.host isEqualToString:@"gotoService"]) {
            NSLog(@"gotoService");
        } else if ([url.host isEqualToString:@"gotoPolicy"]) {
            NSLog(@"gotoPolicy");
        }
    }
}

#pragma mark - timer

- (void)fireTimer:(NSTimer *)timer
{
    self.timerCount--;
    if (self.timerCount < 0) {
        [timer invalidate];
        timer = nil;
        
        self.resendBtn.enabled = YES;
        [self.resendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.resendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.resendBtn.layer.borderWidth = 0;
        self.resendBtn.backgroundColor = nil;
        [self.resendBtn setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateNormal];
        [self.resendBtn setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateHighlighted];
    } else {
        self.resendBtn.enabled = NO;
        [self.resendBtn setTitle:@(self.timerCount).stringValue forState:UIControlStateNormal];
        [self.resendBtn setTitleColor:COLOR_NAV forState:UIControlStateNormal];
        self.resendBtn.backgroundColor = HEXColor(0xebeef5);
        self.resendBtn.layer.borderColor = HEXColor(0xdee3e9).CGColor;
        self.resendBtn.layer.borderWidth = 0.5;
        
    }
}

@end
