//
//  PersonalEditViewController.m
//  JFMed
//
//  Created by Michael on 7/30/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "PersonalEditViewController.h"
#import "PersonalTableViewCell.h"

@interface PersonalEditViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PersonalEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人信息";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 95;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 95)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 95)];
    titleLabel.textColor = COLOR_NAV;
    titleLabel.font = FONT_(16);
    titleLabel.text = @"头像";
    [headerView addSubview:titleLabel];
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-45-65, 15, 65, 65)];
    [avatar sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"avatar"]];
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    avatar.layer.cornerRadius = 65.0/2;
    avatar.layer.masksToBounds = YES;
    [headerView addSubview:avatar];
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-10, 40, 10, 15)];
    [headerView addSubview:arrowView];
    arrowView.image = [UIImage imageNamed:@"arrow"];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 94.5, SCREEN_WIDTH, 0.5)];
    [headerView addSubview:lineView];
    lineView.backgroundColor = COLOR_LINE;
    [headerView addTapAction:@selector(changeAvatar:) target:self];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 44)];
    titleLabel.textColor = COLOR_NAV;
    titleLabel.font = FONT_(16);
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-45-200, 0, 200, 44)];
    subTitleLabel.textColor = COLOR_NAV;
    subTitleLabel.font = FONT_(12);
    subTitleLabel.textAlignment = NSTextAlignmentRight;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.contentView addSubview:titleLabel];
        [cell.contentView addSubview:subTitleLabel];
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-10, 14.5, 10, 15)];
        [cell.contentView addSubview:arrowView];
        arrowView.image = [UIImage imageNamed:@"arrow"];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
        [cell.contentView addSubview:lineView];
        lineView.backgroundColor = COLOR_LINE;
    }
    if (indexPath.row == 0) {
        titleLabel.text = @"昵称";
        subTitleLabel.text = @"漫天飞雪";
    } else if (indexPath.row == 1) {
        titleLabel.text = @"性别";
        subTitleLabel.text = @"男";
    } else if (indexPath.row == 2) {
        titleLabel.text = @"生日";
        subTitleLabel.text = @"2002年10月12日";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        
    }
}

- (void)changeAvatar:(id)sender
{
    
}

@end
