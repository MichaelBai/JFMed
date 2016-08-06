//
//  SelfCheckResultViewController.m
//  JFMed
//
//  Created by Michael on 8/5/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "SelfCheckResultViewController.h"
#import "DoctorProfileViewController.h"

@interface SelfCheckResultViewController ()

@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, strong) UIView *resultView;

@end

@implementation SelfCheckResultViewController

- (instancetype)initWithAngle:(CGFloat)angle
{
    self = [super init];
    if (self) {
        _angle = angle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"脊柱自查";
    
    CGFloat offsetY = NAV_HEIGHT + 10;
    self.resultView = [[UIView alloc] initWithFrame:CGRectMake(10, offsetY, SCREEN_WIDTH-20, 0)];
    [self.view addSubview:self.resultView];
    self.resultView.layer.cornerRadius = 5;
    self.resultView.layer.masksToBounds = YES;
    self.resultView.backgroundColor = COLOR_BACKGROUND;
    
    UILabel *cobb = [[UILabel alloc] initWithFrame:CGRectMake(0, 58, 200, 20)];
    cobb.text = @"Cobb角约";
    cobb.textColor = COLOR_TITLE;
    cobb.font = FONT_(18);
    cobb.textAlignment = NSTextAlignmentRight;
    [self.resultView addSubview:cobb];
    
    UILabel *cobbDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, 92, 200, 20)];
    // TODO: adjust text
    cobbDesc.text = @"比较轻微的脊柱侧弯";
    cobbDesc.textColor = COLOR_TITLE;
    cobbDesc.font = FONT_(18);
    cobbDesc.textAlignment = NSTextAlignmentRight;
    [self.resultView addSubview:cobbDesc];
    
    UILabel *cobbAngle = [[UILabel alloc] initWithFrame:CGRectMake(200+15, 50, 100, 65)];
    cobbAngle.text = @"18°";
    cobbAngle.textColor = HEXColor(0xf6473c);
    cobbAngle.font = FONT_(62);
    [self.resultView addSubview:cobbAngle];
    
    UIImageView *introIcon = [[UIImageView alloc] initWithFrame:CGRectMake(16, 162, 14, 14)];
    [self.resultView addSubview:introIcon];
    introIcon.image = [UIImage imageNamed:@"about"];
    
    NSString *introStr = @"      Cobb角是用来测试脊柱侧弯弯度的指标，Cobb角越大，说明越严重。超过20度需要用支具来矫正治疗，超过40度则需要用手术治疗。";
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 160, SCREEN_WIDTH-20-32, 0)];
    [self.resultView addSubview:introLabel];
    introLabel.numberOfLines = 0;
    introLabel.textColor = COLOR_NAV;
    introLabel.attributedText = [CommonUtility getAttributedStringWithString:introStr lineSpace:10 font:FONT_(15) alignment:NSTextAlignmentLeft];
    CGFloat height = [introStr boundingRectWithFont:FONT_(15) lineSpacing:10 andSize:CGSizeMake(SCREEN_WIDTH-20-32, CGFLOAT_MAX)].height;
    introLabel.height = height;
    
    self.resultView.height += 160 + height + 15;
    
    offsetY += self.resultView.height;
    
    offsetY += 25;
    
    UILabel *docLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, offsetY, 280, 17)];
    docLabel.text = @"联系医生详细咨询：";
    docLabel.textColor = COLOR_NAV;
    docLabel.font = FONT_(16);
    [self.view addSubview:docLabel];
    
    offsetY += 25;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = COLOR_LINE;
    [self.view addSubview:lineView];
    
    offsetY += 10;
    
    UIView *doctorsView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 118)];
    [self.view addSubview:doctorsView];
    
    CGFloat leftOffset = 10;
    for (int i = 0; i < 3; i++) {
//        HomeDoctor *homeDoc = self.docArray[i];
        CGFloat singleDoctorViewWidth = (SCREEN_WIDTH-20)/3;
        UIView *singleDoctorView = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, 0, singleDoctorViewWidth, 118)];
        [doctorsView addSubview:singleDoctorView];
        [singleDoctorView addTapAction:@selector(gotoDoctorProfileVC) target:self];
        UIImageView *doctorImage = [[UIImageView alloc] initWithFrame:CGRectMake((singleDoctorViewWidth-55)/2, 12, 55, 55)];
        doctorImage.layer.cornerRadius = 55.0/2;
        doctorImage.layer.masksToBounds = YES;
        [doctorImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"docHead"]];
        doctorImage.contentMode = UIViewContentModeScaleAspectFill;
        [singleDoctorView addSubview:doctorImage];
        UILabel *doctorName = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, singleDoctorViewWidth, 15)];
        doctorName.text = [NSString stringWithFormat:@"%@ %@", @"赵一铭", @"主任医师"];
        doctorName.textColor = HEXColor(0x222222);
        doctorName.font = FONT_(12);
        doctorName.textAlignment = NSTextAlignmentCenter;
        [singleDoctorView addSubview:doctorName];
        UILabel *hospitalName = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, singleDoctorViewWidth, 13)];
        hospitalName.text = @"北京协和医院";
        hospitalName.textColor = HEXColor(0x999999);
        hospitalName.font = FONT_(12);
        hospitalName.textAlignment = NSTextAlignmentCenter;
        [singleDoctorView addSubview:hospitalName];
        
        leftOffset += singleDoctorViewWidth;
    }
}

- (void)gotoDoctorProfileVC
{
    DoctorProfileViewController *docProfileVC = [[DoctorProfileViewController alloc] init];
    [self.navigationController pushViewController:docProfileVC animated:YES];
}

@end
