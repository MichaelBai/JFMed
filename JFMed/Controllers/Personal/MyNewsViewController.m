//
//  MyNewsViewController.m
//  JFMed
//
//  Created by Michael on 8/9/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "MyNewsViewController.h"
#import "NewsTableViewCell.h"
#import "HomeModel.h"

@interface MyNewsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *newsArray;

@end

@implementation MyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"收藏的文章";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    
    [NETWORK postWithApiPath:@"news/list" requestParams:nil handler:^(id response, NSError *error, BOOL updatePage) {
        if (error) {
            [self.view showToast:error.userInfo[kErrorUserInfoMsgKey]];
        } else {
            self.newsArray = [NSMutableArray array];
            [response[@"news_list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeNews *news = [[HomeNews alloc] initWithDictionary:obj error:nil];
                [self.newsArray addObject:news];
            }];
            [tableView reloadData];
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
        cell.isViewMode = YES;
    }
    [cell setDataWithNews:self.newsArray[indexPath.row]];
    return cell;
}

@end
