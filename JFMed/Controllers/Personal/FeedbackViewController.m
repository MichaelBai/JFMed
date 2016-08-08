//
//  FeedbackViewController.m
//  JFMed
//
//  Created by Michael on 8/6/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *feedbackView;
@property (nonatomic, strong) UILabel *placeholder;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"意见反馈";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, NAV_HEIGHT + 10, SCREEN_WIDTH - 20, 175)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = HEXColor(0xf3f6fb);
    bgView.layer.borderColor = HEXColor(0xdee3e9).CGColor;
    bgView.layer.borderWidth = 1;
    bgView.layer.cornerRadius = 20;
    bgView.layer.masksToBounds = YES;
    
    self.feedbackView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, bgView.width - 20, 155)];
    [bgView addSubview:self.feedbackView];
    self.feedbackView.backgroundColor = HEXColor(0xf3f6fb);
    self.feedbackView.font = FONT_(16);
    self.feedbackView.textColor = COLOR_TITLE;
    self.feedbackView.delegate = self;

    self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(10 + 15, NAV_HEIGHT + 10 + 15, SCREEN_WIDTH - (10 + 15) * 2, 0)];
    self.placeholder.text = @"请写下您的意见，我们将精益求精为患者提供更好的服务。";
    self.placeholder.textColor = COLOR_NAV;
    self.placeholder.font = FONT_(16);
    self.placeholder.numberOfLines = 0;
    [self.placeholder sizeToFit];
    [self.view addSubview:self.placeholder];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(10, bgView.bottom + 15, SCREEN_WIDTH-20, 44);
    [submitBtn setTitle:@"提 交 意 见" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}

- (void)submit:(UIButton *)sender
{
    NSLog(@"%@", self.feedbackView.text);
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.placeholder.hidden = YES;
    return YES;
}

@end
