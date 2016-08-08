//
//  PersonalViewController.m
//  JFMed
//
//  Created by Michael on 7/30/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import "PersonalEditViewController.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"

@interface PersonalViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)gotoPersonalEdit
{
    PersonalEditViewController *personalEditVC = [[PersonalEditViewController alloc] init];
    [self.navigationController pushViewController:personalEditVC animated:YES];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 95;
    } else {
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 95)];
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 65, 65)];
        [avatar sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"avatar"]];
        [headerView addSubview:avatar];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 25, 180, 20)];
        nameLabel.textColor = HEXColor(0x555c70);
        nameLabel.font = FONT_(18);
        nameLabel.text = @"满天飞雪";
        [headerView addSubview:nameLabel];
        UILabel *birthLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 180, 16)];
        birthLabel.textColor = HEXColor(0x535e6f);
        birthLabel.font = FONT_(15);
        birthLabel.text = @"2002年10月12日";
        [headerView addSubview:birthLabel];
        UIButton *modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        modifyBtn.frame = CGRectMake(SCREEN_WIDTH - 40 - 10, 22.5, 40, 50);
        [modifyBtn setTitle:@"修改" forState:UIControlStateNormal];
        modifyBtn.titleLabel.font = FONT_(13);
        [modifyBtn setTitleColor:HEXColor(0x818895) forState:UIControlStateNormal];
        [modifyBtn setImage:[UIImage imageNamed:@"personal_modify"] forState:UIControlStateNormal];
        [modifyBtn setImage:[UIImage imageNamed:@"personal_modify"] forState:UIControlStateHighlighted];
        modifyBtn.imageEdgeInsets = UIEdgeInsetsMake(-15, 0, 0, 0);
        modifyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -32, -30, 0);
        [modifyBtn addTarget:self action:@selector(gotoPersonalEdit) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:modifyBtn];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 94.5, SCREEN_WIDTH, 0.5)];
        [headerView addSubview:lineView];
        lineView.backgroundColor = HEXColor(0xe5ecf2);
        return headerView;
    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        headerView.backgroundColor = COLOR_BACKGROUND;
        return headerView;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[PersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.icon.image = [UIImage imageNamed:@"personal_icon_1"];
            cell.titleLabel.text = @"自查记录";
        } else if (indexPath.row == 1) {
            cell.icon.image = [UIImage imageNamed:@"personal_icon_2"];
            cell.titleLabel.text = @"关注的医生";
        } else if (indexPath.row == 2) {
            cell.icon.image = [UIImage imageNamed:@"personal_icon_3"];
            cell.titleLabel.text = @"收藏的文章";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.icon.image = [UIImage imageNamed:@"personal_icon_4"];
            cell.titleLabel.text = @"通知推送";
        } else if (indexPath.row == 1) {
            cell.icon.image = [UIImage imageNamed:@"personal_icon_5"];
            cell.titleLabel.text = @"清理缓存";
        } else if (indexPath.row == 2) {
            cell.icon.image = [UIImage imageNamed:@"personal_icon_6"];
            cell.titleLabel.text = @"检查新版本";
        } else if (indexPath.row == 3) {
            cell.icon.image = [UIImage imageNamed:@"personal_icon_7"];
            cell.titleLabel.text = @"意见反馈";
        } else if (indexPath.row == 4) {
            cell.icon.image = [UIImage imageNamed:@"personal_icon_8"];
            cell.titleLabel.text = @"关于";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1) {
            
        } else if (indexPath.row == 2) {
            
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1) {
            
        } else if (indexPath.row == 2) {
            
        } else if (indexPath.row == 3) {
            FeedbackViewController *feebackVC = [FeedbackViewController new];
            [self.navigationController pushViewController:feebackVC animated:YES];
        } else if (indexPath.row == 4) {
            AboutViewController *aboutVC = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
    }
}

@end
