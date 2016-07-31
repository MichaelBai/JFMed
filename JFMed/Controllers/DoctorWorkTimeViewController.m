//
//  DoctorWorkTimeViewController.m
//  JFMed
//
//  Created by Michael on 7/30/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "DoctorWorkTimeViewController.h"

@interface DoctorWorkTimeViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DoctorWorkTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"出诊时间";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    [self setupScrollView];
}

- (void)setupScrollView
{
    UILabel *amLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 77, 44, 38)];
    [_scrollView addSubview:amLabel];
    amLabel.text = @"上午";
    amLabel.textColor = COLOR_NAV;
    amLabel.font = FONT_(16);
    
    UILabel *pmLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 116, 44, 38)];
    [_scrollView addSubview:pmLabel];
    pmLabel.text = @"下午";
    pmLabel.textColor = COLOR_NAV;
    pmLabel.font = FONT_(16);
    
    NSArray *weekdayNames = @[@"周一", @"周二", @"周三", @"周四", @"周五"];
    CGFloat AMPMLabelOffsetX = 54;
    CGFloat weekdayWidth = (SCREEN_WIDTH - AMPMLabelOffsetX - 20)/5;
    for (int i = 0; i < 5; i++) {
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(AMPMLabelOffsetX + weekdayWidth * i, 0, weekdayWidth, 66)];
        [_scrollView addSubview:weekdayLabel];
        weekdayLabel.textColor = COLOR_NAV;
        weekdayLabel.font = FONT_(16);
        weekdayLabel.text = weekdayNames[i];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        
        UIView *weekdayAMView = [[UIView alloc] initWithFrame:CGRectMake(AMPMLabelOffsetX + weekdayWidth * i, 66, weekdayWidth+1, 38)];
        weekdayAMView.layer.borderColor = HEXColor(0xcfd2d9).CGColor;
        weekdayAMView.layer.borderWidth = 1;
        weekdayAMView.backgroundColor = i % 2 == 0 ? COLOR_BACKGROUND : [UIColor whiteColor];
        [_scrollView addSubview:weekdayAMView];
        
        UIView *weekdayPMView = [[UIView alloc] initWithFrame:CGRectMake(AMPMLabelOffsetX + weekdayWidth * i, 103, weekdayWidth+1, 38)];
        weekdayPMView.layer.borderColor = HEXColor(0xcfd2d9).CGColor;
        weekdayPMView.layer.borderWidth = 1;
        weekdayPMView.backgroundColor = i % 2 ? COLOR_BACKGROUND : [UIColor whiteColor];
        [_scrollView addSubview:weekdayPMView];
    }
    
    UIView *workTime = [[UIView alloc] initWithFrame:CGRectMake(10, 175, SCREEN_WIDTH - 20, 0)];
    [_scrollView addSubview:workTime];
    workTime.layer.cornerRadius = 3;
    workTime.layer.masksToBounds = YES;
    workTime.backgroundColor = COLOR_BACKGROUND;
    
    UILabel *workIndicator = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 100, 16)];
    [workTime addSubview:workIndicator];
    workIndicator.text = @"坐诊时间：";
    workIndicator.textColor = COLOR_NAV;
    workIndicator.font = FONT_(15);
    
    UILabel *workDuringTime = [[UILabel alloc] initWithFrame:CGRectMake(40, 46, SCREEN_WIDTH - 20 - 40 - 20, 16)];
    [workTime addSubview:workDuringTime];
    workDuringTime.text = @"坐诊时间：";
    workDuringTime.textColor = COLOR_NAV;
    workDuringTime.font = FONT_(15);
    
    // TODO: 算出workDuringTime的多行的高度，重新计算workTip的frame和workTime的frame
    UILabel *workTip = [[UILabel alloc] initWithFrame:CGRectMake(40, 75, SCREEN_WIDTH - 20 - 40 - 20, 16)];
    [workTime addSubview:workTip];
    workTip.text = @"坐诊时间：";
    workTip.textColor = COLOR_NAV;
    workTip.font = FONT_(15);
    
    workTime.frame = CGRectMake(10, 175, SCREEN_WIDTH - 20, 106);
}

@end
