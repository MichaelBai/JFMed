//
//  AboutViewController.m
//  JFMed
//
//  Created by Michael on 8/6/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于";
    
    UIImageView *logo = [UIImageView new];
    [self.view addSubview:logo];
    logo.image = [UIImage imageNamed:@"LOGO"];
    
    UILabel *name = [UILabel new];
    [self.view addSubview:name];
    name.text = @"脊诊室  1.0.0";
    name.textColor = COLOR_TITLE;
    name.font = FONT_(16);
    
    UILabel *desc = [UILabel new];
    [self.view addSubview:desc];
    desc.numberOfLines = 0;
    desc.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
    NSString *descText = @"        脊诊室App:脊柱侧弯是指脊柱的一个或数个节段在冠状面上偏离身体中线向侧方弯曲，形成一个带有弧度的脊柱畸形，通常还伴有脊柱的旋转和矢状面上后突或前突的增加或减少，同时还有肋骨、骨盆的旋转倾斜畸形和椎旁的韧带和肌肉的异常，它是一种症状或X线征，可有多种疾病引起。";
    desc.attributedText = [CommonUtility getAttributedStringWithString:descText lineSpace:10 font:FONT_(15) alignment:NSTextAlignmentLeft];
    desc.textColor = COLOR_NAV;
    
    UIButton *service = [UIButton new];
    [self.view addSubview:service];
    [service setTitle:@"服务协议" forState:UIControlStateNormal];
    [service setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    service.titleLabel.font = FONT_(14);
    
    UIButton *policy = [UIButton new];
    [self.view addSubview:policy];
    [policy setTitle:@"隐私政策" forState:UIControlStateNormal];
    [policy setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    policy.titleLabel.font = FONT_(14);
    
    UILabel *copyrightZh = [UILabel new];
    [self.view addSubview:copyrightZh];
    copyrightZh.text = @"脊峰医疗    版权所有";
    copyrightZh.textColor = COLOR_NAV;
    copyrightZh.font = FONT_(14);
    
    UILabel *copyrightEn = [UILabel new];
    [self.view addSubview:copyrightEn];
    copyrightEn.text = @"Copyright C 2016 All Rights Reserved";
    copyrightEn.textColor = COLOR_NAV;
    copyrightEn.font = FONT_(13);
    
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@77);
        make.height.equalTo(@77);
        make.top.equalTo(@(NAV_HEIGHT + 25));
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logo.mas_bottom).offset(25);
        make.centerX.equalTo(@0);
    }];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(name.mas_bottom).offset(25);
        make.centerX.equalTo(@0);
    }];
    [copyrightEn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-25);
        make.centerX.equalTo(@0);
    }];
    [copyrightZh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(copyrightEn.mas_top).offset(-20);
        make.centerX.equalTo(@0);
    }];
    [service mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(copyrightZh.mas_top).offset(-18);
        make.centerX.equalTo(@-60);
    }];
    [policy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(copyrightZh.mas_top).offset(-18);
        make.centerX.equalTo(@60);
    }];
}

@end
