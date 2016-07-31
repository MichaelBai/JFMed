//
//  DoctorProfileViewController.m
//  JFMed
//
//  Created by Michael on 7/30/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "DoctorProfileViewController.h"
#import "DoctorInfoViewController.h"
#import "DoctorWorkTimeViewController.h"

@interface DoctorProfileViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DoctorProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"医生";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 45)];
    [self.view addSubview:_scrollView];
    [self setupScrollView];
    [self setupFooterView];
}

- (void)setupScrollView
{
    CGFloat offsetY = 0;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 252)];
    headerView.backgroundColor = COLOR_NAV;
    [_scrollView addSubview:headerView];
    
    UIImageView *docHead = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-65)/2, 15, 65, 65)];
    [docHead sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"docHead"]];
    [headerView addSubview:docHead];
    
    UILabel *hospitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 94, SCREEN_WIDTH - 20, 16)];
    hospitalLabel.text = @"北京协和医院";
    hospitalLabel.textColor = [UIColor whiteColor];
    hospitalLabel.font = FONT_(15);
    hospitalLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:hospitalLabel];
    
    UILabel *levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 117, SCREEN_WIDTH - 20, 16)];
    levelLabel.text = @"主任医师";
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.font = FONT_(15);
    levelLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:levelLabel];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 147.5, SCREEN_WIDTH, 0.5)];
    lineView1.backgroundColor = HEXColor(0x636e84);
    [headerView addSubview:lineView1];
    
    UILabel *focusPeople = [[UILabel alloc] initWithFrame:CGRectMake(0, 162, SCREEN_WIDTH/3, 14)];
    focusPeople.text = @"13人";
    focusPeople.textColor = HEXColor(0xadb8cc);
    focusPeople.font = FONT_(13);
    focusPeople.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:focusPeople];
    
    UILabel *consultTime = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 162, SCREEN_WIDTH/3, 14)];
    consultTime.text = @"134次";
    consultTime.textColor = HEXColor(0xadb8cc);
    consultTime.font = FONT_(13);
    consultTime.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:consultTime];
    
    UILabel *papers = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2/3, 162, SCREEN_WIDTH/3, 14)];
    papers.text = @"15篇";
    papers.textColor = HEXColor(0xadb8cc);
    papers.font = FONT_(13);
    papers.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:papers];
    
    UILabel *focusPeopleIndicator = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH/3, 14)];
    focusPeopleIndicator.text = @"关注";
    focusPeopleIndicator.textColor = HEXColor(0xadb8cc);
    focusPeopleIndicator.font = FONT_(13);
    focusPeopleIndicator.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:focusPeopleIndicator];
    
    UILabel *consultTimeIndicator = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 180, SCREEN_WIDTH/3, 14)];
    consultTimeIndicator.text = @"咨询";
    consultTimeIndicator.textColor = HEXColor(0xadb8cc);
    consultTimeIndicator.font = FONT_(13);
    consultTimeIndicator.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:consultTimeIndicator];
    
    UILabel *papersIndicator = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2/3, 180, SCREEN_WIDTH/3, 14)];
    papersIndicator.text = @"文章";
    papersIndicator.textColor = HEXColor(0xadb8cc);
    papersIndicator.font = FONT_(13);
    papersIndicator.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:papersIndicator];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 207.5, SCREEN_WIDTH, 0.5)];
    lineView2.backgroundColor = HEXColor(0x636e84);
    [headerView addSubview:lineView2];
    
    UIButton *doctorInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doctorInfoBtn.frame = CGRectMake(0, 208, SCREEN_WIDTH/2, 44);
    [doctorInfoBtn setTitle:@"医生介绍" forState:UIControlStateNormal];
    [doctorInfoBtn setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    doctorInfoBtn.titleLabel.font = FONT_(15);
    [doctorInfoBtn addTarget:self action:@selector(gotoDocInfoVC) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:doctorInfoBtn];
    
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 208 + 15, 0.5, 14)];
    sepView.backgroundColor = HEXColor(0xadb8cc);
    [headerView addSubview:sepView];
    
    UIButton *docWorkTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    docWorkTimeBtn.frame = CGRectMake(SCREEN_WIDTH/2, 208, SCREEN_WIDTH/2, 44);
    [docWorkTimeBtn setTitle:@"出诊时间" forState:UIControlStateNormal];
    [docWorkTimeBtn setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    docWorkTimeBtn.titleLabel.font = FONT_(15);
    [docWorkTimeBtn addTarget:self action:@selector(gotoDocWorkTimeVC) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:docWorkTimeBtn];
    
    offsetY += 252;
    
    UIView *moreNews = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 41)];
    [_scrollView addSubview:moreNews];
    
    UILabel *moreNewsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 41)];
    moreNewsLabel.text = @"相关文章";
    moreNewsLabel.textColor = COLOR_NAV;
    moreNewsLabel.font = FONT_(16);
    [moreNews addSubview:moreNewsLabel];
    
    UIView *moreNewsLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40.5, SCREEN_WIDTH, 0.5)];
    moreNewsLineView.backgroundColor = HEXColor(0xe7eaf3);
    [moreNews addSubview:moreNewsLineView];
    
    offsetY += 41;
    
    NSInteger articleCount = 3;
    UIView *relatedArticles = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, articleCount * 68)];
    [headerView addSubview:relatedArticles];
    
    for (int i = 0; i < articleCount; i++) {
        UIView *article = [[UIView alloc] initWithFrame:CGRectMake(0, 68*i, SCREEN_WIDTH, 68)];
        [relatedArticles addSubview:article];
        
        UILabel *articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 68)];
        [article addSubview:articleLabel];
        
        articleLabel.text = @"脊柱侧弯是怎么样一种病？是怎么引起的？为什么青少年多发？";
        articleLabel.textColor = COLOR_TITLE;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 67.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = HEXColor(0xe7eaf3);
        [article addSubview:lineView];
    }
    
    offsetY += articleCount * 68;
    
    UIView *morePapers = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, 41)];
    [_scrollView addSubview:morePapers];
    
    UILabel *moreDoctorsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 41)];
    moreDoctorsLabel.text = @"发表论文";
    moreDoctorsLabel.textColor = COLOR_NAV;
    moreDoctorsLabel.font = FONT_(16);
    [morePapers addSubview:moreDoctorsLabel];
    
    UIView *moreDoctorsLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40.5, SCREEN_WIDTH, 0.5)];
    moreDoctorsLineView.backgroundColor = HEXColor(0xe7eaf3);
    [morePapers addSubview:moreDoctorsLineView];
    
    offsetY += 41;
    
    NSInteger paperCount = 2;
    UIView *relatedPapers = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, SCREEN_WIDTH, paperCount * 95)];
    [headerView addSubview:relatedPapers];
    
    for (int i = 0; i < paperCount; i++) {
        UIView *paper = [[UIView alloc] initWithFrame:CGRectMake(0, 95*i, SCREEN_WIDTH, 95)];
        [relatedPapers addSubview:paper];
        
        UILabel *paperLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 14, SCREEN_WIDTH - 20, 40)];
        [paper addSubview:paperLabel];
        
        paperLabel.text = @"脊柱侧弯是怎么样一种病？是怎么引起的？为什么青少年多发？";
        paperLabel.textColor = COLOR_TITLE;
        
        UILabel *paperDate = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 13)];
        paperDate.text = @"2012.10";
        paperDate.textColor = COLOR_NOTICE;
        paperDate.font = FONT_(12);
        [paper addSubview:paperDate];
        
        UILabel *paperName = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-100, 70, 100, 13)];
        paperName.text = @"《骨科研究》";
        paperName.textColor = COLOR_NOTICE;
        paperName.font = FONT_(12);
        paperName.textAlignment = NSTextAlignmentRight;
        [paper addSubview:paperName];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 94.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = HEXColor(0xe7eaf3);
        [paper addSubview:lineView];
    }
    
    offsetY += paperCount * 95;
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, offsetY);
}

