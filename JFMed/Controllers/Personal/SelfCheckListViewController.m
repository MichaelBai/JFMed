//
//  SelfCheckListViewController.m
//  JFMed
//
//  Created by Michael on 8/9/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "SelfCheckListViewController.h"
#import "SelfCheckTableViewCell.h"

@interface SelfCheckListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *results;

@end

@implementation SelfCheckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    NSDictionary *params = @{@"phone":@"18533675226"};
    if (kAppDelegate.userInfo.phone) {
        params = @{@"phone":kAppDelegate.userInfo.phone};
    }
    [NETWORK postWithApiPath:@"jifeng/api/accounts/zicha_list.do" requestParams:params handler:^(id response, NSError *error, BOOL updatePage) {
        if (error) {
            [self.view showToast:error.userInfo[kErrorUserInfoMsgKey]];
        } else {
            self.results = [NSMutableArray array];
            [response[@"news_list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                HomeNews *news = [[HomeNews alloc] initWithDictionary:obj error:nil];
//                [self.results addObject:news];
            }];
            [tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SelfCheckTableViewCell CellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelfCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[SelfCheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectBtn.hidden = YES;
    }
    [cell setData];
    return cell;
}

@end
