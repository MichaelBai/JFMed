//
//  DoctorsViewController.m
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "DoctorsViewController.h"
#import "MBTabView.h"
#import "DoctorTableViewCell.h"

@interface DoctorsViewController () <UITableViewDelegate, UITableViewDataSource, MBTabViewButtonClickDelegate>

@property (nonatomic, strong) MBTabView *tabView;
@property (nonatomic, strong) NSMutableArray *tableViews;

@end

@implementation DoctorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"资讯";
    
    UIView *placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_HEIGHT)];
    [self.view addSubview:placeholderView];
    
    _tabView = [[MBTabView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 40)];
    _tabView.titles = @[@"骨科医生", @"皮肤科医生", @"骨科医生"];
    [self.view addSubview:_tabView];
    
    _tableViews = [NSMutableArray array];
    for (int i = 0; i < _tabView.titles.count; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT + _tabView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - _tabView.frame.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [_tableViews addObject:tableView];
    }
    [self.view bringSubviewToFront:_tableViews.firstObject];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DoctorTableViewCell CellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell setData];
    return cell;
}

#pragma mark - MBTabViewButtonClickDelegate

- (void)MBTabView:(MBTabView *)view didClickButtonAtIndex:(NSInteger)idx
{
    [self.view bringSubviewToFront:self.tableViews[idx]];
}

@end