- (void)setupFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45)];
    footerView.backgroundColor = HEXColor(0xf5f5f5);
    [self.view addSubview:footerView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = HEXColor(0xcbd1dd);
    [footerView addSubview:lineView];
    
    UIButton *focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    focusBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 45);
    [focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [focusBtn setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    focusBtn.titleLabel.font = FONT_(13);
    [focusBtn addTarget:self action:@selector(focusClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:focusBtn];
    
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 16, 0.5, 13)];
    sepView.backgroundColor = HEXColor(0xccd2de);
    [footerView addSubview:sepView];
    
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 45);
    [msgBtn setTitle:@"留言咨询" forState:UIControlStateNormal];
    [msgBtn setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    msgBtn.titleLabel.font = FONT_(13);
    [msgBtn addTarget:self action:@selector(msgClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:msgBtn];
}

- (void)gotoDocInfoVC
{
    DoctorInfoViewController *docInfoVC = [DoctorInfoViewController new];
    [self.navigationController pushViewController:docInfoVC animated:YES];
}

- (void)gotoDocWorkTimeVC
{
    DoctorWorkTimeViewController *workTimeVC = [DoctorWorkTimeViewController new];
    [self.navigationController pushViewController:workTimeVC animated:YES];
}

- (void)focusClick:(UIButton *)sender
{
    
}

- (void)msgClick:(UIButton *)sender
{
    
}

@end
