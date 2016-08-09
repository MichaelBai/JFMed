//
//  MyDoctorsViewController.m
//  JFMed
//
//  Created by Michael on 8/9/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "MyDoctorsViewController.h"
#import "DoctorTableViewCell.h"
#import "Doctor.h"

@interface MyDoctorsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *doctors;

@end

@implementation MyDoctorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关注的医生";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    self.doctors = [NSMutableArray array];
    [[NetworkCenter sharedCenter] postWithApiPath:@"doctor/list" requestParams:nil handler:^(id response, NSError *error, BOOL updatePage) {
        if (error) {
            [self.view showToast:error.userInfo[kErrorUserInfoMsgKey]];
        } else {
            [response[@"doctor_list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                Doctor *doc = [[Doctor alloc] initWithDictionary:obj error:nil];
                [self.doctors addObject:doc];
            }];
            [tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DoctorTableViewCell CellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.doctors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.isViewMode = YES;
    }
    [cell setDataWithDoctor:self.doctors[indexPath.row]];
    return cell;
}

@end
