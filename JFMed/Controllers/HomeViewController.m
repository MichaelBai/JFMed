//
//  HomeViewController.m
//  JFMed
//
//  Created by Michael on 7/20/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsTableViewCell.h"
#import "NewsViewController.h"
#import "DoctorsViewController.h"
#import "MessageListViewController.h"
#import "PersonalViewController.h"
#import "DoctorProfileViewController.h"
#import "HomeModel.h"

#warning test
#import "SelfCheckViewController.h"
#import "SelfCheckIntroViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UIImageView *banner;

@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *docTitle;
@property (nonatomic, strong) NSMutableArray *banners;
@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) NSMutableArray *docArray;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [kAppDelegate showLogin];
    self.title = @"脊诊室";
    
    [self addLeftBarButtonWithTitle:nil image:[UIImage imageNamed:@"notif"] backgroundImage:nil action:@selector(gotoMessageVC)];
    [self addRightBarButtonWithTitle:nil image:[UIImage imageNamed:@"person"] backgroundImage:nil action:@selector(gotoPersonalVC)];
    
#warning test
//    [[NetworkCenter sharedCenter] uploadImage:[UIImage imageNamed:@"docHead"] completionHandler:nil];
    
    [self addRightBarButtonWithTitle:@"自查" image:nil backgroundImage:nil action:@selector(gotoCheck)];
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
    
    [NETWORK postWithApiPath:@"home/data" requestParams:nil handler:^(id response, NSError *error, BOOL updatePage) {
        
        self.newsTitle = response[@"news"][@"title"];
        self.docTitle = response[@"doctor"][@"title"];
        
        self.banners = [NSMutableArray array];
        self.newsArray = [NSMutableArray array];
        self.docArray = [NSMutableArray array];
        [response[@"banner"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HomeBanner *banner = [[HomeBanner alloc] initWithDictionary:obj error:nil];
            [self.banners addObject:banner];
        }];
        
        [response[@"news"][@"news_list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HomeNews *news = [[HomeNews alloc] initWithDictionary:obj error:nil];
            [self.newsArray addObject:news];
        }];
        
        [response[@"doctor"][@"doctor_list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HomeDoctor *doc = [[HomeDoctor alloc] initWithDictionary:obj error:nil];
            [self.docArray addObject:doc];
        }];
        
        [self setupScrollView];
    }];
}

- (void)setupScrollView
{
    CGFloat offsetY = 0;
    
    UIScrollView *bannerScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 150)];
    bannerScroll.pagingEnabled = YES;
    bannerScroll.contentSize = CGSizeMake(SCREEN_WIDTH*self.banners.count, 150);
    [_scrollView addSubview:bannerScroll];
    
    for (int i = 0; i < self.banners.count; i++) {
        UIImageView *banner = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, 150)];
        HomeBanner *homeBanner = self.banners[i];
        [banner sd_setImageWithURL:[NSURL URLWithString:homeBanner.img] placeholderImage:[UIImage imageNamed:@"banner"]];
        [bannerScroll addSubview:banner];
    }
    
    offsetY += 150;
    
    UIView *moreNews = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 40)];
    [_scrollView addSubview:moreNews];
    [moreNews addTapAction:@selector(gotoNewsVC) target:self];
    
    UIImageView *newsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 13, 16)];
    newsIcon.image = [UIImage imageNamed:@"newsIcon"];
    [moreNews addSubview:newsIcon];
    
    UILabel *moreNewsLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 100, 40)];
    moreNewsLabel.text = self.newsTitle;
    moreNewsLabel.textColor = COLOR_TITLE;
    moreNewsLabel.font = FONT_(16);
    [moreNews addSubview:moreNewsLabel];
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 10, 12.5, 10, 15)];
    arrow.image = [UIImage imageNamed:@"arrow"];
    [moreNews addSubview:arrow];
    
    UIView *moreNewsLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    moreNewsLineView.backgroundColor = COLOR_LINE;
    [moreNews addSubview:moreNewsLineView];
    
    offsetY += 40;
    
    CGFloat tableViewHeight = [NewsTableViewCell CellHeight]*self.newsArray.count;
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
    
    UIImageView *docIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 17, 21)];
    docIcon.image = [UIImage imageNamed:@"docIcon"];
    [moreDoctors addSubview:docIcon];
    
    UILabel *moreDoctorsLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 100, 40)];
    moreDoctorsLabel.text = self.docTitle;
    moreDoctorsLabel.textColor = COLOR_TITLE;
    moreDoctorsLabel.font = FONT_(16);
    [moreDoctors addSubview:moreDoctorsLabel];
    
    UIImageView *arrow2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 10, 12.5, 10, 15)];
    arrow2.image = [UIImage imageNamed:@"arrow"];
    [moreDoctors addSubview:arrow2];
    
    UIView *moreDoctorsLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    moreDoctorsLineView.backgroundColor = COLOR_LINE;
    [moreDoctors addSubview:moreDoctorsLineView];
    
    offsetY += 40;
    
    UIView *doctorsView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 118)];
    [_scrollView addSubview:doctorsView];
    
    CGFloat leftOffset = 10;
    for (int i = 0; i < 3; i++) {
        HomeDoctor *homeDoc = self.docArray[i];
        CGFloat singleDoctorViewWidth = (SCREEN_WIDTH-20)/3;
        UIView *singleDoctorView = [[UIView alloc] initWithFrame:CGRectMake(leftOffset, 0, singleDoctorViewWidth, 118)];
        [doctorsView addSubview:singleDoctorView];
        [singleDoctorView addTapAction:@selector(gotoDoctorProfileVC) target:self];
        UIImageView *doctorImage = [[UIImageView alloc] initWithFrame:CGRectMake((singleDoctorViewWidth-55)/2, 12, 55, 55)];
        doctorImage.layer.cornerRadius = 55.0/2;
        doctorImage.layer.masksToBounds = YES;
        [doctorImage sd_setImageWithURL:[NSURL URLWithString:homeDoc.avatar] placeholderImage:[UIImage imageNamed:@"docHead"]];
        doctorImage.contentMode = UIViewContentModeScaleAspectFill;
        [singleDoctorView addSubview:doctorImage];
        UILabel *doctorName = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, singleDoctorViewWidth, 15)];
        doctorName.text = [NSString stringWithFormat:@"%@ %@", homeDoc.name, homeDoc.title];
        doctorName.textColor = HEXColor(0x222222);
        doctorName.font = FONT_(12);
        doctorName.textAlignment = NSTextAlignmentCenter;
        [singleDoctorView addSubview:doctorName];
        UILabel *hospitalName = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, singleDoctorViewWidth, 13)];
        hospitalName.text = homeDoc.hospital;
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
//    if (!kAppDelegate.accessToken) {
//        [kAppDelegate showLogin];
//        return;
//    }
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
    SelfCheckIntroViewController *selfCheckVC = [[SelfCheckIntroViewController alloc] init];
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
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell setDataWithNews:self.newsArray[indexPath.row]];
    return cell;
}

@end
