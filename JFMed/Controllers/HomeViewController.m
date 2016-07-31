//
//  HomeViewController.m
//  JFMed
//
//  Created by Michael on 7/20/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "HomeViewController.h"
#import "SelfCheckViewController.h"
#import "NewsTableViewCell.h"
#import "NewsViewController.h"
#import "DoctorsViewController.h"
#import "MessageListViewController.h"
#import "PersonalViewController.h"
#import "DoctorProfileViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *banner;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [kAppDelegate showLogin];
    self.title = @"脊诊室";
    
    [self addLeftBarButtonWithTitle:@"通知" image:nil backgroundImage:nil action:@selector(gotoMessageVC)];
    [self addRightBarButtonWithTitle:@"我的" image:nil backgroundImage:nil action:@selector(gotoPersonalVC)];
    
//    UIButton *checkBtn = [UIButton new];
//    [checkBtn setTitle:@"脊柱自查" forState:UIControlStateNormal];
//    [checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [checkBtn addTarget:self action:@selector(gotoCheck) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:checkBtn];
//    
//    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(@0);
//    }];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    [self setupScrollView];
}

- (void)setupScrollView
{
    CGFloat offsetY = 0;
    _banner = [[UIImageView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 150)];
    [_banner sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"banner"]];
    [_scrollView addSubview:_banner];
    
    offsetY += 150;
    
    UIView *moreNews = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 40)];
    [_scrollView addSubview:moreNews];
    [moreNews addTapAction:@selector(gotoNewsVC) target:self];
    
    UILabel *moreNewsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    moreNewsLabel.text = @"更多资讯";
    moreNewsLabel.textColor = COLOR_TITLE;
    moreNewsLabel.font = FONT_(14);
    [moreNews addSubview:moreNewsLabel];
    
    UIView *moreNewsLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    moreNewsLineView.backgroundColor = COLOR_LINE;
    [moreNews addSubview:moreNewsLineView];
    
    offsetY += 40;
    
    CGFloat tableViewHeight = [NewsTableViewCell CellHeight]*3;
    UITableView *newsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, tableViewHeight)];
    newsTable.delegate = self;
    newsTable.dataSource = self;
    newsTable.bounces = NO;
    newsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:newsTable];
    
    offsetY += tableViewHeight;
    
    UIView *moreDoctors = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 40)];
    [_scrollView addSubview:moreDoctors];
    [moreDoctors addTapAction:@selector(gotoDoctorsVC) target:self];
    
    UILabel *moreDoctorsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    moreDoctorsLabel.text = @"更多医生";
    moreDoctorsLabel.textColor = COLOR_TITLE;
    moreDoctorsLabel.font = FONT_(14);
    [moreDoctors addSubview:moreDoctorsLabel];
    
    UIView *moreDoctorsLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    moreDoctorsLineView.backgroundColor = COLOR_LINE;
    [moreDoctors addSubview:moreDoctorsLineView];
    
    offsetY += 40;
    
    UIView *doctorsView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 118)];
    [_scrollView addSubview:doctorsView];
    
    CGFloat leftOffset = 10;
    for (int i = 0; i < 3; i++) {
        CGFloat singleDoctorViewWidth = (SCREEN_WIDTH-20)/3;
        UIView *singleDoctorView = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, 0, singleDoctorViewWidth, 118)];
        [doctorsView addSubview:singleDoctorView];
        [singleDoctorView addTapAction:@selector(gotoDoctorProfileVC) target:self];
        UIImageView *doctorImage = [[UIImageView alloc] initWithFrame:CGRectMake((singleDoctorViewWidth-55)/2, 12, 55, 55)];
        [doctorImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"docHead"]];
        [singleDoctorView addSubview:doctorImage];
        UILabel *doctorName = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, singleDoctorViewWidth, 15)];
        doctorName.text = @"赵一铭 主任医师";
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
    
    offsetY += 118;
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, offsetY);
}

- (void)gotoMessageVC
{
    MessageListViewController *messageVC = [[MessageListViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)gotoPersonalVC
{
//    [kAppDelegate showLogin];
    PersonalViewController *personalVC = [[PersonalViewController alloc] init];
    [self.navigationController pushViewController:personalVC animated:YES];
}

- (void)gotoNewsVC
{
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    [self.navigationController pushViewController:newsVC animated:YES];
}

- (void)gotoDoctorsVC
{
    DoctorsViewController *doctorsVC = [[DoctorsViewController alloc] init];
    [self.navigationController pushViewController:doctorsVC animated:YES];
}

- (void)gotoCheck
{
    SelfCheckViewController *selfCheckVC = [[SelfCheckViewController alloc] init];
    [self.navigationController pushViewController:selfCheckVC animated:YES];
}

- (void)gotoDoctorProfileVC
{
    DoctorProfileViewController *docProfileVC = [[DoctorProfileViewController alloc] init];
    [self.navigationController pushViewController:docProfileVC animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NewsTableViewCell CellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell setData];
    return cell;
}

@end
