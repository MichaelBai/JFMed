//
//  NewsViewController.m
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "NewsViewController.h"
#import "MBTabView.h"
#import "NewsTableViewCell.h"
#import "HomeModel.h"

@interface NewsViewController () <UITableViewDelegate, UITableViewDataSource, MBTabViewButtonClickDelegate>

@property (nonatomic, strong) MBTabView *tabView;
@property (nonatomic, strong) NSMutableArray *tableViews;

@property (nonatomic, strong) NSMutableArray *newsArray;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"资讯";
    
    UIView *placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_HEIGHT)];
    [self.view addSubview:placeholderView];
    
    _tabView = [[MBTabView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 40)];
    _tabView.titles = @[@"头条资讯", @"头条资讯", @"头条资讯", @"头条资讯"];
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
    
    [NETWORK postWithApiPath:@"news/list" requestParams:nil handler:^(id response, NSError *error, BOOL updatePage) {
        if (error) {
            
        } else {
            self.newsArray = [NSMutableArray array];
            
            [response[@"news_list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeNews *news = [[HomeNews alloc] initWithDictionary:obj error:nil];
                [self.newsArray addObject:news];
            }];
            [_tableViews makeObjectsPerformSelector:@selector(reloadData)];
        }
    }];
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

#pragma mark - MBTabViewButtonClickDelegate

- (void)MBTabView:(MBTabView *)view didClickButtonAtIndex:(NSInteger)idx
{
    [self.view bringSubviewToFront:self.tableViews[idx]];
}

@end
